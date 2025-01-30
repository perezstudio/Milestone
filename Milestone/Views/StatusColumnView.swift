//
//  StatusColumnView.swift
//  Milestone
//
//  Created by Kevin Perez on 1/26/25.
//

import SwiftUI
import SwiftData

struct StatusColumnView: View {
    let title: String
    let icon: String
    let color: Color
    let issues: [Issue]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.headline)
            }
            .padding(.bottom, 8)

            ForEach(issues) { issue in
                IssueCardView(issue: issue)
            }

            Spacer()
        }
        .padding()
        .frame(width: 200)
		.background(Color.gray.opacity(0.60))
        .cornerRadius(8)
    }
}
