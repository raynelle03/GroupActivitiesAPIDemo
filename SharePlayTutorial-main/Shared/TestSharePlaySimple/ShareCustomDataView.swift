//
//  ShareCustomDataView.swift
//  SharePlayTutorial
//
//  Created by Raynelle Francisca on 14/12/22.
//

import Foundation
import SwiftUI
import GroupActivities
import AVKit
import Combine

struct ShareCustomDataView: View {
	@ObservedObject var viewModel: TestSharePlayViewModel

	var body: some View {

		VStack {
			Button("player 1", action: {
				viewModel.printValue(value: "Player 1 tapped")
			})
			Spacer()

			TextField("Present", text:  $viewModel.model.value )
			Spacer()

			Button("Start SharePlay", action: {
				viewModel.startSharing()
			})

			Spacer()
			Button("player 2", action: {
				viewModel.printValue(value: "Player 2 tapped")
			})

		}
		.task {
			for await session in SharePlayActivity.sessions() {
				print("== Participant joined")
				viewModel.configureGroupSession(session)
			}
		}
	}

}
