//
//  TestSharePlayViewModel.swift
//  SharePlayTutorial
//
//  Created by Raynelle Francisca on 24/11/22.
//

import GroupActivities
import SwiftUI


struct TestSharePlayModel: Codable {
	var value: String = ""
}

@MainActor
class TestSharePlayViewModel: ObservableObject {

	@Published  var model: TestSharePlayModel

	var valueToPrint: String {
		print("Model changed \(model.value)")
		return model.value

	}

	init(model: TestSharePlayModel) {
		self.model = model
	}


	var tasks = Set<Task<Void, Never>>()
	var messenger: GroupSessionMessenger?


	func printValue(value: String) {
		print("== value  \(value)")
		model.value =  value
		send(model)
	}

	func startSharing() {
		Task {
			do {
				_ = try await SharePlayActivity().activate()
			} catch {
				print("Failed to activate SharePlay activity: \(error)")
			}
		}
	}

	func configureGroupSession(_ session: GroupSession<SharePlayActivity>) {
		print("Recieved viewModel")
		let messenger = GroupSessionMessenger(session: session)
		self.messenger = messenger

		let task = Task {
			for await (sharePlayModel, _) in messenger.messages(of: TestSharePlayModel.self) {
				print("Handle recieved model value \(sharePlayModel.value)")
				handle(sharePlayModel)
			}
		}
		tasks.insert(task)

		session.join()
	}

	func handle(_ model: TestSharePlayModel) {
		self.model = model
	}

	func send(_ model: TestSharePlayModel) {
		print("Sending viewModel")
		Task {
			do {
				try await messenger?.send(model)
			} catch {
				print("Send SharePlayModel failed: \(error)")
			}
		}
	}

}
