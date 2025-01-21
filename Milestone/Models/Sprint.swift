//
//  Sprint.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

@Model
final class Sprint {
	var id: UUID
	var title: String
	var startDate: Date
	var endDate: Date
	var isActive: Bool
	var status: SprintStatus
	@Relationship(inverse: \Todo.sprint) var todos: [Todo]
	@Relationship(inverse: \Project.sprints) var project: Project
	
	var progressPercentage: Double {
		guard !todos.isEmpty else { return 0 }
		let completedTodos = todos.filter { $0.status == .done }
		return Double(completedTodos.count) / Double(todos.count) * 100
	}
	
	var isOverdue: Bool {
		endDate < Date() && status != .completed
	}
	
	var remainingDays: Int {
		Calendar.current.dateComponents([.day], from: Date(), to: endDate).day ?? 0
	}
	
	init(id: UUID = UUID(),
		 title: String,
		 startDate: Date,
		 endDate: Date,
		 isActive: Bool = false,
		 status: SprintStatus = .planning,
		 todos: [Todo] = [],
		 project: Project) {
		self.id = id
		self.title = title
		self.startDate = startDate
		self.endDate = endDate
		self.isActive = isActive
		self.status = status
		self.todos = todos
		self.project = project
	}
}

enum SprintStatus: String, Codable, CaseIterable {
	case planning
	case inProgress
	case completed
	case canceled
	
	var iconName: String {
		switch self {
		case .planning: return "calendar.badge.clock"
		case .inProgress: return "arrow.right.circle"
		case .completed: return "checkmark.circle"
		case .canceled: return "xmark.circle"
		}
	}
	
	var color: Color {
		switch self {
		case .planning: return .orange
		case .inProgress: return .blue
		case .completed: return .green
		case .canceled: return .red
		}
	}
}
