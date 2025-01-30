//
//  ProjectBoardView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/26/25.
//

import SwiftUI
import SwiftData

struct ProjectBoardView: View {
	@Bindable var project: Project
	@Environment(\.modelContext) private var modelContext
	@State private var viewModel: ProjectDetailViewModel
	
	init(project: Project) {
		self.project = project
		_viewModel = State(initialValue: ProjectDetailViewModel(
			project: project,
			modelContext: ModelContext(try! ModelContainer(for: Project.self))
		))
	}

	var body: some View {
		VStack {
			if ((project.currentSprint) != nil) {
				ScrollView(.horizontal) {
					HStack(alignment: .top, spacing: 16) {
						// Column for issues without a status
						StatusColumnView(
							title: "No Status",
							icon: "questionmark.circle",
							color: .gray,
							issues: viewModel.issuesForStatus(nil)  // Changed to use viewModel
						)

						// Columns for each status
						ForEach(Status.allCases, id: \.self) { status in
							StatusColumnView(
								title: status.rawValue.capitalized,
								icon: status.iconName,
								color: status.color,
								issues: viewModel.issuesForStatus(status)  // Changed to use viewModel
							)
						}
					}
					.padding()
				}
			} else {
				ContentUnavailableView {
					Label("No Active Sprint", systemImage: "point.forward.to.point.capsulepath")
				} description: {
					Text("Go to your backlog to create, organize, and select your active sprint.")
				}
			}
		}
		.onAppear {
			viewModel = ProjectDetailViewModel(
				project: project,
				modelContext: modelContext
			)
		}
	}
}

#Preview {
	
	let testProject = Project(name: "Test Project", icon: "stack.square", color: ProjectColor.blue, priority: Priority.high, notes: "Test Note", favorite: false)
	let testIssue = Issue(title: "Text", notes: "Test Note", project: testProject)
	
	ProjectBoardView(project: testProject)
		.modelContainer(for: Project.self, inMemory: true)
}
