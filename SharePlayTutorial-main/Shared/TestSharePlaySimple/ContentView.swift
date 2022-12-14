//
//  ContentView.swift
//  SharePlayTutorial
//
//  Created by Raynelle Francisca on 24/11/22.
//

import Foundation
import SwiftUI
import GroupActivities
import AVKit
import Combine

struct ContentView: View {

	//Video Synchronization Implementation!!

	@State private var subscriptions = Set<AnyCancellable>()
	@State var player = AVPlayer()

	// The group session to coordinate playback with.
	@State private var groupSession: GroupSession<MovieWatchingActivity>? {
		didSet {
			guard let session = groupSession else {
				// Stop playback if a session terminates.
				player.rate = 0
				return
			}
			// Coordinate playback with the active session.
			player.playbackCoordinator.coordinateWithSession(session)
		}
	}


	@State private var movie: Movie? {
		didSet {
			guard let movie = movie else { return }
			let playerItem = AVPlayerItem(url: movie.url)
			player.replaceCurrentItem(with: playerItem)
		}
	}

	   var body: some View {
		   VStack {

			   VideoPlayer(player: player)
				   .onAppear() {
				   movie = Movie(url: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2020/10653/8/E739CC44-25A9-46B9-8E40-1788530C5785/master.m3u8")!, title: "test")

					   }

			   ScrollView {
				   VStack(alignment: .center) {
					   Button {
						   if let movie = movie {
							   preparesToPlay(movie)
						   }

					   } label: {
						   Label("Start", systemImage: "shareplay")
					   }
					   .buttonStyle(.bordered)
					   .cornerRadius(20)
				   }

				   VStack(alignment: .leading, spacing: 20) {
					   if let movie = movie {
						   Text(movie.title)
							   .font(.title2)
							   .fontWeight(.bold)
					   }

				   }
			   }
			   .padding(12)
		   }
		   .task {
			   for await session in MovieWatchingActivity.sessions() {
				   groupSession = session
				   subscriptions.removeAll()

				   session.$activity
					   .sink { activity in
						   print("Activity Changed: \(activity.metadata.title ?? "No title for this video")")
					   }
					   .store(in: &subscriptions)

				   session.join()
			   }
		   }
	   }



	private mutating func configureGroupSession(_ session: GroupSession<MovieWatchingActivity>) {
		self.groupSession = session
		subscriptions.removeAll()

		session.$activity
			.sink { activity in
				print("Activity Changed: \(activity.metadata.title ?? "No title for this video")")
			}
			.store(in: &subscriptions)

		session.join()
	  }


	func preparesToPlay(_ movie: Movie) {
		let activity = MovieWatchingActivity(movie: movie)


		Task {
			switch await activity.prepareForActivation() {
			case .activationDisabled:
				//Playback co-ordination isnt active
				print("user has activationDisabled")
				break
			case .activationPreferred:
				//Share tthe movie to the group
				print("user hasShare tthe movie to the group")
				_ = try await activity.activate()
			case .cancelled:
				// User has cancelled tthe operation
				print("user has cancelled operation")
			default:
				break
			}
		}

	}
}

