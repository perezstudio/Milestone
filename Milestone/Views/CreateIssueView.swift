//
//  CreateIssueView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

struct CreateIssueView: View {
	@Environment(\.dismiss) private var dismiss
	let viewModel: ProjectViewModel
	let editingTodo: Todo?
	
	@State private var title: String = ""
	@State private var notes: String = ""
	@State private var status: Status = .backlog
	@State private var priority: Priority = .none
	@State private var hasDueDate: Bool = false
	@State private var dueDate: Date = Date()
	@State private var selectedRelease: Release?
	@State private var selectedProject: Project?
	
	@Query(sort: \Project.id) private var projects: [Project]
	
	private var isEditing: Bool {
		editingTodo != nil
	}
	
	private var currentProject: Project? {
		viewModel.project
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Title", text: $title)
					
					Picker("Status", selection: $status) {
						ForEach(Status.allCases, id: \.self) { status in
							Label {
								Text(status.rawValue.capitalized)
							} icon: {
								Image(systemName: status.iconName)
									.foregroundStyle(status.color)
							}
							.tag(status)
						}
					}
					
					Picker("Priority", selection: $priority) {
						ForEach(Priority.allCases, id: \.self) { priority in
							Label {
								Text(priority.rawValue.capitalized)
							} icon: {
								Image(systemName: priority.iconName)
									.foregroundStyle(priority.color)
							}
							.tag(priority)
						}
					}
				}
				
				Section {
					Toggle("Has Due Date", isOn: $hasDueDate)
					
					if hasDueDate {
						DatePicker(
							"Due Date",
							selection: $dueDate,
							displayedComponents: [.date]
						)
					}
				}
				
				if let currentProject = currentProject, !currentProject.releases.isEmpty {
					Section("Release") {
						Picker("Release", selection: $selectedRelease) {
							Text("None")
								.tag(Optional<Release>.none)
							
							ForEach(currentProject.releases) { release in
								Text(release.title)
									.tag(Optional(release))
							}
						}
					}
				}
				
				Section("Notes") {
					TextEditor(text: $notes)
						.frame(minHeight: 100)
				}
			}
			.navigationTitle(isEditing ? "Edit Issue" : "New Issue")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						dismiss()
					}
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button(isEditing ? "Save" : "Create") {
						if isEditing {
							updateTodo()
						} else {
							createTodo()
						}
						dismiss()
					}
					.disabled(title.isEmpty)
				}
			}
		}
		.onAppear {
			if let todo = editingTodo {
				title = todo.title
				notes = todo.notes
				status = todo.status
				priority = todo.priority
				if let todoDueDate = todo.dueDate {
					hasDueDate = true
					dueDate = todoDueDate
				}
				selectedRelease = todo.release
			}
		}
	}
	
	private func createTodo() {
		viewModel.createTodo(
			title: title,
			notes: notes,
			status: status,
			priority: priority,
			dueDate: hasDueDate ? dueDate : nil,
			release: selectedRelease
		)
	}
	
	private func updateTodo() {
		guard let existingTodo = editingTodo else { return }
		viewModel.updateTodo(
			existingTodo,
			title: title,
			notes: notes,
			status: status,
			priority: priority,
			dueDate: hasDueDate ? dueDate : nil,
			release: selectedRelease
		)
	}
}
