//
//  SprintListSidebar.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct SprintListSidebar: View {
    let project: Project
    @State private var expandedSprints: Set<UUID> = []
    
    var body: some View {
        List {
            ForEach(project.sprints.filter { $0.status != .completed }) { sprint in
                SprintSection(sprint: sprint, isExpanded: expandedSprints.contains(sprint.id))
                    .onTapGesture {
                        toggleSprintExpansion(sprint.id)
                    }
            }
        }
        .frame(width: 300)
    }
    
    private func toggleSprintExpansion(_ sprintId: UUID) {
        if expandedSprints.contains(sprintId) {
            expandedSprints.remove(sprintId)
        } else {
            expandedSprints.insert(sprintId)
        }
    }
}
