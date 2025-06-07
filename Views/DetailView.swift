//
//  DetailView.swift
//  NaughtyList
//
//  Created by Robert Beachill on 06/06/2025.
//

import SwiftUI
import SwiftData
import AVFAudio

struct DetailView: View {
    @State var child: Child
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var naughty = true
    @State private var smacks = 1
    @State private var notes = ""
    @State private var audioPlayer: AVAudioPlayer!
    @State private var boyIsFullSize = true
    @State private var girlIsFullSize = true
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment:.leading) {
            Group {
                Text("First Name:").bold()
                TextField("first", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                Text("Last Name:").bold()
                TextField("last", text: $lastName)
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
            TextField("notes", text: $notes)
                .textFieldStyle(.roundedBorder)
                .font(.title2)
            Spacer()
            HStack {
                Image("boy")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .scaleEffect(boyIsFullSize ? 1.0 : 0.9)
                    .onTapGesture {
                        playSound(soundName: "smack")
                        boyIsFullSize = false // will immediately shrink using . scaleEffect to 90% of size
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                            boyIsFullSize = true // will go from 90% to 100% size but using the .spring animation
                        }
                    }
                
                Image("girl")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .scaleEffect(girlIsFullSize ? 1.0 : 0.9)
                    .onTapGesture {
                        playSound(soundName: "smack")
                        girlIsFullSize = false // will immediately shrink using . scaleEffect to 90% of size
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                            girlIsFullSize = true // will go from 90% to 100% size but using the .spring animation
                        }
                    }
            }

        }
        .padding()
        Spacer()
            .onAppear {
                firstName =  child.firstName
                lastName =  child.lastName
                naughty =  child.naughty
                smacks  = child.smacks
                notes = child.notes
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        //Move data from local vars to toDo object
                        child.firstName =  firstName
                        child.lastName =  lastName
                        child.naughty =  naughty
                        child.smacks  = smacks
                        child.notes = notes
                        modelContext.insert(child)
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: Save in DetailView did not work")
                            return
                        }
                        dismiss()
                    }
                }
            }
    }
    
    func playSound(soundName: String) {
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else
        {
            print("😡 Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer =  try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print(" 😡 ERROR: \(error.localizedDescription) creating audioPlayer")
        }
    }
}



#Preview {
    NavigationStack {
        DetailView(child: Child())
            .modelContainer(for: Child.self, inMemory: true)
    }
}
