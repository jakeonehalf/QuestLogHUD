//
//  QuestListView.swift
//  QuestLogHUD
//
//  Created by Jake Thiem on 5/23/25.
//


import SwiftUI

struct QuestListView: View {
    @Binding var quests: [Quest]
    var saveAction: () -> Void
    var deleteAction: (Int) -> Void

    @AppStorage("showActiveQuests") private var showActive = true
    @AppStorage("showCompletedQuests") private var showCompleted = false
    @AppStorage("showAbandonedQuests") private var showAbandoned = false

    var body: some View {
        List {
            let activeQuests = sortedQuests(.active)
            questSection(
                title: "Active (\(activeQuests.count))",
                icon: "circle.fill",
                color: .green,
                isExpanded: $showActive,
                filtered: activeQuests
            )

            let completedQuests = sortedQuests(.completed)
            questSection(
                title: "Completed (\(completedQuests.count))",
                icon: "checkmark.circle.fill",
                color: .blue,
                isExpanded: $showCompleted,
                filtered: completedQuests
            )

            let abandonedQuests = sortedQuests(.abandoned)
            questSection(
                title: "Abandoned (\(abandonedQuests.count))",
                icon: "xmark.circle.fill",
                color: .red,
                isExpanded: $showAbandoned,
                filtered: abandonedQuests
            )
        }
    }

    func sortedQuests(_ status: Quest.Status) -> [(offset: Int, element: Quest)] {
        return Array(quests.enumerated())
            .filter { $0.element.status == status }
            .sorted { $0.element.updatedAt > $1.element.updatedAt }
    }

    func questSection(
        title: String,
        icon: String,
        color: Color,
        isExpanded: Binding<Bool>,
        filtered: [(offset: Int, element: Quest)]
    ) -> some View {
        Section {
            DisclosureGroup(
                isExpanded: isExpanded,
                content: {
                    if filtered.isEmpty {
                        Text("No quests.")
                            .foregroundColor(.secondary)
                            .italic()
                            .padding(.leading)
                    } else {
                        ForEach(filtered, id: \.element.id) { index, _ in
                            QuestView(
                                quest: $quests[index],
                                onSave: saveAction,
                                onDelete: {
                                    deleteAction(index)
                                }
                            )
                        }
                    }
                },
                label: {
                    Label(title, systemImage: icon)
                        .foregroundColor(color)
                        .font(.headline)
                }
            )
        }
    }
}
