//
//  ViewControllerFactory.swift
//  Quiz
//
//  Created by Sergey Tarasov on 26.09.2022.
//

import UIKit
import BasicQuizDomain

protocol ViewControllerFactory {
	typealias Answers = [(question: Question<String>, answer: [String])]
	func questionViewController(
		for question: Question<String>,
		answerCallback: @escaping ([String]) -> Void
	) -> UIViewController

	func resultsViewController(
		for answers: Answers
	) -> UIViewController
}
