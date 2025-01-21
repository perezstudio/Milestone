//
//  SprintListView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI

struct SprintListView: View {
	@Bindable var viewModel: ProjectViewModel
	
	var body: some View {
		ScrollView {
			VStack(spacing: 16) {
				ForEach(viewModel.sprints) { sprint in
					SprintCard(sprint: sprint, viewModel: viewModel)
				}
			}
			.padding()
		}
		.frame(width: 350)
	}
}


