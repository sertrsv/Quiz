//
//  BasicQuizBuilderTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 06.10.2022.
//

import XCTest

struct BasicQuiz {

}

struct BasicQuizBuilder {
	func build() -> BasicQuiz? {
		nil
	}
}

final class BasicQuizBuilderTest: XCTestCase {

    func test_empty() {
		let sut = BasicQuizBuilder()

		XCTAssertNil(sut.build())
    }

}
