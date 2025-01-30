//
//  ProjectCardView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/26/25.
//

import SwiftUI

struct ProjectCardView: View {
	
	@Bindable var project: Project
	
    var body: some View {
		HStack {
			Image(systemName: project.icon)
				.frame(width: 32, height: 32)
				.foregroundStyle(project.color.color)
				.background(project.color.color.opacity(0.4))
				.cornerRadius(8)
			VStack(alignment: .leading, spacing: 1) {
				Text(project.name)
					.fontWeight(.bold)
				Text("Completed: \(project.completedTodosPercentage, specifier: "%.2f")%")
					.font(.caption)
					.foregroundStyle(.secondary)
			}
			Spacer()
			HStack(alignment: .center, spacing: 16) {
				HStack {
					Image(systemName: project.priority.iconName)
					Text(project.priority.rawValue.capitalized)
				}
				Image(systemName: project.favorite ? "star.fill" : "star")
					.frame(width: 32, height: 32)
					.foregroundStyle(project.favorite ? Color.yellow : .gray)
					.onTapGesture {
						project.favorite.toggle()
					}
			}
		}
		.padding(.vertical, 4)
    }
}

#Preview {
	
	let testProject = Project(name: "Test Project", icon: "square.stack", color: ProjectColor.green, priority: Priority.none, notes: "", favorite: false)
	
	ProjectCardView(project: testProject)
}
