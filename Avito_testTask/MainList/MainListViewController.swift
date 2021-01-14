//
//  MainListViewController.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit

protocol IMainListCollectionViewController {
	var delegate: UICollectionViewDelegate { get }
	var dataSource: UICollectionViewDataSource { get }
}

final class MainListViewController: UIViewController {
	var presenter: IMainListPresenter?
	private var cellId = "cellId"
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	override func loadView() {
		self.view = MainListView(collectionViewController: self)
	}
}

extension MainListViewController: UICollectionViewDelegate {
	
}

extension MainListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? MainListCollectionViewCell
		cell?.titleLabel.text = "Title"
		cell?.descriptionLabel.text = "Description"
		
		return cell ?? UICollectionViewCell()
	}
}

extension MainListViewController: IMainListCollectionViewController {
	var delegate: UICollectionViewDelegate {
		self
	}
	
	var dataSource: UICollectionViewDataSource {
		self
	}
}
