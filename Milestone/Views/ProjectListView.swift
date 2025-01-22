//
//  ProjectListView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
	@Environment(\.modelContext) var modelContext
	@EnvironmentObject private var appState: AppState
	@Query(sort: \Project.name) private var projects: [Project]
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(projects) { project in
					NavigationLink(destination: ProjectView(
						project: project,
						modelContext: modelContext,
						appState: appState
					)) {
						Label {
							Text(project.name)
						} icon: {
							Image(systemName: project.icon)
						}
					}
				}
			}
			.navigationTitle("Projects")
		}
	}
}

#Preview {
	ProjectListView()
		.modelContainer(for: Project.self, inMemory: true)
		.environmentObject(AppState())
}
