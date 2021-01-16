//
//  MainListCollectionViewCell.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit

protocol IMainListCollectionViewCell {
	var title: String? { get set}
	var descriptionText: String? { get set}
	var price: String? { get set}
	var iconPath: String? { get set }
	var selectedState: Bool { get set}
	
	func updateContent()
}

final class MainListCollectionViewCell: UICollectionViewCell {
	private var titleLabel = UILabel()
	private var descriptionLabel = UILabel()
	private var iconImage = UIImageView()
	private var selectedStateImage = UIImageView()
	private var priceLabel = UILabel()

	private enum Constants {
		static let titleLabelFont : UIFont = .boldSystemFont(ofSize: 22)
		static let descriptionLabelFont: UIFont = .systemFont(ofSize: 16)
		static let priceLabelFont: UIFont = .boldSystemFont(ofSize: 20)
		
		static let titleLabelNumberOfLines = 2
		static let descriptionLabelNumberOfLines = 0
		static let priceLabelNumberOfLines = 1
	}
	
	private enum Constraints {
		static let iconImageOffset: CGFloat = 15
		static let iconImageWidth: CGFloat = 52
		static let iconImageHeight: CGFloat = 52
		
		static let selectedStateImageOffset: CGFloat = 15
		static let selectedStateImageWidth: CGFloat = 30
		static let selectedStateImageHeight: CGFloat = 30
		
		static let titleLabelOffset: CGFloat = 10
		static let descriptionLabelOffset: CGFloat = 10
		static let priceLabelOffset: CGFloat = 10
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		self.setupAppearance()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
		let width: NSLayoutConstraint = self.contentView.widthAnchor.constraint(equalToConstant: self.bounds.size.width)
		width.isActive = true
		width.constant = self.bounds.size.width
		return self.contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
	}
}

// MARK: SetupAppearance

private extension MainListCollectionViewCell {
	func setupAppearance() {
		self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
		
		self.setupLabelView()
		self.setupImageView()
		self.setupContentView()
	}
	
	func setupLabelView() {
		self.titleLabel.font = Constants.titleLabelFont
		self.titleLabel.textAlignment = .left
		self.titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
		
		self.descriptionLabel.font = Constants.descriptionLabelFont
		self.descriptionLabel.textAlignment = .left
		self.descriptionLabel.numberOfLines = Constants.descriptionLabelNumberOfLines
		
		self.priceLabel.font = Constants.priceLabelFont
		self.priceLabel.textAlignment = .left
		self.priceLabel.numberOfLines = Constants.priceLabelNumberOfLines
	}
	
	func setupImageView() {
		self.iconImage.contentMode = .scaleAspectFit
		
		self.selectedStateImage.contentMode = .scaleAspectFit
	}
	
	func setupContentView() {
//		self.contentView.layer.cornerRadius = 5
	}
}

// MARK: SetupConstraints

private extension MainListCollectionViewCell {
	func setupConstraints() {
		self.setupImagesConstraints()
		self.setupLabelsConstraints()
		self.setupContentViewConstraints()
	}
	
	func setupLabelsConstraints() {
		self.contentView.addSubview(self.titleLabel)
		self.contentView.addSubview(self.descriptionLabel)
		self.contentView.addSubview(self.priceLabel)
		
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constraints.titleLabelOffset),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.iconImage.trailingAnchor, constant: Constraints.iconImageOffset),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.selectedStateImage.leadingAnchor, constant: -Constraints.selectedStateImageOffset)
		])
		
		NSLayoutConstraint.activate([
			self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constraints.descriptionLabelOffset),
			self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
			self.descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
//			self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraints.descriptionLabelOffset)
		])
		
		NSLayoutConstraint.activate([
			self.priceLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: Constraints.priceLabelOffset),
			self.priceLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
			self.priceLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
//			self.priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraints.priceLabelOffset)
		])
	}
	
	func setupImagesConstraints() {
		self.contentView.addSubview(self.iconImage)
		self.contentView.addSubview(self.selectedStateImage)
		
		self.iconImage.translatesAutoresizingMaskIntoConstraints = false
		self.selectedStateImage.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.iconImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constraints.iconImageOffset),
			self.iconImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constraints.iconImageOffset),
			self.iconImage.widthAnchor.constraint(equalToConstant: Constraints.iconImageWidth),
			self.iconImage.heightAnchor.constraint(equalToConstant: Constraints.iconImageHeight)
		])
		
		NSLayoutConstraint.activate([
			self.selectedStateImage.centerYAnchor.constraint(equalTo: self.iconImage.centerYAnchor),
			self.selectedStateImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constraints.selectedStateImageOffset),
			self.selectedStateImage.widthAnchor.constraint(equalToConstant: Constraints.selectedStateImageWidth),
			self.selectedStateImage.heightAnchor.constraint(equalToConstant: Constraints.selectedStateImageWidth)
		])
	}

	func setupContentViewConstraints() {
		self.contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.contentView.bottomAnchor.constraint(equalTo: self.priceLabel.bottomAnchor),
			self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraints.selectedStateImageOffset)
		])
		
	}
}

// MARK: IMainListCollectionViewCell

extension MainListCollectionViewCell: IMainListCollectionViewCell {
	var title: String? {
		get {
			self.titleLabel.text
		}
		set {
			self.titleLabel.text = newValue
		}
	}
	
	var descriptionText: String? {
		get {
			self.descriptionLabel.text
		}
		set {
			self.descriptionLabel.text = newValue
		}
	}
	
	var price: String? {
		get {
			self.priceLabel.text
		}
		set {
			self.priceLabel.text = newValue
		}
	}
	
	var iconPath: String? {
		get {
			return nil
		}
		set {
			if let url = newValue {
				self.iconImage.imageFromServerURL(urlString: url)
			}
		}
	}
	
	var selectedState: Bool {
		get {
			self.selectedStateImage.image == Images.selectedIcon
		}
		set {
			self.selectedStateImage.image = newValue ? Images.selectedIcon : UIImage()
		}
	}

	func updateContent() {
		self.layoutSubviews()
	}
}
