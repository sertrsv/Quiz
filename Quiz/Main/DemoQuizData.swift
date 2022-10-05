//
//  DemoQuizData.swift
//  Quiz
//
//  Created by Sergey Tarasov on 06.10.2022.
//

import QuizEngine

let question1 = Question.singleAnswer("What is the best programming language?")
let question2 = Question.multipleAnswer("Кто хочет спать?")
let question3 = Question.singleAnswer("What's the capital of Brazil?")
let questions = [question1, question2, question3]

let option1 = "C++"
let option2 = "Python"
let option3 = "Swift"
let option4 = "Java"
let options1 = [option1, option2, option3, option4]

let option21 = "Я"
let option22 = "Я"
let option23 = "Я"
let option24 = "Я"
let options2 = [option21, option22, option23, option24]

let option31 = "Sao Paulo"
let option32 = "Rio de Janeiro"
let option33 = "Brazilia"
let options3 = [option31, option32, option33]

let options = [question1: options1, question2: options2, question3: options3]
let correctAnswers = [
	(question1, [option3]),
	(question2, [option21, option22, option23, option24]),
	(question3, [option33])
]
