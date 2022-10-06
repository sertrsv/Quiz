//
//  DemoQuizData.swift
//  Quiz
//
//  Created by Sergey Tarasov on 06.10.2022.
//

import BasicQuizDomain

let demoQuiz = try! BasicQuizBuilder(
	singleAnswerQuestion: "What is the best programming language?",
	options: .init(head: "C++", tail: ["Python", "Swift", "Java"]),
	answer: "Swift"
)
	.adding(
		multipleAnswerQuestion: "What are the colors of the rainbow?",
		options: .init(head: "Red", tail: ["Blue", "White", "Brown"]),
		answer: .init(head: "Red", tail: ["Blue"])
	)
	.adding(
		singleAnswerQuestion: "What's the capital of Brazil?",
		options: .init(head: "Sao Paulo", tail: ["Rio de Janeiro", "Brazilia"]),
		answer: "Brazilia"
	)
	.adding(
		singleAnswerQuestion: "Which is the only planet in our solar system not named after a Roman or Greek god?",
		options: .init(head: "Mars", tail: ["Upiter", "Earth", "Mercury"]),
		answer: "Earth"
	)
	.build()
