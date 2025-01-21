//
//  BacklogView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers  // Add this import

struct BacklogView: View {
	let project: Project
	@Environment(\.modelContext) private var modelContext
	@State private var searchText = ""
	@State private var showCreateSprint = false
	@State private var selectedTodo: Todo?
	@State private var showCreateTodo = false
	@State private var draggingTodo: Todo?
	
	var filteredTodos: [Todo] {
		if searchText.isEmpty {
			return project.backlogTodos
		} else {
			return project.backlogTodos.filter { todo in
				todo.title.localizedCaseInsensitiveContains(searchText)
			}
		}
	}
	
	var body: some View {
		HStack(spacing: 0) {
			// Backlog Items
			VStack {
				List {
					ForEach(filteredTodos) { todo in
						TodoRow(todo: todo)
							.listRowBackground(Color.clear)
							.draggable(TodoTransferable(id: todo.id)) {
								TodoRow(todo: todo)
									.frame(width: 300)
									.contentShape(Rectangle())
							}
							.onTapGesture {
								selectedTodo = todo
							}
					}
				}
				.searchable(text: $searchText, prompt: "Search backlog items")
			}
			.frame(maxWidth: .infinity)
			
			// Sprint List
			ScrollView {
				VStack(spacing: 16) {
					ForEach(project.sprints.filter { $0.status != .completed }) { sprint in
						SprintCard(sprint: sprint, project: project)
					}
				}
				.padding()
			}
			.frame(width: 350)
		}
		.navigationTitle("Backlog")
		.toolbar {
			ToolbarItemGroup(placement: .primaryAction) {
				Button {
					showCreateTodo = true
				} label: {
					Label("New Todo", systemImage: "plus")
				}
				
				Button {
					showCreateSprint = true
				} label: {
					Label("New Sprint", systemImage: "calendar.badge.plus")
				}
			}
		}
		.sheet(isPresented: $showCreateSprint) {
			CreateSprintView(project: project)
		}
		.sheet(isPresented: $showCreateTodo) {
			CreateIssueView(todo: $selectedTodo, project: project)
		}
		.sheet(item: $selectedTodo) { todo in
			CreateIssueView(todo: $selectedTodo, project: project)
		}
	}
}

