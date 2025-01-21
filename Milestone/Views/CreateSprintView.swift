//
//  CreateSprintView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct CreateSprintView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let project: Project
    
    @State private var title = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(60 * 60 * 24 * 14) // 2 weeks
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Sprint Title", text: $title)
                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
            }
            .navigationTitle("New Sprint")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        createSprint()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        .frame(minWidth: 400, minHeight: 250)
    }
    
    private func createSprint() {
        let newSprint = Sprint(
            title: title,
            startDate: startDate,
            endDate: endDate,
            project: project
        )
        modelContext.insert(newSprint)
    }
}
