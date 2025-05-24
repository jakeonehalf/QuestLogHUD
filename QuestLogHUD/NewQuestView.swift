//
//  NewQuestView.swift
//  QuestLogHUD
//
//  Created by Jake Thiem on 5/24/25.
//


import SwiftUI

struct NewQuestView: View {
    @Binding var newQuestTitle: String
    var onAdd: (String) -> Void

    var body: some View {
        HStack {
            TextField("New quest...", text: $newQuestTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    submit()
                }

            Button("Add") {
                submit()
            }
            .disabled(newQuestTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }

    private func submit() {
        let trimmed = newQuestTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        onAdd(trimmed)
        newQuestTitle = ""
    }
}