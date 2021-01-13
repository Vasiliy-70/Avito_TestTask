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
		let presenter = MainListPresenter()
		view.presenter = presenter
		return view
	}
}
