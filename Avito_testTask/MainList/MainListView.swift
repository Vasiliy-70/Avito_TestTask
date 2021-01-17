//
//  MainListView.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit

protocol IMainListViewType {
	func updateView(title: String?, selectedButtonTitle: String?,
					selectedCell: Int?)
}

final class MainListView: UIView {
	private let closeButton = UIButton()
	private let titleLabel = UILabel()
	private let selectButton = UIButton()
	private let itemsCollection = UICollectionView(frame: .zero,
												   collectionViewLayout: UICollectionViewFlowLayout())
	private var selectedButtonTitle: (selected: String?,
									  notSelected: String?)?
	
	private let viewController: IMainListCollectionViewController
	
	private enum Constraints {
		static let closeButtonWidth: CGFloat = 30
		static let closeButtonHeight: CGFloat = 30
		static let closeButtonOffset: CGFloat = 10
		
		static let titleLabelOffset: CGFloat = 40
		
		static let buttonSelectHeight: CGFloat = 50
		static let buttonSelectOffset: CGFloat = 10
		
		static let itemsCollectionHorizontalOffset: CGFloat = 10
		static let itemsCollectionTopOffset: CGFloat = 25
	}
	
	private enum Constants {
		static let layoutHeight: CGFloat = 1
		
		static let titleLabelFont : UIFont = .boldSystemFont(ofSize: 22)
		static let titleLabelNumberOfLines = 2
		
		static let selectButtonBorderWidth: CGFloat = 1
		static let selectButtonCornerRadius: CGFloat = 10
	}
	
	init(collectionViewController: IMainListCollectionViewController) {
		self.viewController = collectionViewController
		super.init(frame: .zero)
		
		self.configureView()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: SetupView

private extension MainListView {
	func configureView() {
		self.backgroundColor = .white
		
		self.configureCollectionView()
		self.configureButtons()
		self.configureLabels()
	}
	
	func configureCollectionView() {
		self.itemsCollection.backgroundColor = .white
		self.itemsCollection.isPagingEnabled = false
		
		self.itemsCollection.register(MainListCollectionViewCell.self, forCellWithReuseIdentifier: self.viewController.cellIdentifier)
		
		self.itemsCollection.delegate = self.viewController.delegate
		self.itemsCollection.dataSource = self.viewController.dataSource
		
		let layoutListCollection: UICollectionViewFlowLayout = {
			let layout = UICollectionViewFlowLayout()
			let width = UIScreen.main.bounds.size.width
			layout.estimatedItemSize = CGSize(width: width, height: Constants.layoutHeight)
			return layout
		}()
		self.itemsCollection.collectionViewLayout = layoutListCollection
	}
	
	func configureButtons() {
		self.selectButton.startAnimatingPressActions()
		self.selectButton.backgroundColor = .blue
		self.selectButton.isHidden = true
		self.selectButton.layer.cornerRadius = Constants.selectButtonCornerRadius
		self.selectButton.addTarget(self, action: #selector(selectButtonTap),
									for: .touchUpInside)
		
		self.closeButton.setImage(Images.closeIcon, for: .normal)
		self.closeButton.isEnabled = false
	}
	
	func configureLabels() {
		self.titleLabel.font = Constants.titleLabelFont
		self.titleLabel.textAlignment = .left
		self.titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
	}
}

// MARK: Action

private extension MainListView {
	@objc func selectButtonTap() {
		self.viewController.selectButtonTap()
	}
	
	func updateListView(selectedCell: Int?) {
		let contentOffset = self.itemsCollection.contentOffset
		self.itemsCollection.reloadData()
		
		self.itemsCollection.performBatchUpdates(nil, completion: {
			(result) in
			self.itemsCollection.setContentOffset(contentOffset,
												  animated: false)
			if let selectedRow = selectedCell {
				let indexPath = IndexPath(item: selectedRow, section: 0)
				self.itemsCollection.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
			}
		})
	}
}

// MARK: SetupConstraints

private extension MainListView {
	func setupConstraints() {
		self.setupButtonsConstraints()
		self.setupLabelsConstraints()
		self.setupCollectionViewConstraints()
	}
	
	func setupCollectionViewConstraints() {
		self.addSubview(self.itemsCollection)
		self.itemsCollection.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.itemsCollection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constraints.itemsCollectionTopOffset),
			self.itemsCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.itemsCollectionHorizontalOffset),
			self.itemsCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.itemsCollectionHorizontalOffset),
			self.itemsCollection.bottomAnchor.constraint(equalTo: self.selectButton.topAnchor, constant: -Constraints.itemsCollectionHorizontalOffset)
		])
	}
	
	func setupButtonsConstraints() {
		self.addSubview(self.selectButton)
		self.addSubview(self.closeButton)
		
		self.selectButton.translatesAutoresizingMaskIntoConstraints = false
		self.closeButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.selectButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.buttonSelectOffset),
			self.selectButton.heightAnchor.constraint(equalToConstant: Constraints.buttonSelectHeight),
			self.selectButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.buttonSelectOffset),
			self.selectButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.buttonSelectOffset)
		])
		
		NSLayoutConstraint.activate([
			self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.closeButtonOffset),
			self.closeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.closeButtonOffset),
			self.closeButton.widthAnchor.constraint(equalToConstant: Constraints.closeButtonWidth),
			self.closeButton.heightAnchor.constraint(equalToConstant: Constraints.closeButtonHeight)
		])
	}
	
	func setupLabelsConstraints() {
		self.addSubview(self.titleLabel)
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: Constraints.titleLabelOffset),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.closeButton.leadingAnchor),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.titleLabelOffset)
		])
	}
}

// MARK: IMainListView

extension MainListView: IMainListViewType {
	func updateView(title: String?, selectedButtonTitle: String?,
					selectedCell: Int?) {
		self.titleLabel.text = title
		self.selectButton.setTitle(selectedButtonTitle, for: .normal)
		if self.selectButton.title(for: .normal) != "" {
			self.selectButton.isHidden = false
		}
		
		self.updateListView(selectedCell: selectedCell)
	}
}
