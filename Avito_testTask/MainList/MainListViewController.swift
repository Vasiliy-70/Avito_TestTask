//
//  MainListViewController.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit

class MainListViewController: UIViewController {
	var presenter: IMainListPresenter?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	override func loadView() {
		self.view = MainListView()
	}
}
