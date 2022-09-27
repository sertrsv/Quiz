//
//  Question.swift
//  Quiz
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import Foundation

enum Question<T: Hashable> : Hashable {
	case singleAnswer(T)
	case multipleAnswer(T)

	func hash(into hasher: inout Hasher) {
		switch self {
		case .singleAnswer(let value):
			hasher.combine(value)
		case .multipleAnswer(let value):
			hasher.combine(value)
		}
	}
}
