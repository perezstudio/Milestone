//
//  DroppableArea.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct DroppableArea: View {
    @Bindable var sprint: Sprint
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
            .frame(height: 60)
            .overlay {
                Text("Drop items here")
                    .foregroundStyle(.secondary)
            }
            .dropDestination(for: TodoTransferable.self) { items, location in
                if let transferable = items.first,
                   let todo = sprint.project.todos.first(where: { $0.id == transferable.id }) {
                    todo.status = .todo
                    sprint.todos.append(todo)
                    return true
                }
                return false
            }
    }
}
