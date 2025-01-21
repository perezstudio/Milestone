//
//  SprintSection.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct SprintSection: View {
    @Bindable var sprint: Sprint
    let isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            // Sprint Header
            HStack {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                Text(sprint.title)
                Spacer()
                Text("\(sprint.todos.count)")
                    .foregroundStyle(.secondary)
            }
            .contentShape(Rectangle())
            
            // Sprint Content
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(sprint.todos) { todo in
                        TodoRow(todo: todo)
                    }
                    
                    // Droppable Area
                    DroppableArea(sprint: sprint)
                }
                .padding(.leading)
            }
        }
    }
}
