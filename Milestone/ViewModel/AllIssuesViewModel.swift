//
//  AllIssuesViewModel.swift
//  Milestone
//
//  Created by Kevin Perez on 1/22/25.
//

import SwiftUI
import SwiftData
import Observation

@Observable
class AllIssuesViewModel {
	private let modelContext: ModelContext
	
	// MARK: - State Properties
	var searchText: String = ""
	var selectedTodo: Todo?
	var statusFilter: Status?
	var priorityFilter: Priority?
	var projectFilter: Project?
	var showFilters = false
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	var filteredTodos: [Todo] {
		let descriptor = FetchDescriptor<Todo>(sortBy: [SortDescriptor(\.id)])
		
		guard let todos = try? modelContext.fetch(descriptor) else {
			return []
		}
		
		return todos.filter { todo in
			var matches = true
			
			// Apply text search
			if !searchText.isEmpty {
				matches = matches && todo.title.localizedCaseInsensitiveContains(searchText)
			}
			
			// Apply status filter
			if let statusFilter = statusFilter {
				matches = matches && todo.status == statusFilter
			}
			
			// Apply priority filter
			if let priorityFilter = priorityFilter {
				matches = matches && todo.priority == priorityFilter
			}
			
			// Apply project filter
			if let projectFilter = projectFilter {
				matches = matches && todo.project.id == projectFilter.id
			}
			
			return matches
		}
	}
	
	var availableProjects: [Project] {
		let descriptor = FetchDescriptor<Project>(sortBy: [SortDescriptor(\.name)])
		return (try? modelContext.fetch(descriptor)) ?? []
	}
	
	func clearFilters() {
		statusFilter = nil
		priorityFilter = nil
		projectFilter = nil
	}
}
