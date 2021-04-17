//
//  TodoView.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/17.
//

import SwiftUI

struct TodoView: View {
	var title: String
	// 例: Dなど
	var row: String
	@EnvironmentObject var googleDelegate: GoogleDelegate
	@AppStorage("currentSheetId") var currentSheetId: String = ""
	@AppStorage("currentColumnId") var currentColumnId: String = ""
	@State private var checked: Bool = false
	
    var body: some View {
		HStack {
			Text(title)
			Spacer()
			Button(action: {
				checked.toggle()
				if checked {
					doneMentorTodo()
				}
			}, label: {
				if checked {
					Image(systemName: "checkmark.square.fill")
						.resizable()
						.frame(width: 32, height: 32, alignment: .center)
				} else {
					Image(systemName: "square")
						.resizable()
						.frame(width: 32, height: 32, alignment: .center)
				}
			})
		}
		.padding(.top, 10)
		.padding(.bottom, 10)
    }
	
	func doneMentorTodo() {
		print("done")
		guard let url = URL(string: generateURL().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
			print("Your API end point is Invalid")
			return
		}
		print(url)
		var request = URLRequest(url: url)
		let token: String = googleDelegate.token
		request.httpMethod = "PUT"
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		let json: [String: Any] = ["values": [["DONE"]]]
		request.httpBody = try? JSONSerialization.data(withJSONObject: json)
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("クライアントエラー: \(error.localizedDescription) \n")
				return
			}
			guard let jsonData = data else {
				print("data not found")
				return
			}
		}
		.resume()
	}
	
	func generateURL() -> String {
		let url = "https://sheets.googleapis.com/v4/spreadsheets/\(currentSheetId)/values/見る用!\(row + currentColumnId)?valueInputOption=RAW"
		return url + "&key=" + "AIzaSyBRHCPo-BiO9-0wW2stFdqMabCREp_rvvs"
	}
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(title: "Task", row: "A")
    }
}
