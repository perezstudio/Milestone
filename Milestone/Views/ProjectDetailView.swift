//
//  ProjectDetailView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/25/25.
//

import SwiftUI

struct ProjectDetailView: View {
	
	@Environment(AppState.self) private var appState
	@Environment(\.modelContext) private var modelContext
	@State private var projectSelectedView: ProjectSelectedView = .board
	@Bindable var project: Project
	
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
					appState.showCreateIssueWindow.toggle()
				} label: {
					Label("New Issue", systemImage: "plus")
				}
				.keyboardShortcut("c", modifiers: [.command])
			}
		}
    }
}
