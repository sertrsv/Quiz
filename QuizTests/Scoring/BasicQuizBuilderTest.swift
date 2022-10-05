//
//  BasicQuizBuilderTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 06.10.2022.
//

import XCTest
import QuizEngine

struct BasicQuiz {
	let questions: [Question<String>]
	let options: [Question<String>: [String]]
}

struct NonEmptyOptions {
	let head: String
	let tail: [String]
}

struct BasicQuizBuilder {
	private let questions: [Question<String>]
	private let options: [Question<String>: [String]]

	init(singleAnswerQuestion: String, options: NonEmptyOptions) {
		let question = Question.singleAnswer(singleAnswerQuestion)
		self.questions = [question]
		self.options = [question: [options.head] + options.tail]
	}

	func build() -> BasicQuiz {
		BasicQuiz(questions: questions, options: options)
	}
}

final class BasicQuizBuilderTest: XCTestCase {

    func test_initWithSingleAnswerQuestion() {
		let sut = BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"])
		)
		let result = sut.build()

		XCTAssertEqual(result.questions, [.singleAnswer("Q1")])
		XCTAssertEqual(result.options, [.singleAnswer("Q1"): ["O1", "O2", "O3"]])
    }

}
