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
	@Bindable var sprint: Sprint
	let status: Status
	let todosByStatus: [Status: [Todo]]
	
	var body: some View {
		VStack(alignment: .leading) {
			// Column Header
			HStack {
				Image(systemName: status.iconName)
					.foregroundStyle(status.color)
				Text(status.rawValue.capitalized)
				Text("\(todosByStatus[status]?.count ?? 0)")
					.foregroundStyle(.secondary)
			}
			.font(.headline)
			.padding(.bottom, 8)
			
			// Droppable area
			VStack(spacing: 8) {
				ForEach(todosByStatus[status] ?? [], id: \.id) { todo in
					TodoCard(todo: todo)
						.draggable(TodoTransferable(id: todo.id))
				}
			}
			.frame(minHeight: 100)
			.dropDestination(for: TodoTransferable.self) { items, location in
				if let transferable = items.first,
				   let todo = sprint.todos.first(where: { $0.id == transferable.id }) {
					todo.status = status
					return true
				}
				return false
			}
		}
		.frame(width: 300)
		.padding()
		.background(Color.secondary.opacity(0.1))
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
}

