//
//  DetailView.swift
//  NaughtyList
//
//  Created by Robert Beachill on 06/06/2025.
//

import SwiftUI

struct DetailView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var naughty = true
    
    var body: some View {
        VStack(alignment:.leading) {
            Group {
                Text("First Name:").bold()
                TextField("first", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                Text("Last Name:").bold()
                TextField("first", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
            }
            .font(.title2)
            Toggle("Naughty?", isOn: $naughty)
                .font(.title2).bold()
        }
        .padding()
        Spacer()
    }
}

#Preview {
    DetailView()
}
