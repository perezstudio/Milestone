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
	@State private var selectedSidebarItem: SidebarItem?
	@State private var selectedTodo: Todo?
	
	var body: some View {
		NavigationSplitView {
			SidebarView()
		} content: {
//			TodoListView(
//				todos: viewModel.filteredTodos,
//				selectedTodo: $selectedTodo
//			)
		} detail: {
			if let todo = selectedTodo {
				Text("TodoView")
			} else {
				Text("Select a todo")
			}
		}
	}
}

#Preview {
	ContentView()
}
