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
}

struct BasicQuizBuilder {
	private let questions: [Question<String>]

	init(singleAnswerQuestion: String) {
		self.questions = [.singleAnswer(singleAnswerQuestion)]
	}

	func build() -> BasicQuiz {
		BasicQuiz(questions: questions)
	}
}

final class BasicQuizBuilderTest: XCTestCase {

    func test_initWithSingleAnswerQuestion() {
		let sut = BasicQuizBuilder(singleAnswerQuestion: "Q1")

		XCTAssertEqual(sut.build().questions, [.singleAnswer("Q1")])
    }

}
