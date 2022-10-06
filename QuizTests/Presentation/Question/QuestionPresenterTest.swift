//
//  QuestionPresenterTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 27.09.2022.
//

import XCTest
import BasicQuizDomain
@testable import Quiz

final class QuestionPresenterTest: XCTestCase {

	let question1 = Question.singleAnswer("Q1")
	let question2 = Question.multipleAnswer("Q2")

	func test_title_forFirstQuestion_formatsTitileForIndex() {
		let sut = QuestionPresenter(questions: [question1, question2], question: question1)

		XCTAssertEqual(sut.title, "1 of 2")
	}

	func test_title_forSecondQuestion_formatsTitileForIndex() {
		let sut = QuestionPresenter(questions: [question1, question2], question: question2)

		XCTAssertEqual(sut.title, "2 of 2")
	}

	func test_title_forUnexistentQuestion_isEmpty() {
		let sut = QuestionPresenter(questions: [], question: Question.singleAnswer("Q1"))

		XCTAssertEqual(sut.title, "")
	}

}
