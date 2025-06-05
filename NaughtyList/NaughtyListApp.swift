//
//  NaughtyListApp.swift
//  NaughtyList
//
//  Created by Robert Beachill on 04/06/2025.
//

import SwiftUI
import SwiftData

@main
struct NaughtyListApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .modelContainer(for: Child.self)
        }
    }
    
    // Will allow us to find where our simulator data is saved
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
