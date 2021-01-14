//
//  MainListView.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

import UIKit

final class MainListView: UIView {
	private let closeButtonImage = UIImageView()
	private let listCollection = UICollectionView()
	private let collectionViewController: IMainListCollectionViewController?
	
	private enum Constraints {
		static let closeButtonImageWidth: CGFloat = 52
		static let closeButtonImageHeight: CGFloat = 52
		static let closeButtonImageOffset: CGFloat = 10
	}
	
	init(collectionViewController: IMainListCollectionViewController) {
		self.collectionViewController = collectionViewController
		super.init(frame: .zero)
		
		self.setupViewAppearance()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension MainListView {
	func setupViewAppearance() {
		self.backgroundColor = .red
		self.setupImageView()
	}
	
	func setupImageView() {
		self.closeButtonImage.contentMode = .scaleAspectFit
		
		self.addSubview(self.closeButtonImage)
		self.closeButtonImage.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.closeButtonImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.closeButtonImageOffset),
			self.closeButtonImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.closeButtonImageOffset),
			self.closeButtonImage.widthAnchor.constraint(equalToConstant: Constraints.closeButtonImageWidth),
			self.closeButtonImage.heightAnchor.constraint(equalToConstant: Constraints.closeButtonImageHeight)
		])
	}
}
