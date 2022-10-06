//
//  BasicQuizBuilderTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 06.10.2022.
//

import XCTest
import BasicQuizDomain

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
		assert(
			try BasicQuizBuilder(
				singleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O1", tail: ["O1", "O3"]),
				answer: "O1"
			),
			throws: .duplicateOptions(["O1", "O1", "O3"])
		)
	}

	func test_initWithSingleAnswerQuestion_missingAnswerInOptions_throw() throws {
		assert(
			try BasicQuizBuilder(
				singleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
				answer: "O4"
			),
			throws: .missingAnswerOptions(answer: ["O4"], options: ["O1", "O2", "O3"])
		)
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

		assert(
			try sut.add(
				singleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O4", "O6"]),
				answer: "O4"
			),
			throws: .duplicateOptions(["O4", "O4", "O6"])
		)
	}

	func test_addSingleAnswerQuestion_missingAnswerInOptions_throw() throws {
		var sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)

		assert(
			try sut.add(
				singleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: "O7"
			),
			throws: .missingAnswerOptions(answer: ["O7"], options: ["O4", "O5", "O6"])
		)
	}

	func test_addSingleAnswerQuestion_duplicateQuestion_throw() throws {
		var sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)

		assert(
			try sut.add(
				singleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: "O4"
			),
			throws: .duplicateQuestion(.singleAnswer("Q1"))
		)
	}

	func test_addingSingleAnswerQuestion() throws {
		let sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		).adding(
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

	func test_addingSingleAnswerQuestion_duplicateOptions_throw() throws {
		let sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)

		assert(
			try sut.adding(
				singleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O4", "O6"]),
				answer: "O4"
			),
			throws: .duplicateOptions(["O4", "O4", "O6"])
		)
	}

	func test_addingSingleAnswerQuestion_missingAnswerInOptions_throw() throws {
		let sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)

		assert(
			try sut.adding(
				singleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: "O7"
			),
			throws: .missingAnswerOptions(answer: ["O7"], options: ["O4", "O5", "O6"])
		)
	}

	func test_addingSingleAnswerQuestion_duplicateQuestion_throw() throws {
		let sut = try BasicQuizBuilder(
			singleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: "O1"
		)

		assert(
			try sut.adding(
				singleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: "O4"
			),
			throws: .duplicateQuestion(.singleAnswer("Q1"))
		)
	}

	func test_initWithMultipleAnswerQuestion() throws {
		let sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		)
		let result = sut.build()

		XCTAssertEqual(result.questions, [.multipleAnswer("Q1")])
		XCTAssertEqual(result.options, [.multipleAnswer("Q1"): ["O1", "O2", "O3"]])
		assertEqual(result.correctAnswers, [(.multipleAnswer("Q1"), ["O1", "O2"])])
	}

	func test_initWithMultipleAnswerQuestion_duplicateOptions_throw() throws {
		assert(
			try BasicQuizBuilder(
				multipleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O1", tail: ["O1", "O3"]),
				answer: .init(head: "O1", tail: ["O2"])
			),
			throws: .duplicateOptions(["O1", "O1", "O3"])
		)
	}

	func test_initWithMultipleAnswerQuestion_missingAnswerInOptions_throw() throws {
		assert(
			try BasicQuizBuilder(
				multipleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
				answer: .init(head: "O4", tail: [])
			),
			throws: .missingAnswerOptions(answer: ["O4"], options: ["O1", "O2", "O3"])
		)
	}

	func test_addMultipleAnswerQuestion() throws {
		var sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		)
		try sut.add(
			multipleAnswerQuestion: "Q2",
			options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
			answer: .init(head: "O4", tail: ["O5"])
		)
		let result = sut.build()

		XCTAssertEqual(
			result.questions,
			[.multipleAnswer("Q1"), .multipleAnswer("Q2")]
		)
		XCTAssertEqual(
			result.options,
			[.multipleAnswer("Q1"): ["O1", "O2", "O3"], .multipleAnswer("Q2"): ["O4", "O5", "O6"]]
		)
		assertEqual(
			result.correctAnswers,
			[(.multipleAnswer("Q1"), ["O1", "O2"]), (.multipleAnswer("Q2"), ["O4", "O5"])]
		)
	}

	func test_addMultipleAnswerQuestion_duplicateOptions_throw() throws {
		var sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		)

		assert(
			try sut.add(
				multipleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O4", "O6"]),
				answer: .init(head: "O4", tail: ["O5"])
			),
			throws: .duplicateOptions(["O4", "O4", "O6"])
		)
	}

	func test_addMultipleAnswerQuestion_missingAnswerInOptions_throw() throws {
		var sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		)

		assert(
			try sut.add(
				multipleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: .init(head: "O7", tail: [])
			),
			throws: .missingAnswerOptions(answer: ["O7"], options: ["O4", "O5", "O6"])
		)
	}

	func test_addMultipleAnswerQuestion_duplicateQuestion_throw() throws {
		var sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		)

		assert(
			try sut.add(
				multipleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: .init(head: "O4", tail: ["O5"])
			),
			throws: .duplicateQuestion(.multipleAnswer("Q1"))
		)
	}

	func test_addingMultipleAnswerQuestion() throws {
		let sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		).adding(
			multipleAnswerQuestion: "Q2",
			options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
			answer: .init(head: "O4", tail: ["O5"])
		)
		let result = sut.build()

		XCTAssertEqual(
			result.questions,
			[.multipleAnswer("Q1"), .multipleAnswer("Q2")]
		)
		XCTAssertEqual(
			result.options,
			[.multipleAnswer("Q1"): ["O1", "O2", "O3"], .multipleAnswer("Q2"): ["O4", "O5", "O6"]]
		)
		assertEqual(
			result.correctAnswers,
			[(.multipleAnswer("Q1"), ["O1", "O2"]), (.multipleAnswer("Q2"), ["O4", "O5"])]
		)
	}

	func test_addingMultipleAnswerQuestion_duplicateOptions_throw() throws {
		let sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		)

		assert(
			try sut.adding(
				multipleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O4", "O6"]),
				answer: .init(head: "O4", tail: ["O5"])
			),
			throws: .duplicateOptions(["O4", "O4", "O6"])
		)
	}

	func test_addingMultipleAnswerQuestion_missingAnswerInOptions_throw() throws {
		let sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		)

		assert(
			try sut.adding(
				multipleAnswerQuestion: "Q2",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: .init(head: "O7", tail: [])
			),
			throws: .missingAnswerOptions(answer: ["O7"], options: ["O4", "O5", "O6"])
		)
	}

	func test_addingMultipleAnswerQuestion_duplicateQuestion_throw() throws {
		let sut = try BasicQuizBuilder(
			multipleAnswerQuestion: "Q1",
			options: NonEmptyOptions(head: "O1", tail: ["O2", "O3"]),
			answer: .init(head: "O1", tail: ["O2"])
		)

		assert(
			try sut.adding(
				multipleAnswerQuestion: "Q1",
				options: NonEmptyOptions(head: "O4", tail: ["O5", "O6"]),
				answer: .init(head: "O4", tail: ["O5"])
			),
			throws: .duplicateQuestion(.multipleAnswer("Q1"))
		)
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

	func assert<T>(
		_ expression: @autoclosure () throws -> T,
		throws expectedError: BasicQuizBuilder.AddingError,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		XCTAssertThrowsError(try expression()) { error in
			XCTAssertEqual(
				error as? BasicQuizBuilder.AddingError,
				expectedError,
				file: file,
				line: line
			)
		}
	}

}
