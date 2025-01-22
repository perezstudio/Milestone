//
//  MainToolbarItems.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct MainToolbarItems: ToolbarContent {
	@Bindable var viewModel: ProjectViewModel
	@Binding var showInspector: Bool
	
	var body: some ToolbarContent {
		ToolbarItem(placement: .principal) {
			Picker("View", selection: $viewModel.selectedView) {
				ForEach(ProjectSelectedView.allCases, id: \.self) { view in
					Label {
						Text(view.viewName)
					} icon: {
						Image(systemName: view.viewIcon)
					}
					.tag(view)
				}
			}
			.pickerStyle(.segmented)
		}
	}
}
