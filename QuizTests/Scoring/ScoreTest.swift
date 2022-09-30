//
//  ScoreTest.swift
//  
//
//  Created by Sergey Tarasov on 30.09.2022.
//

import XCTest
@testable import Quiz

final class ScoreTest: XCTestCase {

	func test_noAnswers_scoresZero() {
		XCTAssertEqual(BasicScore.score(for: [String](), comparingTo: [String]()), 0)
	}

	func test_oneNoMatchingAnswer_scoresZero() {
		XCTAssertEqual(BasicScore.score(for: ["not a match"], comparingTo: ["an answer"]), 0)
	}

	func test_oneMatchingAnswer_scoresOne() {
		XCTAssertEqual(BasicScore.score(for: ["an answer"], comparingTo: ["an answer"]), 1)
	}

	func test_oneMatchingAnswerOneNoMatching_scoresOne() {
		let score = BasicScore.score(
			for: ["an answer", "not a match"],
			comparingTo: ["an answer", "another answer"]
		)
		XCTAssertEqual(score, 1)
	}

	func test_twoMatchingAnswer_scoresTwo() {
		let score = BasicScore.score(
			for: ["an answer", "another answer"],
			comparingTo: ["an answer", "another answer"]
		)
		XCTAssertEqual(score, 2)
	}

	func test_withTooManyAnswers_twoMatchingAnswer_scoresTwo() {
		let score = BasicScore.score(
			for: ["an answer", "another answer", "an extra answer"],
			comparingTo: ["an answer", "another answer"]
		)
		XCTAssertEqual(score, 2)
	}

	func test_withTooManyCorrectAnswers_oneMatchingAnswer_scoresOne() {
		let score = BasicScore.score(
			for: ["not a match", "another answer"],
			comparingTo: ["an answer", "another answer", "an extra answer"]
		)
		XCTAssertEqual(score, 1)
	}

}
