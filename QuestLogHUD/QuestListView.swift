//
//  QuestListView.swift
//  QuestLogHUD
//
//  Created by Jake Thiem on 5/23/25.
//


import SwiftUI

func questStatusOrder(lhs: Quest, rhs: Quest) -> Bool {
    let order: [Quest.Status: Int] = [
        .active: 0,
        .completed: 1,
        .abandoned: 2
    ]
    return order[lhs.status, default: 3] < order[rhs.status, default: 3]
}

struct QuestListView: View {
    @Binding var quests: [Quest]
    var saveAction: () -> Void
    var deleteAction: (Int) -> Void

    var body: some View {
        List {
            ForEach(Array(quests.enumerated())
                .sorted { questStatusOrder(lhs: $0.element, rhs: $1.element) },
                id: \.element.id
            ) { index, _ in
                QuestView(
                    quest: $quests[index],
                    onSave: saveAction,
                    onDelete: {
                        deleteAction(index)
                    }
                )
            }
        }
    }
}
