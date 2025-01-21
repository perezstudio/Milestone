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

struct TodoTransferable: Transferable {
	let id: UUID
	
	static var transferRepresentation: some TransferRepresentation {
		ProxyRepresentation(exporting: { todoTransferable in
			todoTransferable.id.uuidString
		})
	}
}

extension UTType {
	static let todo = UTType(exportedAs: "com.milestone.todo",
							conformingTo: .data)
}
