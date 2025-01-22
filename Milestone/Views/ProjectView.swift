//
//  ProjectView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

struct ProjectView: View {
	@State private var viewModel: ProjectViewModel
	@ObservedObject var appState: AppState
	
	init(project: Project, modelContext: ModelContext, appState: AppState) {
		_viewModel = State(initialValue: ProjectViewModel(project: project, modelContext: modelContext))
		self.appState = appState
	}
	
	var body: some View {
		NavigationStack {
			mainContent
				.navigationTitle(viewModel.project.name)
				.toolbar {
					ToolbarItem(placement: .principal) {
						Picker("View", selection: $viewModel.selectedView) {
							ForEach(ProjectSelectedView.allCases, id: \.self) { view in
								Label {
									Text(view.viewName)
								} icon: {
									Image(systemName: view.viewIcon)
								}
								.tag(view)
							}
						}
						.pickerStyle(.segmented)
					}
				}
		}
		.onChange(of: viewModel.selectedTodo) { oldValue, newValue in
			appState.selectedTodo = newValue
			if newValue != nil && !appState.showInspector {
				appState.showInspector = true
			}
		}
	}
	
	@ViewBuilder
	private var mainContent: some View {
		switch viewModel.selectedView {
		case .currentSprint:
			CurrentSprintView(viewModel: viewModel)
		case .backlog:
			BacklogView(viewModel: viewModel)
		case .roadmap:
			RoadmapView()
		case .releases:
			ReleasesView()
		case .settings:
			SettingsView()
		}
	}
}

enum ProjectSelectedView: String, Codable, CaseIterable {
	case currentSprint, backlog, roadmap, releases, settings
	
	var viewName: String {
		switch self {
		case .currentSprint: return "Current Sprint"
		case .backlog: return "Backlog"
		case .roadmap: return "Roadmap"
		case .releases: return "Releases"
		case .settings: return "Settings"
		}
	}
	
	var viewIcon: String {
		switch self {
		case .currentSprint: return "star.fill"
		case .backlog: return "list.bullet"
		case .roadmap: return "map"
		case .releases: return "list.bullet.below.rectangle"
		case .settings: return "gear"
		}
	}
}
