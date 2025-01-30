//
//  AppState.swift
//  Milestone
//
//  Created by Kevin Perez on 1/26/25.
//


import SwiftUI
import Observation

@Observable
class AppState {
    var showInspector: Bool = false
    var selectedIssue: Issue? = nil
	var showCreateIssueWindow: Bool = false

    // Helper method to toggle the inspector
    func toggleInspector() {
        showInspector.toggle()
    }

    // Helper method to set the selected issue
    func selectIssue(_ issue: Issue?) {
        selectedIssue = issue
    }
}
