//
//  AllIssuesView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

struct AllIssuesView: View {
	
	@Query(sort: \Todo.id) var issues: [Todo]
    var body: some View {
        List(issues) { issue in
			Label {
				Text(issue.title)
			} icon: {
				Image(systemName: issue.status.iconName)
			}
		}
    }
}

#Preview {
    AllIssuesView()
}
