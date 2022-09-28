//
//  ViewControllerFactory.swift
//  Quiz
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
	func questionViewController(
		for question: Question<String>,
		answerCallback: @escaping ([String]) -> Void
	) -> UIViewController

	func resultsViewController(
		for result: Result<Question<String>, [String]>
	) -> UIViewController
}
