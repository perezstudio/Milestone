//
//  ContentView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/18/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(\.modelContext) var modelContext
	@State private var selectedProject: Project?
	@State private var selectedTodo: Todo?
	
	var body: some View {
		NavigationSplitView {
			SidebarView()
		} detail: {
			ProjectView(project: selectedProject ?? Project(name: "", icon: "", color: ProjectColor.blue, notes: "", favorite: false), modelContext: modelContext)
		}
	}
}

#Preview {
	ContentView()
}
