//
//  QuestionTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import XCTest
@testable import Quiz

final class QuestionTest: XCTestCase {

	func test_hashInto_singleAnswer_returnTypeHash() {
		let type = "a string"

		let sut = Question.singleAnswer(type)

		XCTAssertEqual(sut.hashValue, type.hashValue)
	}

	func test_hashInto_multipleAnswer_returnTypeHash() {
		let type = "a string"

		let sut = Question.multipleAnswer(type)

		XCTAssertEqual(sut.hashValue, type.hashValue)
	}

	func test_equal_isEqual() {
		XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
		XCTAssertEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("a string"))
	}

	func test_notEqual_isNotEqual() {
		XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
		XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("another string"))
		XCTAssertNotEqual(Question.singleAnswer("a string"), Question.multipleAnswer("a string"))
		XCTAssertNotEqual(Question.singleAnswer("a string"), Question.multipleAnswer("another string"))
	}

}
