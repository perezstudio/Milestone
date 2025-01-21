//
//  ProjectViewModel.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//


import SwiftUI
import SwiftData
import Observation

@Observable
class ProjectViewModel {
    private let modelContext: ModelContext
    private(set) var project: Project
    
    // MARK: - State Properties
    var selectedView: ProjectSelectedView = .currentSprint
    var searchText: String = ""
    var selectedTodo: Todo?
    var showCreateTodo = false
    var showCreateSprint = false
    var showCreateRelease = false
    
    // MARK: - Computed Properties
    var sprints: [Sprint] {
        project.sprints.filter { $0.status != .completed && $0.status != .canceled }
    }
    
    var currentSprint: Sprint? {
        project.currentSprint
    }
    
    var releases: [Release] {
        project.releases
    }
    
    var activeRelease: Release? {
        project.activeRelease
    }
    
    var filteredTodos: [Todo] {
        if searchText.isEmpty {
            return project.backlogTodos
        } else {
            return project.backlogTodos.filter { todo in
                todo.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var todosByStatus: [Status: [Todo]] {
        Dictionary(grouping: currentSprint?.todos ?? []) { $0.status }
    }
    
    // MARK: - Initialization
    init(project: Project, modelContext: ModelContext) {
        self.project = project
        self.modelContext = modelContext
    }
    
    // MARK: - Todo Management
    func createTodo(title: String, notes: String, status: Status, priority: Priority, dueDate: Date?, release: Release?) {
        let newTodo = Todo(
            title: title,
            notes: notes,
            status: status,
            priority: priority,
            dueDate: dueDate,
            release: release,
            project: project
        )
        modelContext.insert(newTodo)
        project.todos.append(newTodo)
    }
    
    func updateTodo(_ todo: Todo, title: String, notes: String, status: Status, priority: Priority, dueDate: Date?, release: Release?) {
        todo.title = title
        todo.notes = notes
        todo.status = status
        todo.priority = priority
        todo.dueDate = dueDate
        todo.release = release
    }
    
    func deleteTodo(_ todo: Todo) {
        if let index = project.todos.firstIndex(where: { $0.id == todo.id }) {
            project.todos.remove(at: index)
        }
        modelContext.delete(todo)
    }
    
    func moveTodoToSprint(_ todo: Todo, sprint: Sprint) {
        todo.sprint = sprint
        todo.status = .todo
        if !sprint.todos.contains(where: { $0.id == todo.id }) {
            sprint.todos.append(todo)
        }
    }
    
    // MARK: - Sprint Management
    func createSprint(title: String, startDate: Date, endDate: Date) {
        let newSprint = Sprint(
            title: title,
            startDate: startDate,
            endDate: endDate,
            project: project
        )
        modelContext.insert(newSprint)
        project.sprints.append(newSprint)
    }
    
    func updateSprintStatus(_ sprint: Sprint, status: SprintStatus) {
        sprint.status = status
        if status == .inProgress {
            // Deactivate other sprints when setting one as active
            project.sprints.forEach { otherSprint in
                if otherSprint.id != sprint.id {
                    otherSprint.isActive = false
                }
            }
            sprint.isActive = true
        } else if status == .completed || status == .canceled {
            sprint.isActive = false
        }
    }
    
    // MARK: - Release Management
    func createRelease(title: String, dueDate: Date?, isActive: Bool) {
        let newRelease = Release(
            id: UUID(),
            title: title,
            dueDate: dueDate,
            isActive: isActive,
            todos: []
        )
        modelContext.insert(newRelease)
        project.releases.append(newRelease)
        
        if isActive {
            // Deactivate other releases when setting one as active
            project.releases.forEach { otherRelease in
                if otherRelease.id != newRelease.id {
                    otherRelease.isActive = false
                }
            }
        }
    }
    
    func updateRelease(_ release: Release, title: String, dueDate: Date?, isActive: Bool) {
        release.title = title
        release.dueDate = dueDate
        
        if isActive && !release.isActive {
            // Deactivate other releases when setting one as active
            project.releases.forEach { otherRelease in
                if otherRelease.id != release.id {
                    otherRelease.isActive = false
                }
            }
        }
        release.isActive = isActive
    }
}
