//
//  SprintListView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI

struct SprintListView: View {
	
	@Bindable var project: Project
	
    var body: some View {
		ScrollView {
			VStack(spacing: 16) {
				ForEach(project.sprints.filter { $0.status != .completed }) { sprint in
					SprintCard(sprint: sprint, project: project)
				}
			}
			.padding()
		}
		.frame(width: 350)
    }
}
