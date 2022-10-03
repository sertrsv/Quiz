//
//  MultipleSelectionStoreTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import XCTest

struct MultipleSelectionStore {
	var options: [MultipleSelectionOption]

	init(options: [String]) {
		self.options = options.map { MultipleSelectionOption(text: $0) }
	}
}

struct MultipleSelectionOption {
	let text: String
	var isSelected: Bool = false
	mutating func select() {
		isSelected.toggle()
	}
}

final class MultipleSelectionStoreTest: XCTestCase {

	func test_selectOption_togglesState() {
		var sut = MultipleSelectionStore(options: ["O1", "O2"])

		sut.options[0].select()
		XCTAssertTrue(sut.options[0].isSelected)

		sut.options[0].select()
		XCTAssertFalse(sut.options[0].isSelected)
	}

}
