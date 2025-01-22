//
//  AppState.swift
//  Milestone
//
//  Created by Kevin Perez on 1/22/25.
//

import SwiftUI
import SwiftData

class AppState: ObservableObject {
    @Published var showInspector = true
    @Published var selectedTodo: Todo? {
        didSet {
            // Automatically set the current project when a todo is selected
            if let todo = selectedTodo {
                currentProject = todo.project
                showInspector = true
            }
        }
    }
    @Published var currentProject: Project?
    
    // Helper function to select a todo and show it in the inspector
    func selectTodo(_ todo: Todo) {
        selectedTodo = todo
        showInspector = true
    }
    
    // Helper function to clear selection
    func clearSelection() {
        selectedTodo = nil
        if currentProject == nil {
            showInspector = false
        }
    }
}
