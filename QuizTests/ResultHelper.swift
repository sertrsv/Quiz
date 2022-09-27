//
//  ResultHelper.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 27.09.2022.
//

import QuizEngine

extension Result: Hashable {

	public func hash(into hasher: inout Hasher) {
		hasher.combine(1)
	}

	public static func == (lhs: Result, rhs: Result) -> Bool {
		return lhs.score == rhs.score
	}
}
