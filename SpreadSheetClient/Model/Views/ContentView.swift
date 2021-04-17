//
//  ContentView.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/16.
//

import GoogleSignIn
import SwiftUI

//struct SignInButton: UIViewRepresentable {
//	func makeUIView(context: Context) -> GIDSignInButton {
//		let button = GIDSignInButton()
//		button.colorScheme = .light
//		return button
//	}
//
//	func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
//}

struct ContentView: View {
	@EnvironmentObject var googleDelegate: GoogleDelegate
	@EnvironmentObject var viewModel: ViewModel
	@State private var selection: Int = 1
	let generator = UIImpactFeedbackGenerator(style: .light)
	
	var body: some View {
		if googleDelegate.signedIn {
			TabView(selection: $selection) {
				HomeView()
					.environmentObject(viewModel)
					.tabItem {
						Image(systemName: "checkmark.square")
						Text("Todo")
					}.tag(1)
				AlertView()
					.tabItem {
						Image(systemName: "bolt.fill")
						Text("アラート")
					}
					.tag(2)
			}
			.onChange(of: selection, perform: { value in
				generator.impactOccurred()
			})
		} else {
			SignInView()
		}
	}
	func simpleSuccess() {
		generator.impactOccurred()
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static let shared = UIApplication.shared.delegate as! AppDelegate
	static let viewModel = ViewModel()
	static var previews: some View {
		ContentView()
			.environmentObject(shared.googleDelegate)
			.environmentObject(viewModel)
	}
}
