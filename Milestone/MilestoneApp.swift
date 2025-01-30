//
//  MilestoneApp.swift
//  Milestone
//
//  Created by Kevin Perez on 1/18/25.
//

import SwiftUI
import SwiftData

@main
struct ProjectManagementApp: App {
	let container: ModelContainer
	@State private var appState = AppState()

	init() {
		do {
			container = try ModelContainer(
				for: Project.self, Issue.self, Sprint.self
			)
		} catch {
			fatalError("Failed to initialize ModelContainer: \(error)")
		}
	}

	var body: some Scene {
		WindowGroup {
			ContentView(appState: appState)
				.environment(appState) // Use .environment to share AppState
				.inspector(isPresented: $appState.showInspector) {
					if let issue = appState.selectedIssue {
						IssueDetailsView(issue: issue)
							.inspectorColumnWidth(min: 250, ideal: 300, max: 400)
							.toolbar {
								Spacer()
								Button {
									appState.toggleInspector()
								} label: {
									Label("Toggle Inspector", systemImage: "sidebar.right")
								}
							}
					} else {
						ContentUnavailableView(
							"No Selection",
							systemImage: "sidebar.right",
							description: Text("Select a todo to see its details")
						)
						.inspectorColumnWidth(min: 250, ideal: 300, max: 400)
						.toolbar {
							Spacer()
							Button {
								appState.toggleInspector()
							} label: {
								Label("Toggle Inspector", systemImage: "sidebar.right")
							}
						}
					}
				}
				.modelContainer(container)
		}

	}
}
