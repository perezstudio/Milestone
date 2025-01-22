//
//  InspectorToolbarItems.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct InspectorToolbarItems: ToolbarContent {
    @Binding var showInspector: Bool
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .automatic) { 
            Spacer() 
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button {
                showInspector.toggle()
            } label: {
                Label("Inspector", systemImage: "sidebar.right")
            }
            .keyboardShortcut("0", modifiers: [.command, .option])
        }
    }
}
