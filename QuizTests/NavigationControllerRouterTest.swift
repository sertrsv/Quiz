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

	let navigationController = NonAnimatedNavigationController()
	let factory = ViewControllerFactoryStub()

	lazy var sut: NavigationControllerRouter = {
		NavigationControllerRouter(self.navigationController, factory: self.factory)
	}()

	func test_routeToSecondQuestion_showsQuestionController() {
		let viewController = UIViewController()
		let secondViewController = UIViewController()
		factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
		factory.stub(question: Question.singleAnswer("Q2"), with: secondViewController)

		sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
		sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })

		XCTAssertEqual(navigationController.viewControllers.count, 2)
		XCTAssertEqual(navigationController.viewControllers.first, viewController)
		XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
	}

	func test_routeToQuestion_presentsQuestionControllerWithRightCallback() {
		var callbackWasFired = false

		sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callbackWasFired = true })
		factory.answerCallback[Question.singleAnswer("Q1")]!(["anything"])

		XCTAssertTrue(callbackWasFired)
	}

	func test_routeToResult_showsResultController() {
		let viewController = UIViewController()
		let result = Result(answers: [Question.singleAnswer("Q1"): ["A1"]], score: 10)

		let secondViewController = UIViewController()
		let secondResult = Result(answers: [Question.singleAnswer("Q2"): ["A2"]], score: 20)

		factory.stub(result: result, with: viewController)
		factory.stub(result: secondResult, with: secondViewController)

		sut.routeTo(result: result)
		sut.routeTo(result: secondResult)

		XCTAssertEqual(navigationController.viewControllers.count, 2)
		XCTAssertEqual(navigationController.viewControllers.first, viewController)
		XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
	}

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

		func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
			self.answerCallback[question] = answerCallback
			return stubbedQuestions[question] ?? UIViewController()
		}

		func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
			return stubbedResults[result] ?? UIViewController()
		}
	}

}
