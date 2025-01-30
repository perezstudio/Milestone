//
//  ProjectDetailView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/25/25.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
	
	@Environment(\.modelContext) private var modelContext
	@State private var projectSelectedView: ProjectSelectedView = .board
	@State private var showCreateIssueSheet = false  // New state for the sheet
	@Bindable var project: Project
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
			switch projectSelectedView {
				case .board:
					ProjectBoardView(project: project)
				case .backlog:
					ProjectBacklogView(project: project)
				case .roadmap:
					Text("Roadmap View")
				case .sprint:
					Text("Sprint View")
				case .setting:
					Text("Setting View")
			}
		}
		.navigationTitle(projectSelectedView.rawValue.capitalized)
		.navigationSubtitle(project.name)
		.toolbar {
			ToolbarItem(placement: .principal) {
				Picker("", selection: $projectSelectedView) {
					ForEach(Array(ProjectSelectedView.allCases.enumerated()), id: \.element) { index, selectedProject in
						Image(systemName: selectedProject.iconName).tag(selectedProject)
							.keyboardShortcut(KeyboardShortcut(KeyEquivalent(Character("\(index + 1)")), modifiers: [.control]))
					}
				}
				.pickerStyle(.segmented)
			}
			ToolbarItem(placement: .navigation) {
				Button {
					showCreateIssueSheet.toggle()  // Use local state instead
				} label: {
					Label("New Issue", systemImage: "plus")
				}
				.keyboardShortcut("c", modifiers: [.command])
			}
		}
		.onAppear {
			viewModel = ProjectDetailViewModel(
				project: project,
				modelContext: modelContext
			)
		}
		.sheet(isPresented: $showCreateIssueSheet) {  // Use local state
			CreateIssueForm(viewModel: viewModel)
		}
	}
}
