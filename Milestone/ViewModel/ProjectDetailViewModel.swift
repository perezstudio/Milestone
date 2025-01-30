//
//  ProjectDetailViewModel.swift
//  Milestone
//
//  Created by Kevin Perez on 1/29/25.
//

import SwiftUI
import SwiftData

@Observable
class ProjectDetailViewModel {
	var project: Project
	private var modelContext: ModelContext
	
	init(project: Project, modelContext: ModelContext) {
		self.project = project
		self.modelContext = modelContext
	}
	
	// Fetch backlog issues
	var backlogIssues: [Issue] {
		let descriptor = FetchDescriptor<Issue>(
			sortBy: [SortDescriptor(\Issue.title)]
		)
		
		// Fetch all issues and filter
		if let issues = try? modelContext.fetch(descriptor) {
			return issues.filter {
				$0.project?.id == project.id &&
				$0.sprint == nil
			}
		}
		return []
	}
	
	// Fetch active sprint issues
	var activeSprintIssues: [Issue] {
		guard let currentSprint = project.currentSprint else { return [] }
		
		let descriptor = FetchDescriptor<Issue>(
			sortBy: [SortDescriptor(\Issue.title)]
		)
		
		// Fetch all issues and filter
		if let issues = try? modelContext.fetch(descriptor) {
			return issues.filter {
				$0.project?.id == project.id &&
				$0.sprint?.id == currentSprint.id
			}
		}
		return []
	}
	
	// Get issues for a specific status in the current sprint
	func issuesForStatus(_ status: Status?) -> [Issue] {
		activeSprintIssues.filter { $0.status == status }
	}
	
	// MARK: - Issue Management
	func createIssue(title: String, description: String, status: Status, priority: Priority, dueDate: Date?) {
		let newIssue = Issue(
			title: title,
			notes: description,
			status: status,
			priority: priority,
			dueDate: dueDate,
			sprint: nil,
			project: project
		)
		modelContext.insert(newIssue)
		try? modelContext.save()
	}
	
	func moveIssueToSprint(_ issue: Issue, sprint: Sprint?) {
		issue.sprint = sprint
		try? modelContext.save()
	}
	
	func updateIssueStatus(_ issue: Issue, status: Status) {
		issue.status = status
		try? modelContext.save()
	}
}
