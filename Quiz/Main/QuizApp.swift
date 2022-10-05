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
