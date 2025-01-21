//
//  SprintCard.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct SprintCard: View {
	@Bindable var sprint: Sprint
	let viewModel: ProjectViewModel
	@State private var isDropTargeted = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			// Sprint Header
			HStack {
				VStack(alignment: .leading) {
					Text(sprint.title)
						.font(.headline)
					Text("\(sprint.startDate.formatted(date: .abbreviated, time: .omitted)) - \(sprint.endDate.formatted(date: .abbreviated, time: .omitted))")
						.font(.caption)
						.foregroundStyle(.secondary)
				}
				Spacer()
				Text("\(sprint.todos.count)")
					.foregroundStyle(.secondary)
			}
			
			// Sprint Todos
			if !sprint.todos.isEmpty {
				VStack(spacing: 8) {
					ForEach(sprint.todos) { todo in
						TodoRow(todo: todo)
							.padding(6)
							.cornerRadius(6)
					}
				}
			}
			
			// Drop Zone
			Rectangle()
				.fill(Color.clear)
				.frame(height: 60)
				.overlay(
					RoundedRectangle(cornerRadius: 6)
						.stroke(isDropTargeted ? Color.accentColor : Color.secondary,
							   style: StrokeStyle(lineWidth: 2, dash: [5]))
						.overlay(
							Text(isDropTargeted ? "Release to add" : "Drop items here")
								.foregroundStyle(.secondary)
						)
				)
				.dropDestination(for: TodoTransferable.self) { items, location in
					if let transferable = items.first,
					   let todo = viewModel.project.todos.first(where: { $0.id == transferable.id }) {
						viewModel.moveTodoToSprint(todo, sprint: sprint)
						return true
					}
					return false
				} isTargeted: { isTargeted in
					isDropTargeted = isTargeted
				}
		}
		.padding()
		.cornerRadius(8)
		.shadow(radius: 1)
	}
}
