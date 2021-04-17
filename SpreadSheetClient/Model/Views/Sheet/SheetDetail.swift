//
//  SelectMentor.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/17.
//

import SwiftUI

struct SheetDetail: View {
	var sheetId: String
	var sheetName: String
	
	@State var mentors: [String] = []
	@EnvironmentObject var googleDelegate: GoogleDelegate
	
    var body: some View {
		let columnId: Int = 6
		return HStack {
				VStack(alignment: .leading, spacing: 20) {
					Spacer()
					List {
						ForEach(0..<mentors.count, id: \.self) { i in
							NavigationLink(destination: SheetRegister(mentorName: mentors[i], sheetId: sheetId, sheetName: sheetName, columnId: columnId + i)) {
									Text("\(mentors[i])")
							}
						}
					}
				}
				Spacer()
					.navigationTitle("メンター一覧")
			}
		.navigationViewStyle(StackNavigationViewStyle())
		.onAppear(perform: {
			getMentorList()
		})
    }
	
	func getMentorList() {
		guard let url = URL(string: generateURL().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
			print("Your API end point is Invalid")
			return
		}
		var request = URLRequest(url: url)
		let token: String = googleDelegate.token
		print(url)
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
				let response = try decoder.decode(Mentors.self, from: jsonData)
				print("response", response.values)
				print("response", response.values[0])
				
				DispatchQueue.main.async {
					let flat = response.values.flatMap { $0.map { "\($0)"} }
					print(flat)
					mentors = flat
				}
			} catch {
				print(error.localizedDescription)
				print(error)
			}
		}
		.resume()
		
	}
	
	func generateURL() -> String {
		print("sheetId", sheetId)
		print("token", googleDelegate.token)
		let url = "https://sheets.googleapis.com/v4/spreadsheets/\(sheetId)/values/見る用!B6:B20?"
		return url + "key=" + "AIzaSyBRHCPo-BiO9-0wW2stFdqMabCREp_rvvs"
	}
}

struct SheetDetail_Previews: PreviewProvider {
    static var previews: some View {
		SheetDetail(sheetId: "hoge", sheetName: "シート名")
    }
}

