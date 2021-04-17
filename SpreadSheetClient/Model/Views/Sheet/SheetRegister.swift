//
//  SheetRegister.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/17.
//

import SwiftUI

struct SheetRegister: View {
	@EnvironmentObject var viewModel: ViewModel
	@AppStorage("currentSheetId") var currentSheetId: String = ""
	@AppStorage("currentColumnId") var currentColumnId: String = ""
	@AppStorage("isRegistered") var isRegistered: Bool = false
	@AppStorage("currentMentorName") var currentMentorName: String = ""
	var mentorName: String
	var sheetId: String
	var sheetName: String
	var columnId: Int
	
    var body: some View {
		VStack(alignment: .center) {
			Spacer()
			Text("シート名")
				.fontWeight(.bold)
				.font(.title3)
			Text(sheetName)
			Text("メンター名")
				.fontWeight(.bold)
				.font(.title3)
				.padding(.top, 20)
			Text(mentorName)
			Spacer()
			Button(action: {
				viewModel.isRegistered.toggle()
				currentSheetId = sheetId
				currentColumnId = String(columnId)
				currentMentorName = mentorName
				isRegistered.toggle()
			}, label: {
				Text("登録する")
					.fontWeight(.bold)
					.padding(.leading, 30)
					.padding(.trailing, 30)
					.padding(.top, 20)
					.padding(.bottom, 20)
					.background(Color.green)
					.foregroundColor(.white)
					.cornerRadius(10)
					.padding(.bottom, 20)
			})
			
		}
    }
}

struct SheetRegister_Previews: PreviewProvider {
    static var previews: some View {
		SheetRegister(mentorName: "てぃーてぃー", sheetId: "id", sheetName: "シート名", columnId: 5)
    }
}
