//
//  MainListCollectionViewCell.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit

class MainListCollectionViewCell: UICollectionViewCell {
	var titleLabel = UILabel()
	var descriptionLabel = UILabel()
	var iconImage = UIImageView()
	var selectedState = UIImageView()
	
	private enum Constants {
		static let titleLabelFont : UIFont = .boldSystemFont(ofSize: 16)
		static let descriptionLabelFont: UIFont = .systemFont(ofSize: 12)
	}
	
	private enum Constraints {
		static let iconImageOffset: CGFloat = 10
		static let iconImageWidth: CGFloat = 52
		static let iconImageHeight: CGFloat = 52
		
		static let selectedStateOffset: CGFloat = 10
		static let selectedStateImageWidth: CGFloat = 52
		static let selectedStateImageHeight: CGFloat = 52
		
		static let titleLabelOffset: CGFloat = 10
		static let descriptionLabelOffset: CGFloat = 10
	}
	
	init() {
		super.init(frame: .zero)
		
		self.setupAppearance()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: SetupAppearance

private extension MainListCollectionViewCell {
	func setupAppearance() {
		self.setupLabelView()
		self.setupImageView()
	}
	
	func setupLabelView() {
		self.titleLabel.font = Constants.titleLabelFont
		self.titleLabel.textAlignment = .left
		
		self.descriptionLabel.font = Constants.descriptionLabelFont
		self.descriptionLabel.textAlignment = .left
	}
	
	func setupImageView() {
		self.iconImage.contentMode = .scaleAspectFit
		self.selectedState.contentMode = .scaleAspectFit
	}
}

// MARK: SetupConstraints

private extension MainListCollectionViewCell {
	func setupConstraints() {
		self.setupImagesConstraints()
		self.setupLabelsConstraints()
	}
	
	func setupLabelsConstraints() {
		self.addSubview(self.titleLabel)
		self.addSubview(self.descriptionLabel)
		
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.titleLabelOffset),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.iconImage.trailingAnchor, constant: Constraints.titleLabelOffset),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.selectedState.leadingAnchor, constant: -Constraints.titleLabelOffset)
		])
		
		NSLayoutConstraint.activate([
			self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constraints.descriptionLabelOffset),
			self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
			self.descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
			self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constraints.descriptionLabelOffset)
		])
	}
	
	func setupImagesConstraints() {
		self.addSubview(self.iconImage)
		self.addSubview(self.selectedState)
		
		self.iconImage.translatesAutoresizingMaskIntoConstraints = false
		self.selectedState.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.iconImageOffset),
			self.iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraints.iconImageOffset),
			self.iconImage.widthAnchor.constraint(equalToConstant: Constraints.iconImageWidth),
			self.iconImage.heightAnchor.constraint(equalToConstant: Constraints.iconImageHeight)
		])
		
		NSLayoutConstraint.activate([
			self.selectedState.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.selectedStateOffset),
			self.selectedState.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraints.selectedStateOffset),
			self.selectedState.widthAnchor.constraint(equalToConstant: Constraints.selectedStateImageWidth),
			self.selectedState.heightAnchor.constraint(equalToConstant: Constraints.selectedStateImageWidth)
		])
	}
}
