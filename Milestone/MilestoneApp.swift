//
//  MilestoneApp.swift
//  Milestone
//
//  Created by Kevin Perez on 1/18/25.
//

import SwiftUI
import SwiftData

class AppState: ObservableObject {
	@Published var showInspector = true
	@Published var selectedTodo: Todo?
	@Published var currentProject: Project?
}

@main
struct ProjectManagementApp: App {
	let container: ModelContainer
	@StateObject private var appState = AppState()
	
	init() {
		do {
			container = try ModelContainer(
				for: Project.self, Todo.self, Release.self, Sprint.self
			)
		} catch {
			fatalError("Failed to initialize ModelContainer: \(error)")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(appState)
				.inspector(isPresented: $appState.showInspector) {
					if let selectedTodo = appState.selectedTodo {
						if let project = appState.currentProject {
							TodoDetailsView(
								viewModel: ProjectViewModel(
									project: project,
									modelContext: container.mainContext
								),
								todo: selectedTodo
							)
							.inspectorColumnWidth(min: 250, ideal: 300, max: 400)
							.toolbar {
								Spacer()
								Button {
									appState.showInspector.toggle()
								} label: {
									Label("Toggle Inspector", systemImage: "sidebar.right")
								}
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
								appState.showInspector.toggle()
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
