//
//  BacklogViewModel.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData
import Observation

@Observable
class BacklogViewModel: ObservableObject {
	private let project: Project
	private var modelContext: ModelContext?
	
	var sprints: [Sprint] = []
	var searchText: String = ""
	var selectedTodo: Todo?
	var showCreateSprint = false
	var showCreateTodo = false
	
	init(project: Project) {
		self.project = project
		updateSprints()
	}
	
	func setModelContext(_ context: ModelContext) {
		self.modelContext = context
		updateSprints()
	}
	
	func updateSprints() {
		sprints = project.sprints.filter { $0.status != .completed && $0.status != .canceled }
	}
	
	var filteredTodos: [Todo] {
		if searchText.isEmpty {
			return project.backlogTodos
		} else {
			return project.backlogTodos.filter { todo in
				todo.title.localizedCaseInsensitiveContains(searchText)
			}
		}
	}
}
