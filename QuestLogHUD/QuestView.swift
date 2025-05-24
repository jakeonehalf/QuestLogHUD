//
//  QuestView.swift
//  QuestLogHUD
//
//  Created by Jake Thiem on 5/23/25.
//

import SwiftUI

struct QuestView: View {
    @Binding var quest: Quest
    var onSave: () -> Void
    var onDelete: () -> Void

    @State private var isEditing = false

    var body: some View {
        HStack {
            if isEditing {
                TextField("Quest title", text: $quest.title, onCommit: {
                    quest.updatedAt = Date()
                    isEditing = false
                    onSave()
                })
                .textFieldStyle(.roundedBorder)
            } else {
                Text(quest.title)
                    .strikethrough(quest.status != .active, color: .gray)
                    .foregroundColor(quest.status == .active ? .primary: .gray)
                    .onTapGesture(count: 2) {
                        isEditing = true
                    }
            }

            Spacer()

            // ✅ Complete button
            Button {
                quest.status = .completed
                quest.updatedAt = Date()
                onSave()
            } label: {
                Image(systemName: quest.status == .completed ? "checkmark.circle.fill" : "checkmark.circle")
                    .foregroundColor(.green)
                    .help("Mark Completed")
            }

            // ❌ Abandon button
            Button {
                quest.status = .abandoned
                quest.updatedAt = Date()
                onSave()
            } label: {
                Image(systemName: quest.status == .abandoned ? "xmark.circle.fill" : "xmark.circle")
                    .foregroundColor(.red)
                    .help("Abandon Quest")
            }

            // `...` menu
            Menu {
                if quest.status != .active {
                    Button("Reactivate") {
                        quest.status = .active
                        quest.updatedAt = Date()
                        onSave()
                    }
                }

                Divider()

                Button("Delete Quest", role: .destructive) {
                    onDelete()
                }
            } label: {
                Label("Menu", systemImage: "ellipsis.circle")
            }
            .menuStyle(.button)
            .frame(width: 28, height: 28) // Force compact size
            .contentShape(Rectangle())    // Prevent full row capture
            .menuIndicator(.hidden)
        }
        .padding(.vertical, 4)
    }
}
