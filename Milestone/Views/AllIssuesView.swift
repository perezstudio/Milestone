//
//  AllIssuesView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

struct AllIssuesView: View {
	@Environment(\.modelContext) private var modelContext
	@EnvironmentObject private var appState: AppState
	@Query(sort: \Todo.id) private var todos: [Todo]
	@State private var searchText = ""
	@State private var showFilters = false
	@State private var statusFilter: Status?
	@State private var priorityFilter: Priority?
	@State private var projectFilter: Project?
	
	var filteredTodos: [Todo] {
		todos.filter { todo in
			var matches = true
			
			if !searchText.isEmpty {
				matches = matches && todo.title.localizedCaseInsensitiveContains(searchText)
			}
			
			if let statusFilter = statusFilter {
				matches = matches && todo.status == statusFilter
			}
			
			if let priorityFilter = priorityFilter {
				matches = matches && todo.priority == priorityFilter
			}
			
			if let projectFilter = projectFilter {
				matches = matches && todo.project.id == projectFilter.id
			}
			
			return matches
		}
	}
	
	var body: some View {
		List(filteredTodos) { todo in
			TodoRow(todo: todo)
				.contentShape(Rectangle())
				.onTapGesture {
					appState.selectTodo(todo)
				}
				.listRowBackground(appState.selectedTodo?.id == todo.id ?
					Color.accentColor.opacity(0.1) : nil)
		}
		.navigationTitle("All Issues")
		.searchable(text: $searchText, prompt: "Search todos")
		.toolbar {
			// ... toolbar items ...
		}
		.onDisappear {
			appState.clearSelection()
		}
	}
}
