//
//  CurrentSprintView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI

struct CurrentSprintView: View {
	let project: Project
	
	var body: some View {
		if let currentSprint = project.currentSprint {
			// Show sprint details
			SprintDetailsView(sprint: currentSprint)
				.navigationTitle(currentSprint.title)
				.navigationSubtitle(project.name)
		} else {
			// Show empty state or creation prompt
			ContentUnavailableView(
				"No Active Sprint",
				systemImage: "calendar.badge.plus",
				description: Text("Create a new sprint to start planning your work")
			)
			.navigationTitle("Current Sprint")
			.navigationSubtitle(project.name)
		}
	}
}

