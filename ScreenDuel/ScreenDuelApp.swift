//
//  ScreenDuelApp.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/7/24.
//

import SwiftUI

@main
struct ScreenDuelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
