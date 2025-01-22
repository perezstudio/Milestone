//
//  InspectorView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//

import SwiftUI
import SwiftData

struct InspectorView<Content: View>: View {
    let content: Content
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        HSplitView {
            Color.clear
                .opacity(0)
            
            Group {
                if isPresented {
                    content
                        .frame(minWidth: 300, maxWidth: 400)
                }
            }
        }
    }
}
