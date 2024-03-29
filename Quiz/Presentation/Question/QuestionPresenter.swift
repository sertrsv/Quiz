//
//  QuestionPresenter.swift
//  Quiz
//
//  Created by Sergey Tarasov on 27.09.2022.
//

import BasicQuizDomain

struct QuestionPresenter {
	let questions: [Question<String>]
	let question: Question<String>

	var title: String {
		guard let index = questions.firstIndex(of: question) else { return "" }
		return "\(index + 1) of \(questions.count)"
	}
}
