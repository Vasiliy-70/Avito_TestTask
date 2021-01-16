//
//  MainListRouter.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 16.01.2021.
//

import UIKit

protocol IMainListRouter {
	func showMainList()
}

final class MainListRouter {
	private var navigationController: UINavigationController?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

// MARK: IMainListRouter

extension MainListRouter: IMainListRouter {
	func showMainList() {
		guard let navigationController = navigationController else {
			assertionFailure("Error show MainListView")
			return
		}
		
		let mainListViewController = MainListAssembly.createMainListModule()
		navigationController.pushViewController(mainListViewController, animated: true)
	}
}
