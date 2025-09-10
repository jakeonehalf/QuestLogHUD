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
                        window.level = .popUpMenu
                        window.setFrameAutosaveName("QuestLogHUDWindow")
                        window.collectionBehavior = [
                            .canJoinAllSpaces,
                            .stationary,
                            .ignoresCycle,
                            .fullScreenAuxiliary
                        ]
                        window.hidesOnDeactivate = false
                        window.isReleasedWhenClosed = false
                        window.setFrame(window.frame, display: true, animate: false)
                        window.makeKeyAndOrderFront(nil)
                        window.orderFrontRegardless()
                        NSApp.activate(ignoringOtherApps: true)
                    }
                })
        }
    }
}
