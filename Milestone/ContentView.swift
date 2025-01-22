//
//  ContentView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/18/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(\.modelContext) var modelContext
	@EnvironmentObject private var appState: AppState
	@State private var selectedSidebarItem: SidebarItem?
	
	var body: some View {
		NavigationSplitView {
			SidebarView(selection: $selectedSidebarItem)
		} detail: {
			if case .project(let project) = selectedSidebarItem {
				ProjectView(
					project: project,
					modelContext: modelContext,
					appState: appState
				)
			} else {
				switch selectedSidebarItem {
				case .inbox:
					InboxView()
				case .today:
					TodayView()
				case .scheduled:
					ScheduledView()
				case .allIssues:
					AllIssuesView()
				case .none:
					ContentUnavailableView(
						"No Selection",
						systemImage: "sidebar.left",
						description: Text("Select an item from the sidebar")
					)
				default:
					EmptyView()
				}
			}
		}
		.onChange(of: selectedSidebarItem) { oldValue, newValue in
			if case .project(let project) = newValue {
				appState.currentProject = project
			} else {
				appState.currentProject = nil
			}
		}
	}
}

#Preview {
	ContentView()
		.modelContainer(for: Project.self, inMemory: true)
		.environmentObject(AppState())
}
