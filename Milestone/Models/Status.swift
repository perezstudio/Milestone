//
//  Status.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

enum Status: String, Codable, CaseIterable {
	case backlog, todo, inProgress, inReview, done, canceled
}

enum Priority: String, Codable, CaseIterable {
    case urgent, high, medium, low, none
}

enum SidebarItem: Hashable {
	case inbox
	case today
	case scheduled
	case allIssues
	case project(Project) // Include a project if applicable
}

enum ProjectColor: String, Codable, CaseIterable {
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
