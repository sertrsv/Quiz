//
//  iOSViewControllerFactoryTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import XCTest
import QuizEngine
@testable import Quiz

final class iOSViewControllerFactoryTest: XCTestCase {

	let singleAnswerQuestion = Question.singleAnswer("Q1")
	let multipleAnswerQuestion = Question.multipleAnswer("Q2")
	let options = ["A1", "A2"]

	func test_questionViewController_singleAnswer_createsControllerWithTitle() {
		let presenter = QuestionPresenter(
			questions: [singleAnswerQuestion, multipleAnswerQuestion],
			question: singleAnswerQuestion
		)
		XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).title, presenter.title)
	}

	func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
		XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).question, "Q1")
	}

	func test_questionViewController_singleAnswer_createsControllerWithOptions() {
		XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).options, options)
	}

	func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
		XCTAssertFalse(makeQuestionViewController(question: singleAnswerQuestion).allowsMultipleSelection)
	}

	func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
		let presenter = QuestionPresenter(
			questions: [singleAnswerQuestion, multipleAnswerQuestion],
			question: multipleAnswerQuestion
		)
		XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).title, presenter.title)
	}

	func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
		XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).question, "Q2")
	}

	func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
		XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).options, options)
	}

	func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {
		XCTAssertTrue(makeQuestionViewController(question: multipleAnswerQuestion).allowsMultipleSelection)
	}

	func test_resultsViewController_createControllerWithTitle() {
		let results = makeResults()

		XCTAssertEqual(results.controller.title, results.presenter.title)
	}

	func test_resultsViewController_createControllerWithSummary() {
		let results = makeResults()

		XCTAssertEqual(results.controller.summary, results.presenter.summary)
	}

	func test_resultsViewController_createControllerWithPresentableAnswers() {
		let results = makeResults()

		XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
	}

	// MARK: Helpers

	func makeSUT(
		options: [Question<String>: [String]] = [:],
		correctAnswers: [Question<String>: [String]] = [:]
	) -> iOSViewControllerFactory {
		return iOSViewControllerFactory(
			questions: [singleAnswerQuestion, multipleAnswerQuestion],
			options: options,
			correctAnswers: correctAnswers
		)
	}

	func makeSUT(
		options: [Question<String>: [String]] = [:],
		correctAnswers: [(Question<String>, [String])] = []
	) -> iOSViewControllerFactory {
		return iOSViewControllerFactory(options: options, correctAnswers: correctAnswers)
	}

	func makeQuestionViewController(
		question: Question<String> = Question.singleAnswer("")
	) -> QuestionViewController {
		return makeSUT(options: [question: options], correctAnswers: [:]).questionViewController(
			for: question,
			answerCallback: { _ in }
		) as! QuestionViewController
	}

	func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
		let usersAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1", "A2"])]
		let correctAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1", "A2"])]

		let result = Result(
			answers: [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]],
			score: 2
		)

		let presenter = ResultsPresenter(
			userAnswers: usersAnswers,
			correctAnswers: correctAnswers,
			scorer: { _, _ in result.score }
		)
		let sut = makeSUT(correctAnswers: correctAnswers)

		let controller = sut.resultsViewController(for: result) as! ResultsViewController

		return (controller, presenter)
	}

}
