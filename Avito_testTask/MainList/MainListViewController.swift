//
//  MainListViewController.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit
import Foundation

protocol IMainListCollectionViewController: class {
	var cellIdentifier: String { get }
	var delegate: UICollectionViewDelegate { get }
	var dataSource: UICollectionViewDataSource { get }
}

final class MainListViewController: UIViewController {
	var presenter: IMainListPresenter?
	internal var cellId = "cellId"
	
	private let List = ListModel()
	
	private enum Constants {
		static let collectionCellWidth: CGFloat = UIScreen.main.bounds.width
		static let collectionCellHeight: CGFloat = 300
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		(self.view as? IMainListView)?.reloadTable()
    }

	override func loadView() {
		self.view = MainListView(collectionViewController: self)
	}
}

extension MainListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10.0
	}
	
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		self.List.listItems[indexPath.row].selectedState = false
	}
}

extension MainListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.List.listItems.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? IMainListCollectionViewCell else {
			assertionFailure("No tableCellView")
			return UICollectionViewCell()
	}
	
		cell.title = List.listItems[indexPath.row].title
		cell.descriptionText = List.listItems[indexPath.row].description
		cell.price = List.listItems[indexPath.row].price
		cell.icon = List.listItems[indexPath.row].icon
		cell.selectedState = List.listItems[indexPath.row].selectedState
//		cell.updateContent()
		return cell as? UICollectionViewCell ?? UICollectionViewCell()
	}
}

extension MainListViewController: IMainListCollectionViewController {
	
	var cellIdentifier: String {
		self.cellId
	}
	
	var delegate: UICollectionViewDelegate {
		self
	}
	
	var dataSource: UICollectionViewDataSource {
		self
	}
}
