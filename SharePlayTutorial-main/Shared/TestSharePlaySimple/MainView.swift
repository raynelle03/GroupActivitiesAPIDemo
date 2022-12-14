//
//  MainView.swift
//  SharePlayTutorial
//
//  Created by Raynelle Francisca on 14/12/22.
//

import Foundation
import SwiftUI



struct MainView: View {

	   var body: some View {
		   NavigationView {
			   VStack {
				   Text("Group Activities API")

				   NavigationLink(destination:  ShareCustomDataView(viewModel: TestSharePlayViewModel(model: TestSharePlayModel()))) {
					   Text("Share Custom Data")
				   }

				   NavigationLink(destination: VideoSynchronisationView()) {
					   Text("Sync video across devices")
				   }
			   }
		   }

	   }

}
