//
//  Project.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

@Model
final class Project {
	var id: UUID
	var name: String
	var icon: String
	var color: ProjectColor
	var notes: String
	var favorite: Bool
	@Relationship var todos: [Todo]
	@Relationship var releases: [Release]
	
	var activeTodos: [Todo] { todos.filter { $0.status != .done && $0.status != .canceled } }
	var backlogTodos: [Todo] { todos.filter { $0.status == .backlog } }
	var activeRelease: Release? { releases.first { $0.isActive } }
	
	init(id: UUID = UUID(), name: String, icon: String, color: ProjectColor, notes: String, favorite: Bool, todos: [Todo] = [], releases: [Release] = []) {
		self.id = id
		self.name = name
		self.icon = icon
		self.color = color
		self.notes = notes
		self.favorite = favorite
		self.todos = todos
		self.releases = releases
	}
}
