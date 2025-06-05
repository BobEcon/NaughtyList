//
//  ContentView.swift
//  NaughtyList
//
//  Created by Robert Beachill on 04/06/2025.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query var childs: [Child]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List(childs) { child in
                NavigationLink {
                    //TODO:
                } label: {
                    HStack {
                        Image("\(child.naughty ? "naughty" : "nice")")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        Text("\(child.firstName) \(child.lastName)")
                    }
                }

            }
            .font(.title2)
            .listStyle(.plain)
            .navigationTitle(Text("Schmuzli's List"))
        }
//        .border(Color.gray)
//        .padding()
    }
}

#Preview {
    ListView()
        .modelContainer(Child.preview)
}
