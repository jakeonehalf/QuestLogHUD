//
//  QuestStore.swift
//  QuestLogHUD
//
//  Created by Jake Thiem on 5/22/25.
//

import Foundation

class QuestStore: ObservableObject {
    @Published var quests: [Quest] = []
    let fileURL = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent(".quest-log.json")

    init() {
        func load() {
            print("🔍 Looking for quest log at: \(fileURL.path)")
            
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                print("❌ File not found.")
                return
            }

            guard let data = try? Data(contentsOf: fileURL) else {
                print("❌ Could not read data from file.")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([String: [Quest]].self, from: data)
                self.quests = decoded["quests"] ?? []
                print("✅ Loaded \(self.quests.count) quests.")
            } catch {
                print("🚨 JSON decode error: \(error)")
            }
        }
        
        load()
    }

    func load() {
        print("🔍 Looking for quest log at: \(fileURL.path)")

        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("❌ File not found.")
            return
        }

        guard let data = try? Data(contentsOf: fileURL) else {
            print("❌ Could not read data from file.")
            return
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode([String: [Quest]].self, from: data)
            self.quests = decoded["quests"] ?? []
            print("✅ Loaded \(self.quests.count) quests.")
        } catch {
            print("🚨 JSON decode error: \(error)")
        }
    }

    func save() {
        let dict = ["quests": quests]
        do {
            let data = try JSONEncoder().encode(dict)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save quests: \(error)")
        }
    }
}
