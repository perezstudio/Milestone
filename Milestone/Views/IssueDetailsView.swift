//
//  IssueDetailsView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/25/25.
//

import SwiftUI

struct IssueDetailsView: View {
	
	@Bindable var issue: Issue
	
    var body: some View {
		Text(issue.title)
    }
}

#Preview {
	
	let testProject = Project(name: "Test Project", icon: "stack.square", color: ProjectColor.blue, priority: Priority.high, notes: "Test Note", favorite: false)
	let testIssue = Issue(title: "Text", notes: "Test Note", project: testProject)
	
	IssueDetailsView(issue: testIssue)
}
