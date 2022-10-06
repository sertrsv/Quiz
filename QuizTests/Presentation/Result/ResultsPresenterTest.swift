//
//  ResultsPresenterTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 27.09.2022.
//

import XCTest
import BasicQuizDomain
@testable import Quiz

final class ResultsPresenterTest: XCTestCase {

	func test_title_returnsFormattedTitle() {
		XCTAssertEqual(makeSUT().title, "Result")
	}

	func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
		let userAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A2", "A3"])]
		let correctAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A2"])]

		let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers, score: 1)

		XCTAssertEqual(sut.summary, "You got 1/2 correct")
	}

	func test_presentableAnswers_withoutQuestions_isEmpty() {
		XCTAssertTrue(makeSUT(userAnswers: [], correctAnswers: []).presentableAnswers.isEmpty)
	}

	func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
		let userAnswers = [(singleAnswerQuestion, ["A1"])]
		let correctAnswers = [(singleAnswerQuestion, ["A2"])]

		let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers)

		XCTAssertEqual(sut.presentableAnswers.count, 1)
		XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
		XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
		XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
	}

	func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
		let userAnswers = [(multipleAnswerQuestion, ["A1", "A4"])]
		let correctAnswers = [(multipleAnswerQuestion, ["A2", "A3"])]

		let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers)

		XCTAssertEqual(sut.presentableAnswers.count, 1)
		XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
		XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
		XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
	}

	func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswer() {
		let userAnswers = [(singleAnswerQuestion, ["A1", "A4"]), (multipleAnswerQuestion, ["A2"])]
		let correctAnswers = [(singleAnswerQuestion, ["A1", "A4"]), (multipleAnswerQuestion, ["A2"])]

		let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers)

		XCTAssertEqual(sut.presentableAnswers.count, 2)
		XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
		XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
		XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)

		XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
		XCTAssertEqual(sut.presentableAnswers.last!.answer, "A2")
		XCTAssertNil(sut.presentableAnswers.last!.wrongAnswer)
	}

	// MARK: Helpers

	private let singleAnswerQuestion = Question.singleAnswer("Q1")
	private let multipleAnswerQuestion = Question.multipleAnswer("Q2")

	private func makeSUT(
		userAnswers: ResultsPresenter.Answers = [],
		correctAnswers: ResultsPresenter.Answers = [],
		score: Int = 0
	) -> ResultsPresenter {
		return ResultsPresenter(
			userAnswers: userAnswers,
			correctAnswers: correctAnswers,
			scorer: { _, _ in score }
		)
	}

}
