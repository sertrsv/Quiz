//
//  ResultsPresenter.swift
//  Quiz
//
//  Created by Sergey Tarasov on 27.09.2022.
//

import QuizEngine

struct ResultsPresenter {
	let result: Result<Question<String>, [String]>
	let questions: [Question<String>]
	let correctAnswers: [Question<String>: [String]]

	var summary: String {
		let score = result.score
		let all = result.answers.count
		return "You got \(score)/\(all) correct"
	}

	var presentableAnswers: [PresentableAnswer] {
		return questions.map { question in
			guard let userAnswer = result.answers[question],
				  let correctAnswer = correctAnswers[question] else {
				fatalError("Couldn't find correct answer for question: \(question)")
			}

			return presentableAnswer(question, userAnswer, correctAnswer)
		}
	}

	fileprivate func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
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
