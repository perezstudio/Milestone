//
//  StatusColumn.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct StatusColumn: View {
	let status: Status
	let todos: [Todo]
	let viewModel: ProjectViewModel
	@State private var isDropTargeted = false
	
	var body: some View {
		VStack(alignment: .leading) {
			// Column Header
			HStack {
				Image(systemName: status.iconName)
					.foregroundStyle(status.color)
				Text(status.rawValue.capitalized)
				Text("\(todos.count)")
					.foregroundStyle(.secondary)
			}
			.font(.headline)
			.padding(.bottom, 8)
			
			// Droppable area
			VStack(spacing: 8) {
				ForEach(todos) { todo in
					TodoCard(todo: todo)
						.draggable(TodoTransferable(id: todo.id))
				}
			}
			.frame(minHeight: 100)
			.dropDestination(for: TodoTransferable.self) { items, location in
				if let transferable = items.first,
				   let currentSprint = viewModel.currentSprint,
				   let todo = currentSprint.todos.first(where: { $0.id == transferable.id }) {
					todo.status = status
					return true
				}
				return false
			} isTargeted: { isTargeted in
				isDropTargeted = isTargeted
			}
		}
		.frame(width: 300)
		.padding()
		.background(Color.secondary.opacity(0.1))
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
}
