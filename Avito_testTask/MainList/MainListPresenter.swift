//
//  MainListPresenter.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

protocol IMainListPresenter: class {
	func checkmark(item: Int)
	func selectAction()
	var listContent: MainListViewData? { get  set}
}

protocol IMainListPresenterType: class {
	func setData(entityModel: MainListEntity, error: String)
}

final class MainListPresenter {
	private weak var view: IMainListView?
	private var interactor: IMainListInteractor
	private var router: IMainListRouter
	private var entityModel = MainListEntity() {
		didSet {
			self.viewInfo.title = self.entityModel.result?.title
			self.viewInfo.selectedActionTitle = self.entityModel.result?.selectedActionTitle

			if let list = self.entityModel.result?.list {
				var listItems = [ListItem]()
				for item in list {
					if (item.isSelected ?? false) {
						let listItem = ListItem(title: item.title, description: item.description, price: item.price, iconPath: item.icon?.url, selectedState: false)
						listItems.append(listItem)
					}
				}
				if listItems.count > 0 {
					self.viewInfo.listItems = listItems
				}
			}
		}
	}
	
	private var viewInfo = MainListViewData() {
		didSet {
			self.view?.updateInfo()
		}
	}
	
	init(view: IMainListView, interactor: IMainListInteractor, router: IMainListRouter) {
		self.view = view
		self.interactor = interactor
		self.router = router
		self.interactor.loadData()
	}
}

// MARK: IMainListPresenter

extension MainListPresenter: IMainListPresenter {
	var listContent: MainListViewData? {
		get {
			self.viewInfo
		}
		set {
			self.viewInfo = newValue ?? MainListViewData()
		}
	}
	
	func checkmark(item: Int) {
		if let list = self.viewInfo.listItems {
			var count = 0
			var newValue = false
			for _ in list {
				if count == item {
					newValue = !(self.viewInfo.listItems?[count].selectedState ?? true)
					self.viewInfo.listItems?[count].selectedState = newValue
				} else {
					self.viewInfo.listItems?[count].selectedState = false
				}
				count += 1
			}
			self.view?.selectedState = newValue
		}
	}
	
	func selectAction() {
		if let list = self.listContent?.listItems {
			for item in list {
				if item.selectedState {
					self.view?.showAlert(title: "Выбрана услуга", description: item.title ?? "")
					return
				}
			}
		}
	}
}

// MARK: IMainListPresenterType

extension MainListPresenter: IMainListPresenterType {
	func setData(entityModel: MainListEntity, error: String) {
		if error != "" {
			self.view?.showAlert(title: "Ошибка загрузки данных", description: error)
		} else {
			self.entityModel = entityModel
		}
	}
}
