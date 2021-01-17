//
//  MainListAssembly.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//
import UIKit

enum MainListAssembly {
	static func createMainListModule(router: IMainListRouter) -> UIViewController {
		let view = MainListViewController()
		let interactor = MainListInteractor()
		let presenter = MainListPresenter(view: view,
										  interactor: interactor,
										  router: router)
		view.presenter = presenter
		interactor.presenter = presenter
		return view
	}
}
