//
//  CreateProjectView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/26/25.
//

import SwiftUI

struct CreateProjectView: View {
	
	@Environment(\.modelContext) var modelContext
	@Environment(\.dismiss) var dismiss
	@State var projectName: String = ""
	@State var projectIcon: String = "square.stack"
	@State var projectColor: ProjectColor = .blue
	@State var projectPriority: Priority = .none
	@State var projectNotes: String = ""
	@State var projectFavorite: Bool = false
	
	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Project Name", text: $projectName)
					Toggle("Favorite", isOn: $projectFavorite)
				}
				Section {
					HStack {
						Text("Color")
						LazyVGrid(columns: columns, spacing: 16) {
							ForEach(ProjectColor.allCases) { color in
								Button {
									projectColor = color
								} label: {
									Circle()
										.foregroundStyle(color.color)
										.frame(width: 40, height: 40)
										.accessibilityLabel(Text(color.rawValue.capitalized))
								}
							}
						}
						.frame(maxWidth: .infinity)
					}
					Picker("Priority", selection: $projectPriority) {
						ForEach(Priority.allCases, id: \.self) { priority in
							Label {
								Text(priority.rawValue.capitalized)
							} icon: {
								Image(systemName: priority.iconName)
							}
							.tag(priority)
						}
					}
					.pickerStyle(.segmented)
				}
				Section {
					TextField("Notes", text: $projectNotes, axis: .vertical)
				}
			}
			.formStyle(.grouped)
			.navigationTitle("Create Project")
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button {
						let newProject = Project(name: projectName, icon: projectIcon, color: projectColor, priority: projectPriority, notes: projectNotes, favorite: projectFavorite)
						modelContext.insert(newProject)
						dismiss()
					} label: {
						Label {
							Text("Create Project")
						} icon: {
							Image(systemName: "plus")
						}
					}
				}
				ToolbarItem(placement: .destructiveAction) {
					Button {
						dismiss()
					} label: {
						Text("Cancel")
					}
				}
			}
		}
    }
}

#Preview {
    CreateProjectView()
}
