//
//  Issue.swift
//  Milestone
//
//  Created by Kevin Perez on 1/24/25.
//

import SwiftUI
import SwiftData

@Model
final class Issue {
	var id: UUID
	var title: String
	var notes: String
	var status: Status
	var priority: Priority
	var dueDate: Date?
	
	@Relationship(deleteRule: .nullify) var sprint: Sprint?
	@Relationship(inverse: \Project.issues) var project: Project?
	
	var isOverdue: Bool {
		guard let dueDate = dueDate else { return false }
		return dueDate < Date() && status != .done
	}
	
	var isDueToday: Bool {
		guard let dueDate = dueDate else { return false }
		return Calendar.current.isDateInToday(dueDate)
	}
	
	init(
		id: UUID = UUID(),
		title: String,
		notes: String,
		status: Status = .backlog,
		priority: Priority = .none,
		dueDate: Date? = nil,
		sprint: Sprint? = nil,
		project: Project? = nil
	) {
		self.id = id
		self.title = title
		self.notes = notes
		self.status = status
		self.priority = priority
		self.dueDate = dueDate
		self.sprint = sprint
		self.project = project
	}
}

extension Date {
	var isToday: Bool {
		Calendar.current.isDateInToday(self)
	}
}
