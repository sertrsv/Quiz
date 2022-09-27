//
//  iOSViewControllerFactoryTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import XCTest
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

	// MARK: Helpers

	func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
		return iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options)
	}

	func makeQuestionViewController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
		return makeSUT(options: [question: options]).questionViewController(
			for: question,
			answerCallback: { _ in }
		) as! QuestionViewController
	}

}
