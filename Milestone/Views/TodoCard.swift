//
//  TodoCard.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct TodoCard: View {
    @Bindable var todo: Todo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(todo.title)
                    .font(.headline)
                Spacer()
                Image(systemName: todo.priority.iconName)
                    .foregroundStyle(todo.priority.color)
            }
            
            if !todo.notes.isEmpty {
                Text(todo.notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            if let dueDate = todo.dueDate {
                HStack {
                    Image(systemName: "calendar")
                    Text(dueDate.formatted(date: .abbreviated, time: .omitted))
                }
                .font(.caption)
                .foregroundStyle(todo.isOverdue ? .red : .secondary)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .shadow(radius: 1)
    }
}
