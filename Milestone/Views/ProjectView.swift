//
//  ProjectView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI

struct ProjectView: View {
	
	@Bindable var project: Project
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(project.todos) { todo in
					Text(todo.title)
				}
			}
			.navigationTitle(project.name)
		}
    }
}

#Preview {
	var testProject = Project(name: "Test Project", icon: "square.stack", color: ProjectColor.blue, notes: "", favorite: false)
	ProjectView(project: testProject)
}
