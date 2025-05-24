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

            NewQuestView(newQuestTitle: $newQuestTitle) { title in
                let newQuest = Quest(
                    id: UUID(),
                    title: title,
                    status: .active,
                    tags: [],
                    notes: nil,
                    createdAt: Date(),
                    updatedAt: Date()
                )

                questStore.quests.append(newQuest)
                questStore.save()
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
