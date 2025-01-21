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
	
	init() {
		do {
			container = try ModelContainer(
				for: Project.self, Todo.self, Release.self
			)
		} catch {
			fatalError("Failed to initialize ModelContainer: \(error)")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
		.modelContainer(container)
	}
}
