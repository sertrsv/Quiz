//
//  NavigationControllerRouter.swift
//  Quiz
//
//  Created by Sergey Tarasov on 25.09.2022.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
	private let navigationController: UINavigationController
	private let factory: ViewControllerFactory

	init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
		self.navigationController = navigationController
		self.factory = factory
	}

	func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {
		let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
		show(viewController)
	}

	func routeTo(result: Result<Question<String>, [String]>) {
		let viewController = factory.resultsViewController(for: result)
		show(viewController)
	}

	private func show(_ viewController: UIViewController) {
		navigationController.pushViewController(viewController, animated: true)
	}

}
