//
//  ResultHelper.swift
//  QuizTests
//
//  Created by Sergey Tarasov on 27.09.2022.
//

import QuizEngine

extension Result: Hashable where Answer: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(answers)
		hasher.combine(score)
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
