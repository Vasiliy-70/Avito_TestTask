//
//  MainListPresenter.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 14.01.2021.
//

protocol IMainListPresenter: class {
	func checkmark(item: Int)
	func selectAction()
	var viewData: MainListViewData? { get  set}
}

protocol IMainListPresenterData: class {
	func setData(entityModel: MainListEntity, error: String)
}

final class MainListPresenter {
	private weak var view: IMainListView?
	private var interactor: IMainListInteractor
	private var router: IMainListRouter
	private var entityModel = MainListEntity() {
		didSet {
			self.viewDataModel.title = self.entityModel.result?.title
			self.viewDataModel.selectActionTitle.notSelected = self.entityModel.result?.actionTitle ?? ""
			self.viewDataModel.selectActionTitle.selected = self.entityModel.result?.selectedActionTitle ?? ""

			if let list = self.entityModel.result?.list {
				var listItems = [ListItem]()
				for item in list {
					if (item.isSelected ?? false) {
						let listItem = ListItem(title: item.title,
												description: item.description,
												price: item.price,
												iconPath: item.icon?.url,
												isSelected: false)
						listItems.append(listItem)
					}
				}
				if listItems.count > 0 {
					self.viewDataModel.listItems = listItems
				}
			}
		}
	}
	
	private var viewDataModel = MainListViewData()
	
	init(view: IMainListView, interactor: IMainListInteractor,
		 router: IMainListRouter) {
		self.view = view
		self.interactor = interactor
		self.router = router
		self.interactor.loadData()
	}
}

// MARK: IMainListPresenter

extension MainListPresenter: IMainListPresenter {
	var viewData: MainListViewData? {
		get {
			self.viewDataModel
		}
		set {
			self.viewDataModel = newValue ?? MainListViewData()
		}
	}
	
	func checkmark(item: Int) {
		if let list = self.viewDataModel.listItems {
			var count = 0
			var newValue = false
			for _ in list {
				if count == item {
					newValue = !(self.viewDataModel.listItems?[count].isSelected ?? true)
					self.viewDataModel.listItems?[count].isSelected = newValue
				} else {
					self.viewDataModel.listItems?[count].isSelected = false
				}
				count += 1
			}
			self.viewDataModel.selectedState = newValue
			self.view?.updateInfo()
		}
	}
	
	func selectAction() {
		if let list = self.viewData?.listItems {
			for item in list {
				if item.isSelected {
					self.view?.showAlert(title: "Выбрана услуга",
										 description: item.title ?? "")
					return
				}
			}
		}
	}
}

// MARK: IMainListPresenterType

extension MainListPresenter: IMainListPresenterData {
	func setData(entityModel: MainListEntity, error: String) {
		if error != "" {
			self.view?.showAlert(title: "Ошибка загрузки данных",
								 description: error)
		} else {
			self.entityModel = entityModel
			self.view?.updateInfo()
		}
	}
}
