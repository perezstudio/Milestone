import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct BacklogView: View {
	let project: Project
	@Environment(\.modelContext) private var modelContext
	@StateObject private var viewModel: BacklogViewModel
	
	init(project: Project) {
		self.project = project
		// Initialize the view model without modelContext
		self._viewModel = StateObject(wrappedValue: BacklogViewModel(project: project))
	}
	
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
						SprintCard(sprint: sprint, project: project)
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
			CreateSprintView(project: project)
		}
		.sheet(isPresented: $viewModel.showCreateTodo) {
			CreateIssueView(todo: $viewModel.selectedTodo, project: project)
		}
		.sheet(item: $viewModel.selectedTodo) { todo in
			CreateIssueView(todo: $viewModel.selectedTodo, project: project)
		}
		.onAppear {
			// Set the modelContext when the view appears
			viewModel.setModelContext(modelContext)
		}
	}
}
