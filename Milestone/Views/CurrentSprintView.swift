//
//  CurrentSprintView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import Observation

struct CurrentSprintView: View {
	let viewModel: ProjectViewModel
	
	var body: some View {
		if let currentSprint = viewModel.currentSprint {
			SprintDetailsView(viewModel: viewModel)
				.navigationTitle(currentSprint.title)
				#if os(macOS)
				.navigationSubtitle(viewModel.project.name)
				#endif
		} else {
			ContentUnavailableView(
				"No Active Sprint",
				systemImage: "calendar.badge.plus",
				description: Text("Create a new sprint to start planning your work")
			)
			.navigationTitle("Current Sprint")
			#if os(macOS)
			.navigationSubtitle(viewModel.project.name)
			#endif
		}
	}
}
