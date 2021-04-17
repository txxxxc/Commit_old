//
//  SpreadSheetClientApp.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/16.
//

import SwiftUI
import GoogleSignIn

@main
struct SpreadSheetClientApp: App {
	@Environment(\.scenePhase) private var scenePhase
//	@EnvironmentObject var viewModel: ViewModel
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(appDelegate.googleDelegate)
				.environmentObject(ViewModel())
        }
		.onChange(of: scenePhase) { phase in
			if phase == .active {
				GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
				GIDSignIn.sharedInstance()?.restorePreviousSignIn()
			}
		}
    }
}
