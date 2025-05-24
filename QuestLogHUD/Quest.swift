//
//  Quest.swift
//  QuestLogHUD
//
//  Created by Jake Thiem on 5/22/25.
//

import Foundation

struct Quest: Identifiable, Codable {
    enum Status: String, Codable, CaseIterable {
        case active, completed, abandoned
    }

    let id: UUID
    var title: String
    var status: Status
    var tags: [String]
    var notes: String?
    var createdAt: Date
    var updatedAt: Date
}

struct QuestLog: Codable {
    var quests: [Quest]
}
