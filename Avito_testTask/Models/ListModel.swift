//
//  ListModel.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 15.01.2021.
//

import UIKit

struct ListItem {
	var title: String
	var description: String
	var price: String
	var icon: UIImage
	var selectedState: Bool
}

final class ListModel {
	var listItems = [ListItem]()
	
	init() {
//		let item1 = ListItem(title: "XL-объявление", description: "Пользователи смогут посмотреть фотографии, описание и телефон прямо из результатов поиска.", price: "356 Р", icon: Images.closeIcon ?? UIImage(), selectedState: false)
		let item1 = ListItem(title: "XL-объявление", description: "Яркий цвет не даст затеряться среди других объявленийЯркий цвет не даст затеряться среди других объявленийЯркий цвет не даст затеряться среди других объявлений", price: "299 Р", icon: Images.closeIcon ?? UIImage(), selectedState: false)
		let item2 = ListItem(title: "Выделить цветом", description: "Яркий цвет не даст затеряться среди других объявленийЯркий цвет не даст затеряться среди других объявленийЯркий цвет не даст затеряться среди других объявлений.", price: "299 Р", icon: Images.closeIcon ?? UIImage(), selectedState: true)
		self.listItems = [item2, item1]
	}
}
