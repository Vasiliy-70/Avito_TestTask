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
	func selectButtonTap()
}

protocol IMainListView: class {
	var selectedState: Bool? { get set }
	func updateInfo()
	func showAlert(title: String, description: String)
}


final class MainListViewController: UIViewController {
	var presenter: IMainListPresenter?
	private var cellId = "cellId"
	
	private var layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		let width = UIScreen.main.bounds.size.width
		layout.estimatedItemSize = CGSize(width: width, height: 10)
		return layout
	}()
	
	private enum Constants {
		static let collectionCellWidth: CGFloat = UIScreen.main.bounds.width
		static let collectionCellHeight: CGFloat = 300
		static let cellSpacing: CGFloat = 10
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func loadView() {
		self.view = MainListView(collectionViewController: self)
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
		super.traitCollectionDidChange(previousTraitCollection)
	}
}

// MARK: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension MainListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.presenter?.checkmark(item: indexPath.row)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return Constants.cellSpacing
	}
	
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let referenceHeight: CGFloat = 54.0
		var referenceWidth: CGFloat = 100.0
		
		if let sectionInset = (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset {
			referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
				- sectionInset.left
				- sectionInset.right
				- collectionView.contentInset.left
				- collectionView.contentInset.right
		}
		
		return CGSize(width: referenceWidth, height: referenceHeight)
	}
}

// MARK: UICollectionViewDataSource

extension MainListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.presenter?.listContent?.listItems?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? IMainListCollectionViewCell else {
			assertionFailure("No tableCellView")
			return UICollectionViewCell()
		}
		
		cell.title = self.presenter?.listContent?.listItems?[indexPath.row].title
		cell.descriptionText = self.presenter?.listContent?.listItems?[indexPath.row].description
		cell.price = self.presenter?.listContent?.listItems?[indexPath.row].price
		cell.iconPath = self.presenter?.listContent?.listItems?[indexPath.row].iconPath
		cell.selectedState = self.presenter?.listContent?.listItems?[indexPath.row].selectedState ?? false
		
		return cell as? UICollectionViewCell ?? UICollectionViewCell()
	}
}

// MARK: IMainListCollectionViewController

extension MainListViewController: IMainListCollectionViewController {
	func selectButtonTap() {
		self.presenter?.selectAction()
	}
	
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

// MARK: IMainListView

extension MainListViewController: IMainListView {
	var selectedState: Bool? {
		get {
			return false
		}
		set {
			(self.view as? IMainListViewType)?.selectButton(enabled: newValue ?? false)
		}
	}
	
	func updateInfo() {
		let title = self.presenter?.listContent?.title
		let selectedButtonTitle = self.presenter?.listContent?.selectedActionTitle
		(self.view as? IMainListViewType)?.set(title: title, selectedButtonTitle: selectedButtonTitle)
	}
	
	func showAlert(title: String, description: String) {
		let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
		
		let applyAction = UIAlertAction(title: "Ок", style: .default)
		alert.addAction(applyAction)
		
		self.present(alert, animated: true, completion: nil)
	}
}
