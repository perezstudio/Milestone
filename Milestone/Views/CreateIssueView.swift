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
    @Environment(\.modelContext) private var modelContext
    @Binding var todo: Todo?
    
    let project: Project?
    
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
        todo != nil
    }
    
    private var currentProject: Project? {
        project ?? selectedProject
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
                
                if project == nil {
                    Section("Project") {
                        Picker("Project", selection: $selectedProject) {
                            Text("None")
                                .tag(Optional<Project>.none)
                            
                            ForEach(projects) { project in
                                Label {
                                    Text(project.name)
                                } icon: {
                                    Image(systemName: project.icon)
                                        .foregroundStyle(project.color.color)
                                }
                                .tag(Optional(project))
                            }
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
                    .disabled(title.isEmpty || (project == nil && selectedProject == nil))
                }
            }
        }
        .onAppear {
            if let todo = todo {
                title = todo.title
                notes = todo.notes
                status = todo.status
                priority = todo.priority
                if let todoDueDate = todo.dueDate {
                    hasDueDate = true
                    dueDate = todoDueDate
                }
                selectedRelease = todo.release
                selectedProject = todo.project
            } else if let project = project {
                selectedProject = project
            }
        }
    }
    
    private func createTodo() {
        guard let project = currentProject else { return }
        
        let newTodo = Todo(
            title: title,
            notes: notes,
            status: status,
            priority: priority,
            dueDate: hasDueDate ? dueDate : nil,
            release: selectedRelease,
            project: project
        )
        modelContext.insert(newTodo)
    }
    
    private func updateTodo() {
        guard let existingTodo = todo else { return }
        existingTodo.title = title
        existingTodo.notes = notes
        existingTodo.status = status
        existingTodo.priority = priority
        existingTodo.dueDate = hasDueDate ? dueDate : nil
        existingTodo.release = selectedRelease
        if project == nil {
            existingTodo.project = selectedProject ?? existingTodo.project
        }
    }
}
