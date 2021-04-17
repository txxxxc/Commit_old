//
//  AppDelegate.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/16.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleAPIClientForREST

class AppDelegate: NSObject, UIApplicationDelegate {
	let googleDelegate: GoogleDelegate = GoogleDelegate()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		GIDSignIn.sharedInstance()?.clientID = "289855344058-rdkvemkkcvimr072l29mvgh3hefiv1tj.apps.googleusercontent.com"
		GIDSignIn.sharedInstance().delegate = googleDelegate
		let driveFull = "https://www.googleapis.com/auth/drive"
		let sheetsFull = "https://www.googleapis.com/auth/spreadsheets"
		GIDSignIn.sharedInstance()?.scopes = [driveFull, sheetsFull]
		return true
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		// GIDSignInのhandle()を呼び、返り値がtrueであればtrueを返す
		if GIDSignIn.sharedInstance()!.handle(url) {
			return true
		}
		return false
	}
}

