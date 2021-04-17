//
//  TodoView.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/17.
//

import SwiftUI

struct TodoContainerView: View {
	@EnvironmentObject var googleDelegate: GoogleDelegate
	@AppStorage("currentSheetId") var currentSheetId: String = ""
	
	@State private var todos: [String] = []
    var body: some View {
		let rows: [String] = ["C", "D", "E", "F", "G", "H", "I", "J",
							  "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T","U", "V", "W", "X", "Y", "Z", "AA", "AB", "AC", "AD", "AE", "AF", "AG", "AH", "AI", "AJ", "AK", "AL", "AM", "AN", "AO"]
		return NavigationView {
			List {
				ForEach(0..<todos.count, id: \.self) { i in
					TodoView(title: todos[i].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), row: rows[i])
				}
				
			}
			.navigationTitle("Todo")
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.onAppear(perform: {
			getTodo()
		})
    }
	
	func getTodo() {
		guard let url = URL(string: generateURL().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
			print("Your API end point is Invalid")
			return
		}
		print(url)
		var request = URLRequest(url: url)
		let token: String = googleDelegate.token
		request.httpMethod = "GET"
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("クライアントエラー: \(error.localizedDescription) \n")
				return
			}
			
			guard let jsonData = data else {
				print("data not found")
				return
			}
			let decoder = JSONDecoder()
			
			do {
				let jsonstr: String = String(data: jsonData, encoding: .utf8)!
				print("jsonstr", jsonstr)
				let response = try decoder.decode(Todo.self, from: jsonData)
				DispatchQueue.main.async {
					todos = response.values[0]
				}
			} catch {
				print(error.localizedDescription)
				print(error)
			}
		}
		.resume()
	}
	
	func generateURL() -> String {
		let url = "https://sheets.googleapis.com/v4/spreadsheets/\(currentSheetId)/values/見る用!C3:AO3?"
		return url + "key=" + "AIzaSyBRHCPo-BiO9-0wW2stFdqMabCREp_rvvs"
	}
	
}

struct TodoContainerView_Previews: PreviewProvider {
    static var previews: some View {
		TodoContainerView()
    }
}
