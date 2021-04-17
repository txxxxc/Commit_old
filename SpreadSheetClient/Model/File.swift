//
//  File.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/16.
//

import Foundation

struct FileResponse: Decodable {
	let kind: String
	let files: [File]
}

struct File: Decodable, Identifiable {
	var mimeType: String
	var id: String
	var kind: String
	var name: String
}
