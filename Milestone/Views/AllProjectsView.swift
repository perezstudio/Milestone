//
//  AllProjectsView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/25/25.
//

import SwiftUI
import SwiftData

struct AllProjectsView: View {
	
	@Query(sort: \Project.id) var projects: [Project]
	@State var createProjectSheet: Bool = false
	@State var nameField: Bool = true
	@State var priorityField: Bool = true
	@State var statusField: Bool = true

	var body: some View {
		NavigationStack {
			List {
				ForEach(projects) { project in
					NavigationLink(destination: ProjectDetailView(project: project)) {
						ProjectCardView(project: project)
					}
				}
			}
			.navigationTitle("All Projects")
			.toolbar {
				ToolbarItem(placement: .navigation) {
					Button {
						createProjectSheet.toggle()
					} label: {
						Label("New Project", systemImage: "plus")
					}
				}
				ToolbarItem(placement: .automatic) {
					Menu {
						Toggle("Name", isOn: $nameField)
						Toggle("Priority", isOn: $priorityField)
						Toggle("Status", isOn: $statusField)
					} label: {
						Label("Visible Fields", systemImage: "list.triangle")
					}
				}
			}
			.sheet(isPresented: $createProjectSheet) {
				CreateProjectView()
			}
		}
	}
}

#Preview {
    AllProjectsView()
}
