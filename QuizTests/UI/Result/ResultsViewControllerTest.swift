//
//  ResultsViewControllerTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 25.09.2022.
//

import XCTest
@testable import Quiz

final class ResultsViewControllerTest: XCTestCase {

    func test_viewDidLoad_renderSummary() throws {
		XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
	}

	func test_viewDidLoad_rendersAnswers() throws {
		XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
		XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
	}

	func test_viewDidLoad_withCorrectAnswer_renderCorrectAnswerCell() throws {
		let sut = makeSUT(answers: [makeAnswer()])

		let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

		XCTAssertNotNil(cell)
	}

	func test_viewDidLoad_withCorrectAnswer_configureCell() throws {
		let answer = makeAnswer(question: "Q1", answer: "A1")
		let sut = makeSUT(answers: [answer])

		let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

		XCTAssertNotNil(cell)
		XCTAssertEqual(cell?.questionLabel.text, "Q1")
		XCTAssertEqual(cell?.answerLabel.text, "A1")
	}

	func test_viewDidLoad_withWrongAnswer_configureCell() throws {
		let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "A2")
		let sut = makeSUT(answers: [answer])

		let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

		XCTAssertNotNil(cell)
		XCTAssertEqual(cell?.questionLabel.text, "Q1")
		XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
		XCTAssertEqual(cell?.wrongAnswerLabel.text, "A2")
	}

	// MARK: Helpers

	func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
		let sut = ResultsViewController(summary: summary, answers: answers)
		_ = sut.view
		return sut
	}

	func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
		return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
	}

}
