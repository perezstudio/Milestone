//
//  TodoDetailsView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct TodoDetailsView: View {
	@Environment(\.dismiss) private var dismissAction
	@EnvironmentObject private var appState: AppState
	let viewModel: ProjectViewModel
	@Bindable var todo: Todo
	
	private var isInInspector: Bool {
		appState.selectedTodo?.id == todo.id && appState.showInspector
	}
	
	private func handleDelete() {
		viewModel.deleteTodo(todo)
		if isInInspector {
			appState.selectedTodo = nil  // Clear selection
			appState.showInspector = false  // Close inspector
		} else {
			dismissAction()  // Dismiss sheet/modal
		}
	}
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Title", text: .init(
                        get: { todo.title },
                        set: { todo.title = $0 }
                    ))
                    .font(.title2)
                    .textFieldStyle(.plain)
                    
                    HStack {
                        Label {
                            Text(todo.project.name)
                        } icon: {
                            Image(systemName: todo.project.icon)
                                .foregroundStyle(todo.project.color.color)
                        }
                        .font(.caption)
                        
                        if let release = todo.release {
                            Text("•")
                                .foregroundStyle(.secondary)
                            Text(release.title)
                                .font(.caption)
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            
            Section {
                Picker("Status", selection: .init(
                    get: { todo.status },
                    set: { todo.status = $0 }
                )) {
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
                
                Picker("Priority", selection: .init(
                    get: { todo.priority },
                    set: { todo.priority = $0 }
                )) {
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
                
                DatePicker(
                    "Due Date",
                    selection: .init(
                        get: { todo.dueDate ?? Date() },
                        set: { todo.dueDate = $0 }
                    ),
                    displayedComponents: [.date]
                )
                
                if !viewModel.project.releases.isEmpty {
                    Picker("Release", selection: .init(
                        get: { todo.release },
                        set: { todo.release = $0 }
                    )) {
                        Text("None")
                            .tag(Optional<Release>.none)
                        
                        ForEach(viewModel.project.releases) { release in
                            Text(release.title)
                                .tag(Optional(release))
                        }
                    }
                }
            }
            
            Section("Notes") {
                TextEditor(text: .init(
                    get: { todo.notes },
                    set: { todo.notes = $0 }
                ))
                .frame(minHeight: 100)
            }
        }
		.navigationTitle("Details")
		.toolbar {
			ToolbarItemGroup(placement: .destructiveAction) {
				Button(role: .destructive) {
					handleDelete()
				} label: {
					Label("Delete", systemImage: "trash")
				}
			}
		}
    }
}
