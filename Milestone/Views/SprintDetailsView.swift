//
//  SprintDetailsView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI

struct SprintDetailsView: View {
	let viewModel: ProjectViewModel
	
	private var todosByStatus: [Status: [Todo]] {
		guard let currentSprint = viewModel.currentSprint else { return [:] }
		return Dictionary(grouping: currentSprint.todos) { $0.status }
	}
	
	var body: some View {
		ScrollView(.horizontal) {
			HStack(alignment: .top, spacing: 16) {
				ForEach(Status.allCases.filter { $0 != .canceled }, id: \.self) { status in
					StatusColumn(
						status: status,
						todos: todosByStatus[status] ?? [],
						viewModel: viewModel
					)
				}
			}
			.padding()
		}
	}
}

