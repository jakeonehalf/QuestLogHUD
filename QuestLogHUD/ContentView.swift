//
//  ContentView 2.swift
//  QuestLogHUD
//
//  Created by Jake Thiem on 5/23/25.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var questStore = QuestStore()
    @State private var newQuestTitle = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Quest Log")
                .font(.largeTitle)
                .padding(.bottom)

            HStack {
                TextField("New quest...", text: $newQuestTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minWidth: 300)

                Button("Add") {
                    let newQuest = Quest(
                        id: UUID(),
                        title: newQuestTitle,
                        status: .active,
                        tags: [],
                        notes: nil,
                        createdAt: Date(),
                        updatedAt: Date()
                    )

                    questStore.quests.append(newQuest)
                    questStore.save()
                    newQuestTitle = ""
                }
                .disabled(newQuestTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.bottom)

            QuestListView(
                quests: $questStore.quests,
                saveAction: {
                    questStore.save()
                },
                deleteAction: { index in
                    questStore.quests.remove(at: index)
                    questStore.save()
                }
            )
        }
        .frame(minWidth: 400, minHeight: 300)
        .padding()
    }
}