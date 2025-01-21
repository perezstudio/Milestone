//
//  SprintDetailsView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI

struct SprintDetailsView: View {
	@Bindable var sprint: Sprint
	
	// Add this computed property
	private var todosByStatus: [Status: [Todo]] {
		Dictionary(grouping: sprint.todos) { $0.status }
	}
	
	var body: some View {
		ScrollView(.horizontal) {
			HStack(alignment: .top, spacing: 16) {
				ForEach(Status.allCases.filter { $0 != .canceled }, id: \.self) { status in
					StatusColumn(sprint: sprint, status: status, todosByStatus: todosByStatus)
				}
			}
			.padding()
		}
	}
}

