//
//  iOSViewControllerFactory.swift
//  Quiz
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import Foundation
import UIKit
import QuizEngine

final class iOSViewControllerFactory: ViewControllerFactory {
	typealias Answers = [(question: Question<String>, answer: [String])]

	private let options: [Question<String>: [String]]
	private let correctAnswers: Answers

	private var questions: [Question<String>] {
		return correctAnswers.map { $0.question }
	}

	init(options: [Question<String>: [String]], correctAnswers: Answers) {
		self.options = options
		self.correctAnswers = correctAnswers
	}

	func questionViewController(
		for question: Question<String>,
		answerCallback: @escaping ([String]) -> Void
	) -> UIViewController {
		guard let options = options[question] else {
			fatalError("Couldn't find options for question: \(question)")
		}

		return questionViewController(for: question, options: options, answerCallback: answerCallback)
	}

	private func questionViewController(
		for question: Question<String>,
		options: [String],
		answerCallback: @escaping ([String]) -> Void
	) -> UIViewController {

		switch question {
		case .singleAnswer(let value):
			return questionViewController(
				for: question, value, options, allowsMultipleSelection: false, answerCallback
			)
			
		case .multipleAnswer(let value):
			return questionViewController(
				for: question, value, options, allowsMultipleSelection: true, answerCallback
			)
		}
	}

	fileprivate func questionViewController(
		for question: Question<String>,
		_ value: String,
		_ options: [String],
		allowsMultipleSelection: Bool,
		_ answerCallback: @escaping ([String]) -> Void
	) -> QuestionViewController {
		let presenter = QuestionPresenter(questions: questions, question: question)
		let controller = QuestionViewController(
			question: value,
			options: options,
			allowsMultipleSelection: allowsMultipleSelection,
			selection: answerCallback
		)
		controller.title = presenter.title
		return controller
	}

	func resultsViewController(
		for answers: Answers
	) -> UIViewController {
		let presenter = ResultsPresenter(
			userAnswers: answers,
			correctAnswers: correctAnswers,
			scorer: BasicScore.score
		)
		let controller = ResultsViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
		controller.title = presenter.title
		return controller
	}

	func resultsViewController(
		for result: Result<Question<String>, [String]>
	) -> UIViewController {
		let presenter = ResultsPresenter(
			userAnswers: questions.map { question in
				(question, result.answers[question]!)
			},
			correctAnswers: correctAnswers,
			scorer: { _, _ in result.score }
		)
		let controller = ResultsViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
		controller.title = presenter.title
		return controller
	}

}
