//
//  MultipleSelectionStoreTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import XCTest

struct MultipleSelectionStore {
	var options: [MultipleSelectionOption]
	let handler: ([String]) -> Void

	var canSubmit: Bool {
		!options.filter(\.isSelected).isEmpty
	}

	init(options: [String], handler: @escaping ([String]) -> Void = { _ in }) {
		self.options = options.map { MultipleSelectionOption(text: $0) }
		self.handler = handler
	}

	func submit() {
		guard canSubmit else { return }
		handler(options.filter(\.isSelected).map(\.text))
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

	func test_canSubmit_whenAtLeastOneOptionIsSelected() {
		var sut = MultipleSelectionStore(options: ["O1", "O2"])
		XCTAssertFalse(sut.canSubmit)

		sut.options[0].select()
		XCTAssertTrue(sut.canSubmit)

		sut.options[0].select()
		XCTAssertFalse(sut.canSubmit)

		sut.options[1].select()
		XCTAssertTrue(sut.canSubmit)
	}

	func test_submit_notifiesHandlerWithSelectedOptions() {
		var submittedOptions = [[String]]()
		var sut = MultipleSelectionStore(options: ["O1", "O2"], handler: { submittedOptions.append($0) })

		sut.submit()
		XCTAssertEqual(submittedOptions, [])

		sut.options[0].select()
		sut.submit()
		XCTAssertEqual(submittedOptions, [["O1"]])

		sut.options[1].select()
		sut.submit()
		XCTAssertEqual(submittedOptions, [["O1"], ["O1", "O2"]])
	}

}
