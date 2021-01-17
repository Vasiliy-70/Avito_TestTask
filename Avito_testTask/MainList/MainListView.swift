//
//  MainListView.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit

protocol IMainListViewType {
	func selectButton(enabled: Bool)
	func set(title: String?, selectedButtonTitle: String?)
}

final class MainListView: UIView {
	private let closeButton = UIButton()
	private let titleLabel = UILabel()
	private let selectButton = UIButton()
	private let listCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	private let viewController: IMainListCollectionViewController
	
	private enum Constraints {
		static let closeButtonImageWidth: CGFloat = 20
		static let closeButtonImageHeight: CGFloat = 20
		static let closeButtonImageOffset: CGFloat = 10
		
		static let titleLabelOffset: CGFloat = 40
		
		static let buttonSelectHeight: CGFloat = 50
		static let buttonSelectOffset: CGFloat = 10

		static let listCollectionHorizontalOffset: CGFloat = 10
		static let listCollectionTopOffset: CGFloat = 25
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
		self.listCollection.backgroundColor = .white
		
		self.listCollection.register(MainListCollectionViewCell.self, forCellWithReuseIdentifier: self.viewController.cellIdentifier)

		self.listCollection.delegate = self.viewController.delegate
		self.listCollection.dataSource = self.viewController.dataSource
		
		let layoutListCollection: UICollectionViewFlowLayout = {
			let layout = UICollectionViewFlowLayout()
			let width = UIScreen.main.bounds.size.width
			layout.estimatedItemSize = CGSize(width: width, height: Constants.layoutHeight)
			return layout
		}()
		self.listCollection.collectionViewLayout = layoutListCollection
	}
	
	func configureButtons() {
		self.selectButton.startAnimatingPressActions()
		self.selectButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		self.selectButton.isEnabled = false
		self.selectButton.isHidden = true
		self.selectButton.layer.borderWidth = Constants.selectButtonBorderWidth
		self.selectButton.layer.cornerRadius = Constants.selectButtonCornerRadius
		self.selectButton.addTarget(self, action: #selector(selectButtonTap), for: .touchUpInside)
		
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
		self.addSubview(self.closeButton)
		self.closeButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.closeButtonImageOffset),
			self.closeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.closeButtonImageOffset),
			self.closeButton.widthAnchor.constraint(equalToConstant: Constraints.closeButtonImageWidth),
			self.closeButton.heightAnchor.constraint(equalToConstant: Constraints.closeButtonImageHeight)
		])
	}
	
	func setupCollectionViewConstraints() {
		self.addSubview(self.listCollection)
		self.listCollection.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.listCollection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constraints.listCollectionTopOffset),
			self.listCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.listCollectionHorizontalOffset),
			self.listCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.listCollectionHorizontalOffset),
			self.listCollection.bottomAnchor.constraint(equalTo: self.selectButton.topAnchor, constant: -Constraints.listCollectionHorizontalOffset)
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
			self.titleLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: Constraints.titleLabelOffset),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.closeButton.leadingAnchor),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.titleLabelOffset)
		])
	}
}

// MARK: IMainListView

extension MainListView: IMainListViewType {
	func selectButton(enabled: Bool) {
		self.selectButton.backgroundColor = enabled ? .blue : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		self.selectButton.isEnabled = enabled ? true : false
	}

	func set(title: String?, selectedButtonTitle: String?) {
		self.titleLabel.text = title
		self.selectButton.setTitle(selectedButtonTitle, for: .normal)
		if self.selectButton.title(for: .normal) != "" {
			self.selectButton.isHidden = false
		}
		
		self.listCollection.reloadData()
	}
}
