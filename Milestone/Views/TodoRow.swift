//
//  TodoRow.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct TodoRow: View {
	@Bindable var todo: Todo
	
	var body: some View {
		HStack {
			Image(systemName: todo.priority.iconName)
				.foregroundStyle(todo.priority.color)
			
			VStack(alignment: .leading) {
				Text(todo.title)
					.font(.headline)
				
				if !todo.notes.isEmpty {
					Text(todo.notes)
						.font(.caption)
						.foregroundStyle(.secondary)
						.lineLimit(1)
				}
			}
			
			Spacer()
			
			if let dueDate = todo.dueDate {
				Text(dueDate.formatted(date: .abbreviated, time: .omitted))
					.font(.caption)
					.foregroundStyle(todo.isOverdue ? .red : .secondary)
			}
		}
		.padding(.vertical, 4)
	}
}
