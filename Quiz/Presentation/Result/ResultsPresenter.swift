//
//  ResultsPresenter.swift
//  Quiz
//
//  Created by Sergey Tarasov on 27.09.2022.
//

import BasicQuizDomain

final class ResultsPresenter {
	typealias Answers = [(question: Question<String>, answer: [String])]
	typealias Scorer = ([[String]], [[String]]) -> Int

	private let userAnswers: Answers
	private let correctAnswers: Answers
	private let scorer: Scorer

	init(userAnswers: Answers, correctAnswers: Answers, scorer: @escaping Scorer) {
		self.userAnswers = userAnswers
		self.correctAnswers = correctAnswers
		self.scorer = scorer
	}

	var title: String {
		return "Result"
	}

	var summary: String {
		return "You got \(score)/\(userAnswers.count) correct"
	}

	var score: Int {
		return scorer(userAnswers.map { $0.answer }, correctAnswers.map { $0.answer })
	}

	var presentableAnswers: [PresentableAnswer] {
		return zip(userAnswers, correctAnswers).map { userAnswer, correctAnswer in
			return presentableAnswer(userAnswer.question, userAnswer.answer, correctAnswer.answer)
		}
	}

	fileprivate func presentableAnswer(
		_ question: Question<String>,
		_ userAnswer: [String],
		_ correctAnswer: [String]
	) -> PresentableAnswer {
		switch question {
		case .singleAnswer(let value), .multipleAnswer(let value):
			return PresentableAnswer(
				question: value,
				answer: formattedAnswer(correctAnswer),
				wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer)
			)
		}
	}

	fileprivate func formattedAnswer(_ answer: [String]) -> String {
		return answer.joined(separator: ", ")
	}

	fileprivate func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
		return correctAnswer == userAnswer ? nil : userAnswer.joined(separator: ", ")
	}
	
}
