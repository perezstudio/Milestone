//
//  SidebarView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

struct SidebarView: View {
	@Environment(\.modelContext) private var modelContext
	@Query(filter: #Predicate<Project> { project in
		project.favorite == true
	}, sort: \Project.name) private var favoriteProjects: [Project]
	
	@Binding var selection: SidebarItem?
	@State private var createProjectSheet = false
	@State private var createIssueSheet = false
	@State private var editingProject: Project?
	
	var body: some View {
		List(selection: $selection) {
			Section {
				NavigationLink(value: SidebarItem.inbox) {
					Label("Inbox", systemImage: "tray.fill")
				}
				
				NavigationLink(value: SidebarItem.today) {
					Label("Today", systemImage: "calendar")
				}
				
				NavigationLink(value: SidebarItem.scheduled) {
					Label("Scheduled", systemImage: "clock")
				}
			}
			
			Section("Workspace") {
				NavigationLink(value: SidebarItem.allIssues) {
					Label("All Issues", systemImage: "list.bullet")
				}
			}
			
			Section("Favorite Projects") {
				ForEach(favoriteProjects) { project in
					NavigationLink(value: SidebarItem.project(project)) {
						Label {
							Text(project.name)
						} icon: {
							Image(systemName: project.icon)
								.foregroundStyle(project.color.color)
						}
					}
				}
			}
		}
		.navigationTitle("Milestone")
		.toolbar {
			ToolbarItemGroup(placement: .primaryAction) {
				Menu {
					Button {
						createProjectSheet.toggle()
					} label: {
						Label("New Project", systemImage: "folder.badge.plus")
					}
					
					Button {
						createIssueSheet.toggle()
					} label: {
						Label("New Issue", systemImage: "plus.app")
					}
				} label: {
					Image(systemName: "plus")
				}
			}
		}
		.sheet(isPresented: $createProjectSheet) {
			CreateProjectView(project: $editingProject)
		}
		.sheet(isPresented: $createIssueSheet) {
			if let project = favoriteProjects.first {
				CreateIssueView(
					viewModel: ProjectViewModel(project: project, modelContext: modelContext),
					editingTodo: nil
				)
			}
		}
	}
}
