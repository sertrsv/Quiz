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
	var game: Game<Question<String>, [String], NavigationControllerRouter>?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
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

		let correctAnswers = [question1: [option3], question2: [option21, option22, option23, option24]]

		let navigationController = UINavigationController()
		let factory = iOSViewControllerFactory(questions: questions, options: [question1: options1, question2: options2], correctAnswers: correctAnswers)
		let router = NavigationControllerRouter(navigationController, factory: factory)

		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}


}

