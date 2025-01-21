//
//  Todo.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

@Model
final class Todo {
	var id: UUID
	var title: String
	var notes: String
	var status: Status
	var priority: Priority
	var dueDate: Date?
	@Relationship var release: Release?
	@Relationship(inverse: \Project.todos) var project: Project
	
	var isOverdue: Bool {
		guard let dueDate = dueDate else { return false }
		return dueDate < Date() && status != .done
	}
	
	var isDueToday: Bool {
		guard let dueDate = dueDate else { return false }
		return Calendar.current.isDateInToday(dueDate)
	}
	
	init(id: UUID = UUID(), title: String, notes: String, status: Status = .backlog,
		 priority: Priority = .none, dueDate: Date? = nil,
		 release: Release? = nil, project: Project) {
		self.id = id
		self.title = title
		self.notes = notes
		self.status = status
		self.priority = priority
		self.dueDate = dueDate
		self.release = release
		self.project = project
	}
}

extension Date {
	var isToday: Bool {
		Calendar.current.isDateInToday(self)
	}
}
