//
//  ResultHelper.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 27.09.2022.
//

import QuizEngine

extension Result: Hashable where Answer: Equatable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(1)
	}
}

extension Result: Equatable where Answer: Equatable {
	public static func == (
		lhs: QuizEngine.Result<Question, Answer>,
		rhs: QuizEngine.Result<Question, Answer>
	) -> Bool {
		return lhs.score == rhs.score && lhs.answers == rhs.answers
	}
}
