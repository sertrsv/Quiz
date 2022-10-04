//
//  iOSSwiftUINavigationAdapter.swift
//  Quiz
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import Foundation
import UIKit
import SwiftUI
import QuizEngine

final class iOSSwiftUINavigationAdapter: QuizDelegate {
	typealias Question = QuizEngine.Question<String>
	typealias Answer = [String]
	typealias Answers = [(question: Question, answer: Answer)]

	private let navigation: UINavigationController
	private let options: [Question: Answer]
	private let correctAnswers: Answers
	private let playAgain: () -> Void

	private var questions: [Question] {
		return correctAnswers.map { $0.question }
	}

	init(
		navigation: UINavigationController,
		options: [Question: Answer],
		correctAnswers: Answers,
		playAgain: @escaping () -> Void
	) {
		self.navigation = navigation
		self.options = options
		self.correctAnswers = correctAnswers
		self.playAgain = playAgain
	}

	func answer(for question: Question, completion: @escaping (Answer) -> Void) {
		show(questionViewController(for: question, answerCallback: completion))
	}

	func didCompleteQuiz(withAnswers answers: Answers) {
		show(resultsViewController(for: answers))
	}

	private func show(_ controller: UIViewController) {
		navigation.pushViewController(controller, animated: true)
	}

	private func questionViewController(
		for question: Question,
		answerCallback: @escaping (Answer) -> Void
	) -> UIViewController {
		guard let options = options[question] else {
			fatalError("Couldn't find options for question: \(question)")
		}

		return questionViewController(for: question, options: options, answerCallback: answerCallback)
	}

	private func questionViewController(
		for question: Question,
		options: Answer,
		answerCallback: @escaping (Answer) -> Void
	) -> UIViewController {
		let presenter = QuestionPresenter(questions: questions, question: question)

		switch question {
		case .singleAnswer(let value):
			return UIHostingController(
				rootView: SingleAnswerQuestion(
					title: presenter.title,
					question: value,
					options: options,
					selection: { answerCallback([$0]) }
				)
			)

		case .multipleAnswer(let value):
			return UIHostingController(
				rootView: MultipleAnswerQuestion(
					title: presenter.title,
					question: value,
					store: .init(
						options: options,
						handler: answerCallback
					)
				)
			)
		}
	}

	private func questionViewController(
		for question: Question,
		_ value: String,
		_ options: Answer,
		allowsMultipleSelection: Bool,
		_ answerCallback: @escaping (Answer) -> Void
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

	private func resultsViewController(
		for answers: Answers
	) -> UIViewController {
		let presenter = ResultsPresenter(
			userAnswers: answers,
			correctAnswers: correctAnswers,
			scorer: BasicScore.score
		)
		let view = ResultView(
			title: presenter.title,
			summary: presenter.summary,
			answers: presenter.presentableAnswers,
			playAgain: playAgain
		)
		return UIHostingController(rootView: view)
	}
}
