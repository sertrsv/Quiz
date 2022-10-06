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
	let correctAnswers: [(Question<String>, [String])]
}

struct NonEmptyOptions {
	let head: String
	let tail: [String]

	var all: [String] {
		[head] + tail
	}
}

struct BasicQuizBuilder {
	private var questions: [Question<String>]
	private var options: [Question<String>: [String]]
	private var correctAnswers: [(Question<String>, [String])]

	enum AddingError: Equatable, Error {
		case duplicateOptions([String])
		case missingAnswerOptions(answer: [String], options: [String])
	}

	init(singleAnswerQuestion: String, options: NonEmptyOptions, answer: String) throws {
		let allOptions = options.all

		guard allOptions.contains(answer) else {
			throw AddingError.missingAnswerOptions(answer: [answer], options: allOptions)
		}

		guard Set(allOptions).count == allOptions.count else {
			throw AddingError.duplicateOptions(allOptions)
		}

		let question = Question.singleAnswer(singleAnswerQuestion)
		self.questions = [question]
		self.options = [question: allOptions]
		self.correctAnswers = [(question, [answer])]
	}

	mutating func add(singleAnswerQuestion: String, options: NonEmptyOptions, answer: String) throws {
		let allOptions = options.all

		guard allOptions.contains(answer) else {
			throw AddingError.missingAnswerOptions(answer: [answer], options: allOptions)
		}

		guard Set(allOptions).count == allOptions.count else {
			throw AddingError.duplicateOptions(allOptions)
		}

		let question = Question.singleAnswer(singleAnswerQuestion)
		self.questions += [question]
		self.options[question] = allOptions
		self.correctAnswers += [(question, [answer])]
	}

	func build() -> BasicQuiz {
		BasicQuiz(questions: questions, options: options, correctAnswers: correctAnswers)
	}
}

final class BasicQuizBuilderTest: XCTestCase {

    func test_initWithSingleAnswerQuestion() throws {
		let sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)
		let result = sut.build()

		XCTAssertEqual(result.questions, [.singleAnswer("Q1")])
		XCTAssertEqual(result.options, [.singleAnswer("Q1"): ["O1", "O2", "O3"]])
		assertEqual(result.correctAnswers, [(.singleAnswer("Q1"), ["O1"])])
	}

	func test_initWithSingleAnswerQuestion_duplicateOptions_throw() throws {
		XCTAssertThrowsError(
			try BasicQuizBuilder(
				singleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O1", tail: ["O1", "O3"]),
				answer: "O1"
			)
		) { error in
			XCTAssertEqual(
				error as? BasicQuizBuilder.AddingError,
				BasicQuizBuilder.AddingError.duplicateOptions(["O1", "O1", "O3"])
			)
		}
	}

	func test_initWithSingleAnswerQuestion_missingAnswerInOptions_throw() throws {
		XCTAssertThrowsError(
			try BasicQuizBuilder(
				singleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
				answer: "O4"
			)
		) { error in
			XCTAssertEqual(
				error as? BasicQuizBuilder.AddingError,
				BasicQuizBuilder.AddingError.missingAnswerOptions(answer: ["O4"], options: ["O1", "O2", "O3"])
			)
		}
	}

	func test_addSingleAnswerQuestion() throws {
		var sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)
		try sut.add(
			singleAnswerQuestion: "Q2",
			options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
			answer: "O4"
		)
		let result = sut.build()

		XCTAssertEqual(
			result.questions,
			[.singleAnswer("Q1"), .singleAnswer("Q2")]
		)
		XCTAssertEqual(
			result.options,
			[.singleAnswer("Q1"): ["O1", "O2", "O3"], .singleAnswer("Q2"): ["O4", "O5", "O6"]]
		)
		assertEqual(
			result.correctAnswers,
			[(.singleAnswer("Q1"), ["O1"]), (.singleAnswer("Q2"), ["O4"])]
		)
	}

	func test_addSingleAnswerQuestion_duplicateOptions_throw() throws {
		var sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)

		XCTAssertThrowsError(
			try sut.add(
				singleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O4", "O6"]),
				answer: "O4"
			)
		) { error in
			XCTAssertEqual(
				error as? BasicQuizBuilder.AddingError,
				BasicQuizBuilder.AddingError.duplicateOptions(["O4", "O4", "O6"])
			)
		}
	}

	func test_addSingleAnswerQuestion_missingAnswerInOptions_throw() throws {
		var sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)

		XCTAssertThrowsError(
			try sut.add(
				singleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: "O7"
			)
		) { error in
			XCTAssertEqual(
				error as? BasicQuizBuilder.AddingError,
				BasicQuizBuilder.AddingError.missingAnswerOptions(answer: ["O7"], options: ["O4", "O5", "O6"])
			)
		}
	}

	// MARK: Helpers

	private func assertEqual(
		_ a1: [(Question<String>, [String])],
		_ a2: [(Question<String>, [String])],
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		XCTAssertTrue(
			a1.elementsEqual(a2, by: ==),
			"\(a1) is not equal to \(a2)",
			file: file,
			line: line
		)
	}

}
