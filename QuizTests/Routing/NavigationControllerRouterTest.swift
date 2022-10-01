//
//  NavigationControllerRouterTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 25.09.2022.
//

import XCTest
import QuizEngine
@testable import Quiz

final class NavigationControllerRouterTest: XCTestCase {

	let singleAnswerQuestion = Question.singleAnswer("Q1")
	let multipleAnswerQuestion = Question.multipleAnswer("Q1")

	let navigationController = NonAnimatedNavigationController()
	let factory = ViewControllerFactoryStub()

	lazy var sut: NavigationControllerRouter = {
		NavigationControllerRouter(self.navigationController, factory: self.factory)
	}()

	func test_answerForQuestion_showsQuestionController() {
		let viewController = UIViewController()
		let secondViewController = UIViewController()
		factory.stub(question: singleAnswerQuestion, with: viewController)
		factory.stub(question: multipleAnswerQuestion, with: secondViewController)

		sut.answer(for: singleAnswerQuestion, completion: { _ in })
		sut.answer(for: multipleAnswerQuestion, completion: { _ in })

		XCTAssertEqual(navigationController.viewControllers.count, 2)
		XCTAssertEqual(navigationController.viewControllers.first, viewController)
		XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
	}

	func test_answerForQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
		var callbackWasFired = false
		sut.answer(for: singleAnswerQuestion, completion: { _ in callbackWasFired = true })

		factory.answerCallback[singleAnswerQuestion]!(["anything"])

		XCTAssertTrue(callbackWasFired)
	}

	func test_answerForQuestion_singleAnswer_configuresViewControllerWithoutSubmitButton() {
		let viewController = UIViewController()
		factory.stub(question: singleAnswerQuestion, with: viewController)

		sut.answer(for: singleAnswerQuestion, completion: { _ in })

		XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
	}

	func test_answerForQuestion_multipleAnswer_answerCallback_doesNotProgressesToNextQuestion() {
		var callbackWasFired = false
		sut.answer(for: multipleAnswerQuestion, completion: { _ in callbackWasFired = true })

		factory.answerCallback[multipleAnswerQuestion]!(["anything"])

		XCTAssertFalse(callbackWasFired)
	}

	func test_answerForQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {
		let viewController = UIViewController()
		factory.stub(question: multipleAnswerQuestion, with: viewController)

		sut.answer(for: multipleAnswerQuestion, completion: { _ in })

		XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
	}

	func test_answerForQuestion_multipleAnswerSubmitButton_isDisabledWhenZeroAnswersSelected() {
		let viewController = UIViewController()
		factory.stub(question: multipleAnswerQuestion, with: viewController)

		sut.answer(for: multipleAnswerQuestion, completion: { _ in })
		XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

		factory.answerCallback[multipleAnswerQuestion]!(["A1"])
		XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)

		factory.answerCallback[multipleAnswerQuestion]!([])
		XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
	}

	func test_answerForQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {
		let viewController = UIViewController()
		factory.stub(question: multipleAnswerQuestion, with: viewController)

		var callbackWasFired = false
		sut.answer(for: multipleAnswerQuestion, completion: { _ in callbackWasFired = true })

		factory.answerCallback[multipleAnswerQuestion]!(["A1"])
		viewController.navigationItem.rightBarButtonItem?.simulateTap()

		XCTAssertTrue(callbackWasFired)
	}

	func test_routeToResult_showsResultController() {
		let viewController = UIViewController()
		let result = Result(answers: [singleAnswerQuestion: ["A1"]], score: 10)

		let secondViewController = UIViewController()
		let secondResult = Result(answers: [multipleAnswerQuestion: ["A2"]], score: 20)

		factory.stub(result: result, with: viewController)
		factory.stub(result: secondResult, with: secondViewController)

		sut.routeTo(result: result)
		sut.routeTo(result: secondResult)

		XCTAssertEqual(navigationController.viewControllers.count, 2)
		XCTAssertEqual(navigationController.viewControllers.first, viewController)
		XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
	}

	// MARK: Helpers

	class NonAnimatedNavigationController: UINavigationController {
		override func pushViewController(_ viewController: UIViewController, animated: Bool) {
			super.pushViewController(viewController, animated: false)
		}
	}

	class ViewControllerFactoryStub: ViewControllerFactory {
		private var stubbedQuestions = [Question<String>: UIViewController]()
		private var stubbedResults = [Result<Question<String>, [String]>: UIViewController]()
		var answerCallback = [Question<String>: ([String]) -> Void]()

		func stub(question: Question<String>, with viewController: UIViewController) {
			stubbedQuestions[question] = viewController
		}

		func stub(result: Result<Question<String>, [String]>, with viewController: UIViewController) {
			stubbedResults[result] = viewController
		}

		func questionViewController(
			for question: Question<String>,
			answerCallback: @escaping ([String]) -> Void
		) -> UIViewController {
			self.answerCallback[question] = answerCallback
			return stubbedQuestions[question] ?? UIViewController()
		}

		func resultsViewController(for answers: Answers) -> UIViewController {
			return UIViewController()
		}

		func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
			return stubbedResults[result] ?? UIViewController()
		}
	}

}

private extension UIBarButtonItem {
	func simulateTap() {
		target?.performSelector(onMainThread: self.action!, with: nil, waitUntilDone: true)
	}
}
