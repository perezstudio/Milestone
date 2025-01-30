//
//  ContentView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/18/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Bindable var appState: AppState
	@State private var selectedTab: TabSelection = TabSelection.today
	@Query(filter: #Predicate<Project> { project in
		project.favorite == true
	}) var favoriteProjects: [Project]
	
	var body: some View {
		TabView(selection: $selectedTab) {
			// Main Tabs
			Tab("Inbox", systemImage: "tray.and.arrow.down.fill", value: TabSelection.inbox) {
				InboxView()
			}
			Tab("Today", systemImage: "star.fill", value: TabSelection.today) {
				TodayView()
			}
			Tab("Scheduled", systemImage: "calendar", value: TabSelection.scheduled) {
				ScheduledIssueView()
			}
			
			// First Section
			TabSection("Record Types") {
				Tab("All Projects", systemImage: "square.stack", value: TabSelection.allProjects) {
					AllProjectsView()
				}
				Tab("All Issues", systemImage: "checklist", value: TabSelection.allIssues) {
					AllIssuesView()
				}
			}
			
			// Projects Section with Dynamic Tabs
			TabSection("Favorite Projects") {
				ForEach(favoriteProjects) { project in
					Tab(project.name, systemImage: project.icon, value: TabSelection.project(project.id)) {
						ProjectDetailView(project: project)
					}
				}
			}
		}
		.tabViewStyle(.sidebarAdaptable)
		.sheet(isPresented: $appState.showCreateIssueWindow) {
			CreateIssueForm()
		}
	}
}

#Preview {
	
	let appState = AppState()
	
	ContentView(appState: appState)
		.modelContainer(for: Project.self, inMemory: true)
		.environment(appState)
}

enum TabSelection: Hashable {
	case inbox
	case today
	case scheduled
	case allIssues
	case allProjects
	case favorites
	case project(UUID)
}
