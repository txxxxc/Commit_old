//
//  Sheet.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/17.
//

import Foundation

struct Mentors: Decodable {
	let values: [[String]]
}

struct Todo: Decodable {
	let values: [[String]]
}

//struct Mentor: Decodable, Identifiable {
//	var mimeType: String
//	var id: String
//	var kind: String
//	var name: String
//}
