//
//  AlertView.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/17.
//

import SwiftUI

struct AlertView: View {
	@AppStorage("currentMentorName") var currentMentorName: String = ""
	@State private var mentorName: String = ""
	@State private var text: String = ""
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					VStack(alignment: .center, spacing: 20) {
						VStack(alignment: .leading) {
							Text("メンター名")
								.fontWeight(.medium)
								.font(.title3)
							TextField("メンター名", text: $mentorName)
								.textFieldStyle(RoundedBorderTextFieldStyle())
						}
						VStack(alignment: .leading) {
							Text("コメント")
								.fontWeight(.medium)
								.font(.title3)
							TextField("要件を書いてね！", text: $text)
								.textFieldStyle(RoundedBorderTextFieldStyle())
						}
						Spacer()
						Button(action: {
							sendAlert()
						}, label: {
							Text("送信する")
								.fontWeight(.bold)
								.font(.title3)
								.foregroundColor(.white)
								.padding()
								.frame(width: 300, height: nil, alignment: .center)
								.background(Color.green)
								.cornerRadius(10)
						})
					}
					Spacer()
				}
				.padding()
			}
			.navigationTitle("Alert")
			.padding(.bottom, 30)
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.onAppear(perform: {
			mentorName = currentMentorName
		})
	}
	
	func sendAlert() {
		print("generatedURL:", generateURL())
		guard let url = URL(string: generateURL().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
			print("Your API end point is Invalid")
			return
		}
		print(url)
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
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
				let response = try decoder.decode([Alert].self, from: jsonData)
				print(response[0].status)
			} catch {
				print(error.localizedDescription)
				print(error)
			}
		}
		.resume()
	}
	func generateURL() -> String {
		return "https://camp-emergency-button-bot.herokuapp.com/help?user=\(mentorName)&comment=\(text)"
	}
}


struct AlertView_Previews: PreviewProvider {
	static var previews: some View {
		AlertView()
	}
}
