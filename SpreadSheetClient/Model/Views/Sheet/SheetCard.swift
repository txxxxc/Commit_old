//
//  SpreadSheetCard.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/17.
//

import SwiftUI

let colors: [Color] = [
	Color(red: 235/255, green: 87/255, blue: 87/255),
	Color(red: 87/255, green: 235/255, blue: 124/255),
	Color(red: 87/255, green: 124/255, blue: 235/255),
	Color(red: 235/255, green: 87/255, blue: 235/255)
]
struct SheetCard: View {

	var sheetName: String
	var index: Int
	var body: some View {
				HStack(alignment: .center) {
					Text(sheetName)
						.font(.body)
						.fontWeight(.bold)
						.foregroundColor(.white)
					Spacer()
					Image(systemName: "chevron.forward")
						.foregroundColor(.white)
				}
				
				.padding(.all, 30)
				.background(colors[index])
				.cornerRadius(10)

	}
}

struct SheetCard_Previews: PreviewProvider {
	static var previews: some View {
		SheetCard(sheetName: "[D]大阪オフィス_4days", index: 3)
	}
}
