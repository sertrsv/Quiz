//
//  TableViewHelpers.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 25.09.2022.
//

import UIKit

extension UITableView {

	func cell(at row: Int) -> UITableViewCell? {
		return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
	}

	func title(at row: Int) -> String? {
		let content = cell(at: row)?.contentConfiguration as! UIListContentConfiguration
		return content.text
	}

	func select(row: Int) {
		let indexPath = IndexPath(row: row, section: 0)
		selectRow(at: indexPath, animated: false, scrollPosition: .none)
		delegate?.tableView?(self, didSelectRowAt: indexPath)
	}

	func deselect(row: Int) {
		let indexPath = IndexPath(row: row, section: 0)
		deselectRow(at: indexPath, animated: false)
		delegate?.tableView?(self, didDeselectRowAt: indexPath)
	}

}
