//
//  Child.swift
//  NaughtyList
//
//  Created by Robert Beachill on 04/06/2025.
//

import Foundation
import SwiftData

@MainActor
@Model
class Child {
    var firstName = ""
    var lastName = ""
    var naughty = true
    var smacks = 1
    var notes = ""
    
    init(firstName: String = "", lastName: String = "", naughty: Bool = true, smacks: Int = 1, notes: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.naughty = naughty
        self.smacks = smacks
        self.notes = notes
    }
}

extension Child {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Child.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(
            Child(
                firstName: "Bad",
                lastName: "Bunny",
                naughty: true,
                smacks: 1,
                notes: "Conejo Malo"
            )
        )
        container.mainContext.insert(
            Child(
                firstName: "Draco",
                lastName: "Malfoy",
                naughty: false,
                smacks: 5,
                notes: "Watch out for wands"
            )
        )
        container.mainContext.insert(
            Child(
                firstName: "Lisa",
                lastName: "Simpson",
                naughty: false,
                smacks: 0,
                notes: "Always tries her best"
            )
        )
        container.mainContext.insert(
            Child(
                firstName: "Veruca",
                lastName: "Salt",
                naughty: true,
                smacks: 3,
                notes: "Keep away from candy"
            )
        )
        container.mainContext.insert(
            Child(
                firstName: "Fred",
                lastName: "Rogers",
                naughty: false,
                smacks: 0,
                notes: "Everyone's favourite neighbour"
            )
        )
        return container
    }
}
