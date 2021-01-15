//
//  MainListView.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit

protocol IMainListView {
	func reloadTable()
}

final class MainListView: UIView {
	private let closeButtonImage = UIImageView()
	private let titleLabel = UILabel()
	private let selectButton = UIButton()
	private let listCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	private let collectionViewController: IMainListCollectionViewController
	
	private enum Constraints {
		static let closeButtonImageWidth: CGFloat = 20
		static let closeButtonImageHeight: CGFloat = 20
		static let closeButtonImageOffset: CGFloat = 10
		
		static let titleLabelOffset: CGFloat = 10
		
		static let buttonSelectHeight: CGFloat = 50
		static let buttonSelectOffset: CGFloat = 10

		static let listCollectionOffset: CGFloat = 10
	}
	
	private enum Constants {
		static let layoutHeight: CGFloat = 1
		
		static let titleLabelFont : UIFont = .boldSystemFont(ofSize: 22)
		static let titleLabelNumberOfLines = 2
		
		static let selectButtonBorderWidth: CGFloat = 1
		static let selectButtonCornerRadius: CGFloat = 5
	}
	
	init(collectionViewController: IMainListCollectionViewController) {
		self.collectionViewController = collectionViewController
		super.init(frame: .zero)
		
		self.setupAppearance()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: SetupAppearance

private extension MainListView {
	func setupAppearance() {
		self.backgroundColor = .red
		
		self.setupImageView()
		self.setupCollectionView()
		self.setupButtonsView()
		self.setupLabelsView()
	}
	
	func setupImageView() {
		self.closeButtonImage.contentMode = .scaleAspectFit
		self.closeButtonImage.image = Images.closeIcon
	}
	
	func setupCollectionView() {
		self.listCollection.register(MainListCollectionViewCell.self, forCellWithReuseIdentifier: self.collectionViewController.cellIdentifier)

		self.listCollection.delegate = self.collectionViewController.delegate
		self.listCollection.dataSource = self.collectionViewController.dataSource
		
		let layoutListCollection: UICollectionViewFlowLayout = {
			let layout = UICollectionViewFlowLayout()
			let width = UIScreen.main.bounds.size.width
			layout.estimatedItemSize = CGSize(width: width, height: Constants.layoutHeight)
			return layout
		}()
		self.listCollection.collectionViewLayout = layoutListCollection
	}
	
	func setupButtonsView() {
		self.selectButton.setTitle("Выбрать", for: .normal)
		self.selectButton.layer.borderWidth = Constants.selectButtonBorderWidth
		self.selectButton.layer.cornerRadius = Constants.selectButtonCornerRadius
		self.selectButton.backgroundColor = .blue
	}
	
	func setupLabelsView() {
		self.titleLabel.font = Constants.titleLabelFont
		self.titleLabel.textAlignment = .left
		self.titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
		self.titleLabel.text = "Сделайте объявление заметнее на 7 дней"
	}
}

// MARK: SetupConstraints

private extension MainListView {
	func setupConstraints() {
		self.setupImageConstraints()
		self.setupButtonsConstraints()
		self.setupLabelsConstraints()
		self.setupCollectionViewConstraints()
		
	}
	
	func setupImageConstraints() {
		self.addSubview(self.closeButtonImage)
		self.closeButtonImage.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.closeButtonImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.closeButtonImageOffset),
			self.closeButtonImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.closeButtonImageOffset),
			self.closeButtonImage.widthAnchor.constraint(equalToConstant: Constraints.closeButtonImageWidth),
			self.closeButtonImage.heightAnchor.constraint(equalToConstant: Constraints.closeButtonImageHeight)
		])
	}
	
	func setupCollectionViewConstraints() {
		self.addSubview(self.listCollection)
		self.listCollection.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.listCollection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constraints.listCollectionOffset),
			self.listCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.listCollectionOffset),
			self.listCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.listCollectionOffset),
			self.listCollection.bottomAnchor.constraint(equalTo: self.selectButton.topAnchor, constant: -Constraints.listCollectionOffset)
		])
	}
	
	func setupButtonsConstraints() {
		self.addSubview(self.selectButton)
		
		self.selectButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.selectButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.buttonSelectOffset),
			self.selectButton.heightAnchor.constraint(equalToConstant: Constraints.buttonSelectHeight),
			self.selectButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.buttonSelectOffset),
			self.selectButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.buttonSelectOffset)
		])
	}
	
	func setupLabelsConstraints() {
		self.addSubview(self.titleLabel)
		
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: self.closeButtonImage.bottomAnchor, constant: Constraints.titleLabelOffset),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.closeButtonImage.leadingAnchor),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.titleLabelOffset)
		])
	}
}

// MARK: IMainListView

extension MainListView: IMainListView {
	func reloadTable() {
//		self.setupCollectionView()
//		self.listCollection.reloadData()
	}
}
