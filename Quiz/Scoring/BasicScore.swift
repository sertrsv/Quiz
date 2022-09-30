//
//  BasicScore.swift
//  Quiz
//
//  Created by Sergey Tarasov on 01.10.2022.
//

final class BasicScore {
	static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
		return zip(answers, correctAnswers).reduce(0) { score, tuple in
			return score + (tuple.0 == tuple.1 ? 1 : 0)
		}
	}
}
