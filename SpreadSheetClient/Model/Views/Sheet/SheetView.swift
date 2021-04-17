//
//  TODOView.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/17.
//

import SwiftUI
import GoogleSignIn

struct SheetView: View {
	@EnvironmentObject var googleDelegate: GoogleDelegate
	@State var sheets: [File] = []
	var body: some View {
		NavigationView {
			VStack(alignment: .center, spacing: 20) {
				ForEach(0..<sheets.count, id: \.self) { i in
					NavigationLink(destination: SheetDetail(sheetId: sheets[i].id, sheetName: sheets[i].name)) {
						SheetCard(sheetName: sheets[i].name, index: i)
					}
					.padding(.leading, 10)
					.padding(.trailing, 10)
				}
			}
			.toolbar {
				Button(action: {
					print("hoge")
				}, label: {
					Image(systemName: "person.crop.circle")
				})
			}
			.navigationTitle("ToDo")
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.onAppear(perform: {
			getSpreadSheetData()
		})
		
	}
	
	func getSpreadSheetData() {
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
//				print("jsonstr", jsonstr)
				let response = try decoder.decode(FileResponse.self, from: jsonData)
				DispatchQueue.main.async {
					sheets = response.files
//					print(sheets[0].name)
				}
//				print("response", response.kind)
			} catch {
				print(error.localizedDescription)
				print(error)
			}
		}
		.resume()
		
	}
	
	func generateURL() -> String {
		let url = "https://www.googleapis.com/drive/v3/files?"
		return url + "&q=(mimeType='application/vnd.google-apps.spreadsheet' and name contains 'Mentor')&supportsTeamDrives=true&includeItemsFromAllDrives=true" + "&key=" + googleDelegate.token
	}
}

//(mimeType='application/vnd.google-apps.spreadsheet' and name contains 'Move')

struct SheetView_Previews: PreviewProvider {
	static var previews: some View {
		SheetView()
	}
}
