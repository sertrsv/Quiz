//
//  QuestionViewControllerTest.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 24.09.2022.
//

import XCTest
@testable import Quiz

final class QuestionViewControllerTest: XCTestCase {

	func test_viewDidLoad_renderQuestionHeaderText() throws {
		XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }

	func test_viewDidLoad_rendersOption() throws {
		XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
		XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
		XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
	}

	func test_viewDidLoad_renderOptionsText() throws {
		XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
		XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
	}

	func test_viewDidLoad_withSingleSelection_configuresTableView() throws {
		XCTAssertFalse(makeSUT(options: ["A1", "A2"], allowsMultipleSelection: false).tableView.allowsMultipleSelection)
	}

	func test_viewDidLoad_withMultipleSelection_configuresTableView() throws {
		XCTAssertTrue(makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true).tableView.allowsMultipleSelection)
	}

	func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() throws {
		var receivedAnswer = [String]()
		let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: false) { receivedAnswer = $0 }

		sut.tableView.select(row: 0)
		XCTAssertEqual(receivedAnswer, ["A1"])

		sut.tableView.select(row: 1)
		XCTAssertEqual(receivedAnswer, ["A2"])
	}

	func test_optionDeselected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection() throws {
		var callbackCount = 0
		let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: false) { _ in callbackCount += 1 }

		sut.tableView.select(row: 0)
		XCTAssertEqual(callbackCount, 1)

		sut.tableView.deselect(row: 0)
		XCTAssertEqual(callbackCount, 1)
	}

	func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() throws {
		var receivedAnswer = [String]()
		let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true) { receivedAnswer = $0 }

		sut.tableView.select(row: 0)
		XCTAssertEqual(receivedAnswer, ["A1"])

		sut.tableView.select(row: 1)
		XCTAssertEqual(receivedAnswer, ["A1", "A2"])
	}

	func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegate() throws {
		var receivedAnswer = [String]()
		let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true) { receivedAnswer = $0 }

		sut.tableView.select(row: 0)
		XCTAssertEqual(receivedAnswer, ["A1"])

		sut.tableView.deselect(row: 0)
		XCTAssertEqual(receivedAnswer, [])
	}

	// MARK: Helpers

	func makeSUT(
		question: String = "",
		options: [String] = [],
		allowsMultipleSelection: Bool = false,
		selection: @escaping ([String]) -> Void = { _ in }
	) -> QuestionViewController {
		let sut = QuestionViewController(question: question, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: selection)
		_ = sut.view
		return sut
	}

}
