//
//  ProjectBacklogView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/26/25.
//

import SwiftUI
import SwiftData
import Observation

struct ProjectBacklogView: View {
	@Bindable var project: Project
	@Environment(\.modelContext) private var modelContext
	@State private var viewModel: ProjectDetailViewModel
	@State private var refreshID = UUID()  // Added missing refreshID
	@State private var createSprintSheet = false  // Added missing createSprintSheet
	
	init(project: Project) {
		self.project = project
		// Use the injected modelContext instead of ModelContext.shared
		_viewModel = State(initialValue: ProjectDetailViewModel(
			project: project,
			modelContext: ModelContext(try! ModelContainer(for: Project.self))
		))
	}
	
	var body: some View {
		VStack {
			if (!viewModel.backlogIssues.isEmpty) {
				List {
					ForEach(viewModel.backlogIssues) { issue in
						Text(issue.title)
					}
				}
			} else {
				ContentUnavailableView {
					Label("No Backlog Items", systemImage: "list.bullet")
				} description: {
					Text("No backlog items have been added to this project yet. Create your first backlog item.")
				}
			}
		}
		.id(refreshID)
		.onChange(of: viewModel.backlogIssues.count) {
			refreshID = UUID()
		}
		.toolbar {
			ToolbarItemGroup(placement: .primaryAction) {
				Button {
					createSprintSheet.toggle()
				} label: {
					Label("Create Sprint", systemImage: "calendar.badge.plus")
				}
				.keyboardShortcut("s", modifiers: [.command])
			}
		}
		.sheet(isPresented: $createSprintSheet) {
			CreateSprintView()
		}
	}
}
