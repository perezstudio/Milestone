//
//  Enums.swift
//  Milestone
//
//  Created by Kevin Perez on 1/24/25.
//

import SwiftUI
import SwiftData

enum Status: String, Codable, CaseIterable {
	case backlog, todo, inProgress, inReview, done, canceled
	
	var iconName: String {
		switch self {
		case .backlog: return "tray"
		case .todo: return "checklist"
		case .inProgress: return "arrow.right"
		case .inReview: return "eye"
		case .done: return "checkmark.circle"
		case .canceled: return "xmark.circle"
		}
	}
	
	var color: Color {
		switch self {
		case .backlog: return .gray
		case .todo: return .blue
		case .inProgress: return .green
		case .inReview: return .purple
		case .done: return .green
		case .canceled: return .red
		}
	}
}

enum Priority: String, Codable, CaseIterable {
	case urgent, high, medium, low, none
	
	var iconName: String {
		switch self {
		case .urgent: return "exclamationmark.3"
		case .high: return "exclamationmark.2"
		case .medium: return "exclamationmark"
		case .low: return "arrow.down"
		case .none: return "minus"
		}
	}
	
	var color: Color {
		switch self {
		case .urgent: return .red
		case .high: return .orange
		case .medium: return .yellow
		case .low: return .blue
		case .none: return .gray
		}
	}
}

enum SidebarItem: Hashable {
	case inbox
	case today
	case scheduled
	case allIssues
	case project(Project) // Include a project if applicable
}

enum ProjectColor: String, Codable, CaseIterable, Identifiable {
	var id: String { self.rawValue }
	
	case red, orange, yellow, green, blue, indigo, purple
	
	var color: Color {
		switch self {
		case .red:
			return .red
		case .orange:
			return .orange
		case .yellow:
			return .yellow
		case .green:
			return .green
		case .blue:
			return .blue
		case .indigo:
			return .indigo
		case .purple:
			return .purple // SwiftUI doesn't have violet, using purple instead
		}
	}
	
	// Add a lighter version for backgrounds
	var backgroundColor: Color {
		color.opacity(0.2)
	}
	
	// Add a display name
	var displayName: String {
		rawValue.capitalized
	}
	
	// Add a system icon name that matches the color theme
	var iconName: String {
		switch self {
		case .red:
			return "Red"
		case .orange:
			return "Orange"
		case .yellow:
			return "Yellow"
		case .green:
			return "Green"
		case .blue:
			return "Blue"
		case .indigo:
			return "Indigo"
		case .purple:
			return "Purple"
		}
	}
}

enum selectedViewType: String, Codable, CaseIterable {
	case none, projectList, inboxView, TodayView, ScheduledView, issueList
}

enum ProjectSelectedView: String, Codable, CaseIterable, Identifiable {
	case board, backlog, roadmap, sprint, setting
	
	var id: String { self.rawValue }
	
	var iconName: String {
		switch self {
		case .board:
			return "square.grid.3x2"
		case .backlog:
			return "list.bullet"
		case .roadmap:
			return "map"
		case .sprint:
			return "calendar"
		case .setting:
			return "gear"
		}
	}
}
