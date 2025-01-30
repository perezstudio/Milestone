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
	var priority: Priority
	var notes: String
	var favorite: Bool
	@Relationship var issues: [Issue]
	@Relationship var sprints: [Sprint]
	
	var activeTodos: [Issue] { issues.filter { $0.status != .done && $0.status != .canceled } }
	var backlogTodos: [Issue] { issues.filter { $0.status == .backlog } }
	var currentSprint: Sprint? {
		sprints.first { $0.isActive }
	}
	
	var completedTodosPercentage: Double {
		guard !issues.isEmpty else { return 0.0 }
		let completedCount = issues.filter { $0.status == .done }.count
		return (Double(completedCount) / Double(issues.count)) * 100
	}
	
	init(id: UUID = UUID(), name: String, icon: String, color: ProjectColor, priority: Priority ,notes: String, favorite: Bool, issues: [Issue] = [], sprints: [Sprint] = []) {
		self.id = id
		self.name = name
		self.icon = icon
		self.color = color
		self.priority = priority
		self.notes = notes
		self.favorite = favorite
		self.issues = issues
		self.sprints = sprints
	}
}
