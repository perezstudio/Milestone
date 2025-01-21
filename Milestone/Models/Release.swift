//
//  Release.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

@Model
class Release {
	var id: UUID = UUID()
    var title: String
    var dueDate: Date?
    var isActive: Bool
    @Relationship var todos: [Todo]
	
	init(id: UUID, title: String, dueDate: Date? = nil, isActive: Bool, todos: [Todo]) {
		self.id = id
		self.title = title
		self.dueDate = dueDate
		self.isActive = isActive
		self.todos = todos
	}
}
