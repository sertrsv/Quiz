//
//  QuizApp.swift
//  Quiz
//
//  Created by Sergey Tarasov on 04.10.2022.
//

import SwiftUI
import QuizEngine

class QuizAppStore {
	var quiz: Quiz?
}

@main
struct QuizApp: App {
	let appStore: QuizAppStore = QuizAppStore()
	@StateObject var navigationStore: QuizNavigationStore = QuizNavigationStore()

	var body: some Scene {
		WindowGroup {
			QuizNavigationView(store: navigationStore)
				.onAppear {
					startNewQuiz()
				}
		}
	}

	private func startNewQuiz() {
		let adapter = iOSSwiftUINavigationAdapter(
			navigation: navigationStore,
			options: options,
			correctAnswers: correctAnswers,
			playAgain: startNewQuiz)

		appStore.quiz = Quiz.start(questions: questions, delegate: adapter)
	}
}


let question1 = Question.singleAnswer("What is the best programming language?")
let question2 = Question.multipleAnswer("Кто хочет спать?")
let questions = [question1, question2]

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

let options = [question1: options1, question2: options2]
let correctAnswers = [(question1, [option3]), (question2, [option21, option22, option23, option24])]
