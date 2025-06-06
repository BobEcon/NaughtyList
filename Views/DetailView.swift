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
    @State private var smacks = 1
    
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
                .onChange(of: naughty) {
                    smacks = naughty ? 1 : 0
                }
            Stepper("Smacks Deserved:", value: $smacks, in: 0...5)
                .font(.title2).bold()
                .onChange(of: smacks) {
                    naughty = smacks > 0
                }
            HStack {
                Spacer()
                Text("\(smacks)")
                    .font(.largeTitle).bold()
                Spacer()
            }
            Text("Notes:")
                .font(.title2).bold()
            TextField("notes", text: $firstName)
                .textFieldStyle(.roundedBorder)
                .font(.title2)
            Spacer()
            HStack {
                Image("boy")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                Image("girl")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
            }
            
        }
        .padding()
        Spacer()
    }
}

#Preview {
    DetailView()
}
