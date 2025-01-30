//
//  SidebarViewModel.swift
//  Milestone
//
//  Created by Kevin Perez on 1/24/25.
//

import SwiftUI
import SwiftData

@Observable
class SidebarViewModel {
	
	var modelContext: ModelContext
	var favoriteProjects: [Project] = []
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
		fetchFavoriteProjects()
	}
	
	func setModelContext(_ modelContext: ModelContext) {
		self.modelContext = modelContext
		fetchFavoriteProjects()
	}
	
	func fetchFavoriteProjects() {
		let descriptor = FetchDescriptor<Project>(
			predicate: #Predicate<Project> { project in
				project.favorite == true
			},
			sortBy: [
				SortDescriptor(\.id)
			]
		)
		
		do {
			favoriteProjects = try modelContext.fetch(descriptor)
		} catch {
			print("Error fetching favorite projects: \(error)")
			favoriteProjects = []
		}
	}

}
