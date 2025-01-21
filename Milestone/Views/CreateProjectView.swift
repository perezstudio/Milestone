//
//  CreateProjectView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI

struct CreateProjectView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@Binding var project: Project?
	
	@State private var name: String = ""
	@State private var icon: String = "folder"
	@State private var color: ProjectColor = .blue
	@State private var notes: String = ""
	@State private var favorite: Bool = false
	@State private var showIconPicker = false
	
	private var isEditing: Bool {
		project != nil
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Project Name", text: $name)
					Toggle("Favorite", isOn: $favorite)
				}
				
				Section {
					Button {
						showIconPicker = true
					} label: {
						HStack {
							Text("Icon")
							Spacer()
							Image(systemName: icon)
								.foregroundStyle(color.color)
						}
					}
					
					Picker("Color", selection: $color) {
						ForEach(ProjectColor.allCases, id: \.self) { projectColor in
							Label {
								Text(projectColor.rawValue.capitalized)
							} icon: {
								Circle()
									.fill(projectColor.color)
									.frame(width: 20, height: 20)
							}
							.tag(projectColor)
						}
					}
				}
				
				Section("Notes") {
					TextEditor(text: $notes)
						.frame(minHeight: 100)
				}
			}
			.padding()
			.navigationTitle(isEditing ? "Edit Project" : "New Project")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						dismiss()
					}
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button(isEditing ? "Save" : "Create") {
						if isEditing {
							updateProject()
						} else {
							createProject()
						}
						dismiss()
					}
					.disabled(name.isEmpty)
				}
			}
			.sheet(isPresented: $showIconPicker) {
				IconPickerView(selectedIcon: $icon)
			}
		}
		.onAppear {
			if let project = project {
				name = project.name
				icon = project.icon
				color = project.color
				notes = project.notes
				favorite = project.favorite
			}
		}
	}
	
	private func createProject() {
		let newProject = Project(
			name: name,
			icon: icon,
			color: color,
			notes: notes,
			favorite: favorite
		)
		modelContext.insert(newProject)
	}
	
	private func updateProject() {
		guard let existingProject = project else { return }
		existingProject.name = name
		existingProject.icon = icon
		existingProject.color = color
		existingProject.notes = notes
		existingProject.favorite = favorite
	}
}
