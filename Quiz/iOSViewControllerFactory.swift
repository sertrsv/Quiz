//
//  iOSViewControllerFactory.swift
//  Quiz
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import Foundation
import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {

	private let questions: [Question<String>]
	private let options: [Question<String>: [String]]

	init(questions: [Question<String>], options: [Question<String>: [String]]) {
		self.questions = questions
		self.options = options
	}

	func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
		guard let options = options[question] else {
			fatalError("Couldn't find options for question: \(question)")
		}

		return questionViewController(for: question, options: options, answerCallback: answerCallback)
	}

	private func questionViewController(for question: Question<String>, options: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {

		switch question {
		case .singleAnswer(let value):
			return questionViewController(for: question, value, options, allowsMultipleSelection: false, answerCallback)
			
		case .multipleAnswer(let value):
			return questionViewController(for: question, value, options, allowsMultipleSelection: true, answerCallback)
		}
	}

	fileprivate func questionViewController(for question: Question<String>, _ value: String, _ options: [String], allowsMultipleSelection: Bool, _ answerCallback: @escaping ([String]) -> Void) -> QuestionViewController {
		let presenter = QuestionPresenter(questions: questions, question: question)
		let controller = QuestionViewController(question: value, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: answerCallback)
		controller.title = presenter.title
		return controller
	}

	func resultsViewController(for result: QuizEngine.Result<Question<String>, [String]>) -> UIViewController {
		return UIViewController()
	}

}
