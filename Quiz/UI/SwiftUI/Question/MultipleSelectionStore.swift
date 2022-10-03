//
//  MultipleSelectionStore.swift
//  Quiz
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import SwiftUI

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
