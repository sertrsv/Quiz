//
//  SceneDelegate.swift
//  Quiz
//
//  Created by Sergey Tarasov on 24.09.2022.
//

import UIKit
import QuizEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	var quiz: Quiz?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let windowScene = (scene as? UIWindowScene) else { return }

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

		let navigationController = UINavigationController()
		let factory = iOSSwiftUIViewControllerFactory(
			options: options,
			correctAnswers: correctAnswers,
			playAgain: startNewQuiz
		)
		let router = NavigationControllerRouter(navigationController, factory: factory)

		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		quiz = Quiz.start(questions: questions, delegate: router)
	}

}

