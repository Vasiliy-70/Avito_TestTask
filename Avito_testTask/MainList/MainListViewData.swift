//
//  MainListViewData.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 15.01.2021.
//

struct MainListViewData {
	var title: String?
	var selectActionTitle: (selected: String?, notSelected: String?)
	var selectedState: Bool?
	var listItems: [ListItem]?
}

struct ListItem {
	var title: String?
	var description: String?
	var price: String?
	var iconPath: String?
	var isSelected: Bool
}
