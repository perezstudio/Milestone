//
//  IconPickerView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/20/25.
//

import SwiftUI

struct IconPickerView: View {
	@Environment(\.dismiss) private var dismiss
	@Binding var selectedIcon: String
	
	private let icons = [
		"folder", "folder.fill", "tray", "tray.fill", "doc", "doc.fill",
		"list.bullet", "checklist", "books.vertical", "book", "book.fill",
		"briefcase", "briefcase.fill", "hammer", "hammer.fill", "wrench",
		"wrench.fill", "gear", "gear.fill", "star", "star.fill"
	]
	
	var body: some View {
		NavigationStack {
			ScrollView {
				LazyVGrid(columns: [
					GridItem(.adaptive(minimum: 60))
				], spacing: 20) {
					ForEach(icons, id: \.self) { icon in
						Button {
							selectedIcon = icon
							dismiss()
						} label: {
							Image(systemName: icon)
								.font(.title)
								.frame(width: 60, height: 60)
								.background(
									RoundedRectangle(cornerRadius: 8)
										.fill(.secondary.opacity(0.2))
								)
						}
						.buttonStyle(.plain)
					}
				}
				.padding()
			}
			.navigationTitle("Choose Icon")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						dismiss()
					}
				}
			}
		}
	}
}

#Preview {
	
	@Previewable @State var selectedIcon: String = "plus.app"
	
	IconPickerView(selectedIcon: $selectedIcon)
}
