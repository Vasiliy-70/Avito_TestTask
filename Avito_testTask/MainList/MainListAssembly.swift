//
//  MainListAssembly.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//
import UIKit

enum MainListAssembly {
	static func createMainListModule() -> UIViewController {
		let view = MainListViewController()
		let interactor = MainListInteractor()
		let presenter = MainListPresenter(view: view, interactor: interactor)
		view.presenter = presenter
		interactor.presenter = presenter
		return view
	}
}
