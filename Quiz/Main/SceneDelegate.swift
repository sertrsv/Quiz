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

	private lazy var navigationController = UINavigationController()

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let windowScene = (scene as? UIWindowScene) else { return }

		startNewQuiz()

		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

	private func startNewQuiz() {
		let factory = iOSUIKitViewControllerFactory(options: demoQuiz.options, correctAnswers: demoQuiz.correctAnswers)
		let router = NavigationControllerRouter(navigationController, factory: factory)

		quiz = Quiz.start(questions: demoQuiz.questions, delegate: router)
	}

}

