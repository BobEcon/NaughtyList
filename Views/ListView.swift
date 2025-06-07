//
//  ContentView.swift
//  NaughtyList
//
//  Created by Robert Beachill on 04/06/2025.
//

import SwiftUI
import SwiftData
import AVFAudio

struct ListView: View {
    @Query var childs: [Child]
    @State private var sheetIsPresented: Bool = false
    @Environment(\.modelContext) var modelContext
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        NavigationStack {
            List(childs) { child in
                NavigationLink {
                    DetailView(child: child)
                } label: {
                    HStack {
                        Image("\(child.naughty ? "naughty" : "nice")")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        Text("\(child.firstName) \(child.lastName)")
                    }
                }
                .swipeActions {
                    Button("Delete", role: .destructive) {
                        modelContext.delete(child)
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: Save after .delete on ToDoListView did not work")
                            return
                        }
                    }
                }
            }
            .font(.title2)
            .listStyle(.plain)
            .navigationTitle(Text("Schmuzli's List"))
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(child: Child())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            playSound(soundName: "riff")
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
    ListView()
        .modelContainer(Child.preview)
}
