//
//  IssueCardView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/26/25.
//

import SwiftUI

struct IssueCardView: View {
	
	@Bindable var issue: Issue
	
    var body: some View {
		HStack {
			Text(issue.title)
			Spacer()
			HStack {
				HStack {
					Image(systemName: issue.priority.iconName)
					Text(issue.priority.rawValue.capitalized)
				}
			}
		}
    }
}

#Preview {
	
	let testProject = Project(name: "Test Project", icon: "square.stack.fill", color: ProjectColor.blue, priority: Priority.medium, notes: "", favorite: false)
	let testIssue = Issue(title: "Test Issue", notes: "", project: testProject)
	
	IssueCardView(issue: testIssue)
}
