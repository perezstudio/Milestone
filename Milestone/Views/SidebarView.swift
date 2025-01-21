//
//  SidebarView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI
import SwiftData

struct SidebarView: View {
	
	@Query(sort: \Project.name) private var projects: [Project]
	@State private var project: Project? = nil
	@State var createProjectSheet = false
	@State var createIssueSheet = false
	
	var body: some View {
		List {
			Section {
				NavigationLink(destination: InboxView()) {
					Label {
						Text("Inbox")
					} icon: {
						Image(systemName: "tray.fill")
					}
				}
				Label {
					Text("Today")
				} icon: {
					Image(systemName: "calendar")
				}
				Label {
					Text("Scheduled")
				} icon: {
					Image(systemName: "clock")
				}
				Label {
					Text("All Issues")
				} icon: {
					Image(systemName: "list.bullet")
				}
			}
			Section(header: Text("Views")) {
				NavigationLink(destination: ProjectListView()) {
					Label {
						Text("Projects")
					} icon: {
						Image(systemName: "square.stack.fill")
					}
				}
			}
			Section("Favorite Projects") {
				ForEach(projects) { project in
					NavigationLink(destination: ProjectView(project: project)) {
						Label(project.name, systemImage: "folder")
					}
				}
			}
		}
		.navigationTitle("Milestone")
		.toolbar {
			ToolbarItemGroup(placement: .primaryAction) {
				Spacer()
				Menu {
					Section {
						Button {
							createProjectSheet.toggle()
						} label: {
							Label {
								Text("Add Project")
							} icon: {
								Image(systemName: "rectangle.stack.badge.plus")
							}
						}
						Button {
							
						} label: {
							Label {
								Text("Add Issue")
							} icon: {
								Image(systemName: "plus.app")
							}
						}
					}
				} label: {
					Button {
						
					} label: {
						Label {
							Text("Add")
						} icon: {
							Image(systemName: "plus")
						}
					}
				}
			}
		}
		.sheet(isPresented: $createProjectSheet) {
			CreateProjectView(project: $project)
		}
	}
}

#Preview {
	SidebarView()
}
