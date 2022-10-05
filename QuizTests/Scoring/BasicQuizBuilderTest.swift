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

	var all: [String] {
		[head] + tail
	}
}

struct BasicQuizBuilder {
	private let questions: [Question<String>]
	private let options: [Question<String>: [String]]

	enum AddingError: Equatable, Error {
		case duplicateOptions([String])
	}

	init(singleAnswerQuestion: String, options: NonEmptyOptions) throws {
		let allOptions = options.all

		guard Set(allOptions).count == allOptions.count else {
			throw AddingError.duplicateOptions(allOptions)
		}

		let question = Question.singleAnswer(singleAnswerQuestion)
		self.questions = [question]
		self.options = [question: allOptions]
	}

	func build() -> BasicQuiz {
		BasicQuiz(questions: questions, options: options)
	}
}

final class BasicQuizBuilderTest: XCTestCase {

    func test_initWithSingleAnswerQuestion() throws {
		let sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"])
		)
		let result = sut.build()

		XCTAssertEqual(result.questions, [.singleAnswer("Q1")])
		XCTAssertEqual(result.options, [.singleAnswer("Q1"): ["O1", "O2", "O3"]])
	}

	func test_initWithSingleAnswerQuestion_duplicateOptions_throw() throws {
		XCTAssertThrowsError(
			try BasicQuizBuilder(
				singleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O1", tail: ["O1", "O3"])
			)
		) { error in
			XCTAssertEqual(
				error as? BasicQuizBuilder.AddingError,
				BasicQuizBuilder.AddingError.duplicateOptions(["O1", "O1", "O3"])
			)
		}
	}

}
