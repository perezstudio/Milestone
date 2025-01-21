//
//  TodoTransferable.swift
//  Milestone
//
//  Created by Kevin Perez on 1/21/25.
//


// Create a new file called TodoTransferable.swift
import Foundation
import CoreTransferable
import UniformTypeIdentifiers

struct TodoTransferable: Transferable, Codable {
	let id: UUID
	
	static var transferRepresentation: some TransferRepresentation {
		CodableRepresentation(for: TodoTransferable.self, contentType: .todo)
	}
}

extension UTType {
	static let todo = UTType(exportedAs: "com.your.app.todo",
							conformingTo: .data)
}
