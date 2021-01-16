//
//  MainListInteractor.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 16.01.2021.
//
import UIKit

protocol IMainListInteractor: class {
	func loadData()
}

final class MainListInteractor {
	private var queryService: IQueryService = QueryService()
	weak var presenter: IMainListPresenterType?
	private var url = "https://raw.githubusercontent.com/avito-tech/internship/main/result.json"
}

private extension MainListInteractor {
	func JSONParse(data: Data) -> (MainListEntity, String) {
		var errorDescription = ""
		var entityModel = MainListEntity()
		
		do {
			entityModel = try JSONDecoder().decode(MainListEntity.self, from: data)
			print(entityModel)
		} catch let error {
			errorDescription = error.localizedDescription
		}
		
		return (entityModel, errorDescription)
	}
}

// MARK: IMainListInteractor

extension MainListInteractor: IMainListInteractor {
	func loadData() {
		var entityModel = MainListEntity()
		var errorDescription = ""
		
		guard let url = URL(string: self.url) else {
			self.presenter?.setData(entityModel: entityModel, error: "URL is not correct")
			return
		}

		self.queryService.getDataAt(url: url) { (data, error) in
			if error == "" {
				let entity = self.JSONParse(data: data)
				entityModel = entity.0
				print(entityModel)
				errorDescription = entity.1
			} else {
				errorDescription = error
			}
			self.presenter?.setData(entityModel: entityModel, error: errorDescription)
		}
	}
}

