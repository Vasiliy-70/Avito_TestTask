//
//  SceneDelegate.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 13.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		
		guard let window = self.window else {
			assertionFailure("Error: no window")
			return
		}
		window.windowScene = windowScene
		
		let navigationController = UINavigationController()
		navigationController.viewControllers = [MainListAssembly.createMainListModule()]
		
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}

