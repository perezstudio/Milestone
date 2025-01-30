//
//  CreateSprintView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/28/25.
//

import SwiftUI

struct CreateSprintView: View {
	
	@State var sprintName: String = ""
	@State var startDate: Date = Date()
	@State var endDate: Date = Date()
	@State var status: SprintStatus = .planning
	
    var body: some View {
		NavigationStack {
			Form {
				TextField("Sprint Name", text: $sprintName)
				DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
					.datePickerStyle(.field)
				DatePicker("End Date", selection: $endDate, displayedComponents: .date)
					.datePickerStyle(.field)
				Picker("Status", selection: $status) {
					ForEach(SprintStatus.allCases, id: \.self) { status in
						Label(status.rawValue.capitalized, systemImage: status.iconName).tag(status)
					}
				}
			}
			.padding()
			.navigationTitle("Create Sprint")
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button {
						
					} label: {
						Label("Create Sprint", systemImage: "calendar.badge.plus")
					}
				}
				ToolbarItem(placement: .destructiveAction) {
					Button {
						
					} label: {
						Label("Cancel", systemImage: "xmark.circle.fill")
							.labelStyle(.titleOnly)
					}
				}
			}
		}
    }
}

#Preview {
    CreateSprintView()
}
