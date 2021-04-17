//
//  HomeView.swift
//  SpreadSheetClient
//
//  Created by Tomoya Tanaka on 2021/04/16.
//

import SwiftUI

class ViewModel: ObservableObject {
	@Published var isRegistered: Bool = false
}

struct HomeView: View {
	@EnvironmentObject var viewModel: ViewModel
	@AppStorage("isRegistered") var isRegistered: Bool = false
	var body: some View {
		Group {
			if viewModel.isRegistered {
				TodoContainerView()
			} else {
				SheetView()
			}
		}.onAppear(perform: {
			viewModel.isRegistered = isRegistered
		})
	}
}

struct HomeView_Previews: PreviewProvider {
	static let viewModel = ViewModel()
	static var previews: some View {
		HomeView()
			.environmentObject(viewModel)
	}
}
