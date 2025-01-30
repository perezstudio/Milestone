//
//  CreateIssueForm.swift
//  Milestone
//
//  Created by Kevin Perez on 1/26/25.
//

import SwiftUI
import SwiftData

struct CreateIssueForm: View {
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \Project.id) var projects: [Project]
    @State private var issueTitle: String = ""
    @State private var issueDescription: String = ""
	@State private var dueDatePopover: Bool = false
	@State private var dueDate: Date? = nil
	@State private var priorityPopover: Bool = false
	@State private var issuePriority: Priority = .none
	@State private var projectPopover: Bool = false
	@State private var issueProject: Project? = nil
	@State private var statusPopover: Bool = false
	@State private var issueStatus: Status = .backlog

    var body: some View {
        VStack(spacing: 16) {
            TextField("Title", text: $issueTitle)
				.font(.title3)
				.textFieldStyle(.plain)
            TextField("Description", text: $issueDescription)
				.textFieldStyle(.plain)
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					// Due Date Selector
					Button {
						self.dueDatePopover.toggle()
					} label: {
						if (dueDate == nil) {
							Label("Due Date", systemImage: "calendar")
						} else {
							Label("\(DateFormatter.localizedString(from: dueDate!, dateStyle: .medium, timeStyle: .none))", systemImage: "calendar")
						}
					}
					.keyboardShortcut("d", modifiers: [.control])
					.popover(isPresented: $dueDatePopover, arrowEdge: .top) {
						DatePicker(
							"Due Date",
							selection: Binding(
								get: { dueDate ?? Date() },
								set: { dueDate = $0 }
							),
							displayedComponents: [.date]
						)
						.datePickerStyle(.graphical)
						.padding()
					}
					
					// Priority Selector
					Button {
						self.priorityPopover.toggle()
					} label: {
						if issuePriority.rawValue == "none" {
							Label("Priority", systemImage: "list.number")
						} else {
							Label(issuePriority.rawValue.capitalized, systemImage: issuePriority.iconName)
						}
					}
					.keyboardShortcut("i", modifiers: [.control])
					.popover(
						isPresented: $priorityPopover, arrowEdge: .top
					) {
						VStack {
							ForEach(Priority.allCases, id: \.self) { priority in
								Button {
									issuePriority = priority
								} label: {
									Label(priority.rawValue.capitalized, systemImage: priority.iconName)
								}
								.buttonStyle(.plain)
							}
						}
						.padding()
					}
					
					// Project Selector
					Button {
						self.projectPopover.toggle()
					} label: {
						if issueProject == nil {
							Label("Project", systemImage: "square.stack")
						} else {
							if let project = issueProject {
								Label(project.name, systemImage: project.icon)
							}
						}
					}
					.keyboardShortcut("p", modifiers: [.control])
					.popover(isPresented: $projectPopover, arrowEdge: .top) {
						VStack {
							Button {
								issueProject = nil
							} label: {
								Label("No Project", systemImage: "square.stack.fill")
							}
							.buttonStyle(.plain)
							ForEach(projects) { project in
								Button {
									issueProject = project
								} label: {
									Label(project.name, systemImage: project.icon)
								}
								.buttonStyle(.plain)
							}
						}
						.padding()
					}
					
					// Status Selector
					Button {
						self.statusPopover.toggle()
					} label: {
						Label(issueStatus.rawValue.capitalized, systemImage: issueStatus.iconName)
					}
					.keyboardShortcut("s", modifiers: [.control])
					.popover(isPresented: $statusPopover, arrowEdge: .top) {
						VStack {
							ForEach(Status.allCases, id: \.self) { status in
								Button {
									issueStatus = status
								} label: {
									Label(status.rawValue.capitalized, systemImage: status.iconName)
								}
								.buttonStyle(.plain)
							}
						}
						.padding()
					}
				}
			}
        }
        .padding()
		.navigationTitle("Create New Issue")
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				Button("Save") {
					createIssue()
					dismiss()
				}
				.buttonStyle(.borderedProminent)
			}
			ToolbarItem(placement: .destructiveAction) {
				Button("Cancel") {
					// Close the window (optional)
					dismiss()
				}
				.buttonStyle(.bordered)
			}
		}
    }
	
	func createIssue() {
		// Basic validation
		guard !issueTitle.isEmpty else { return }
		guard let project = issueProject else { return } // Validate project exists
		
		let newIssue = Issue(
			title: issueTitle,
			notes: issueDescription,
			status: issueStatus,
			priority: issuePriority,
			dueDate: dueDate,
			sprint: nil,
			project: project // Now we can safely pass the unwrapped project
		)
		
		modelContext.insert(newIssue)
	}
}
