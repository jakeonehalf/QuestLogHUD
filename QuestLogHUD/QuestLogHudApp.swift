//
//  QuestLogHud.swift
//  QuestLogHUD
//
//  Created by Jake Thiem on 5/22/25.
//


import SwiftUI

@main
struct QuestLogHUDApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(WindowAccessor { window in
                    if let window = window {
                        window.title = "Quest Log"
                        window.level = .floating
                        window.setFrameAutosaveName("QuestLogHUDWindow")
                        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
                        window.isReleasedWhenClosed = false
                        window.makeKeyAndOrderFront(nil)
                        NSApp.activate(ignoringOtherApps: true)
                    }
                })
        }
    }
}
