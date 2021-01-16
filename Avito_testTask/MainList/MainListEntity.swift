//
//  MainListEntity.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 16.01.2021.
//

struct MainListEntity: Codable {
	var status: String?
	var result: Result?
}

struct Result: Codable {
	var title: String?
	var actionTitle: String?
	var selectedActionTitle: String?
	var list: [List]?
}

struct List: Codable {
	var id: String?
	var title: String?
	var description: String?
	var icon: Icon?
	var price: String?
	var isSelected: Bool?
}

struct Icon: Codable {
	var url: String?
	
	enum CodingKeys: String, CodingKey {
		case url = "52x52"
	}
}
