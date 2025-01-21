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
	
	init(project: Project, modelContext: ModelContext) {
		_viewModel = State(initialValue: ProjectViewModel(project: project, modelContext: modelContext))
	}
	
	var body: some View {
		NavigationStack {
			VStack {
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

#Preview {
	ProjectView(
		project: Project(
			name: "Test Project",
			icon: "square.stack",
			color: .blue,
			notes: "",
			favorite: false
		),
		modelContext: try! ModelContainer(
			for: Project.self,
			configurations: ModelConfiguration(isStoredInMemoryOnly: true)
		).mainContext
	)
}
