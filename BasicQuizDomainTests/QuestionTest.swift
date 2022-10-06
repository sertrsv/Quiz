//
//  QuestionTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import XCTest
@testable import BasicQuizDomain

final class QuestionTest: XCTestCase {

	let aValue = UUID()
	let anotherValue = UUID()

	func test_hashInto_withSameWrappedValue_isDifferentForSingleAndMultipleAnswer() {
		XCTAssertNotEqual(
			Question.singleAnswer(aValue).hashValue,
			Question.multipleAnswer(aValue).hashValue
		)
		XCTAssertNotEqual(
			Question.singleAnswer(aValue).hashValue,
			Question.multipleAnswer(anotherValue).hashValue
		)
	}

	func test_hashInto_forSingleAnswer() {
		XCTAssertEqual(
			Question.singleAnswer(aValue).hashValue,
			Question.singleAnswer(aValue).hashValue
		)
		XCTAssertNotEqual(
			Question.singleAnswer(aValue).hashValue,
			Question.singleAnswer(anotherValue).hashValue
		)
	}

	func test_hashInto_forMultipleAnswer() {
		XCTAssertEqual(
			Question.multipleAnswer(aValue).hashValue,
			Question.multipleAnswer(aValue).hashValue
		)
		XCTAssertNotEqual(
			Question.multipleAnswer(aValue).hashValue,
			Question.multipleAnswer(anotherValue).hashValue
		)
	}

}
