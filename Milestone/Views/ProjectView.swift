//
//  ProjectView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI

struct ProjectView: View {
	@Bindable var project: Project
	@State private var selectedView: ProjectSelectedView = .currentSprint  // Add default value
	@State private var favoriteColor: Int = 0
	
	var body: some View {
		NavigationStack {
			VStack {
				switch selectedView {
				case .currentSprint:
					CurrentSprintView(project: project)
				case .backlog:
					BacklogView()
				case .roadmap:
					RoadmapView()
				case .releases:
					ReleasesView()
				case .settings:
					SettingsView()
				}
			}
			.navigationTitle(project.name)
			.toolbar {
				Picker("View", selection: $selectedView) {
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

//#Preview {
//	var testProject = Project(name: "Test Project", icon: "square.stack", color: ProjectColor.blue, notes: "", favorite: false)
//	ProjectView(project: testProject)
//}
