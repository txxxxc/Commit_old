//
//  SignInView.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/16.
//

import SwiftUI
import GoogleSignIn

struct SignInView: View {
    var body: some View {
		Button(action: {
			GIDSignIn.sharedInstance().signIn()
		}) {
			Text("Sign In")
		}
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
