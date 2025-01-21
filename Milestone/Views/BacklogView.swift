import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct BacklogView: View {
	@Bindable var viewModel: ProjectViewModel
	
	var body: some View {
		HStack(spacing: 0) {
			// Backlog Items
			VStack {
				List {
					ForEach(viewModel.filteredTodos) { todo in
						TodoRow(todo: todo)
							.listRowBackground(Color.clear)
							.draggable(TodoTransferable(id: todo.id)) {
								TodoRow(todo: todo)
									.frame(width: 300)
									.contentShape(Rectangle())
							}
							.onTapGesture {
								viewModel.selectedTodo = todo
							}
					}
				}
				.searchable(text: $viewModel.searchText, prompt: "Search backlog items")
			}
			.frame(maxWidth: .infinity)
			
			// Sprint List
			ScrollView {
				VStack(spacing: 16) {
					ForEach(viewModel.sprints) { sprint in
						SprintCard(sprint: sprint, viewModel: viewModel)
					}
				}
				.padding()
			}
			.frame(width: 350)
		}
		.navigationTitle("Backlog")
		.toolbar {
			ToolbarItemGroup(placement: .primaryAction) {
				Button {
					viewModel.showCreateTodo = true
				} label: {
					Label("New Todo", systemImage: "plus")
				}
				
				Button {
					viewModel.showCreateSprint = true
				} label: {
					Label("New Sprint", systemImage: "calendar.badge.plus")
				}
			}
		}
		.sheet(isPresented: $viewModel.showCreateSprint) {
			CreateSprintView(viewModel: viewModel)
		}
		.sheet(isPresented: $viewModel.showCreateTodo) {
			CreateIssueView(viewModel: viewModel, editingTodo: nil)
		}
		.sheet(item: $viewModel.selectedTodo) { todo in
			CreateIssueView(viewModel: viewModel, editingTodo: todo)
		}
	}
}
