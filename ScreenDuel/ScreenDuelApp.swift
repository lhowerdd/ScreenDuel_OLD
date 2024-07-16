//
//  ScreenDuelApp.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/7/24.
//

import SwiftUI
import FamilyControls

@main
struct ScreenDuelApp: App {
    let persistenceController = PersistenceController.shared
    //this SHOULD request authorization
    @StateObject var familyControlsAuthorizer: FamilyControlsAuthorizer = FamilyControlsAuthorizer()
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
            //ContentView()
            //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


class FamilyControlsAuthorizer: ObservableObject {
    init() {
        Task {
            await authorize()
        }
    }
    
    final func authorize() async {
        let center = AuthorizationCenter.shared
        do {
            try await center.requestAuthorization(for: FamilyControlsMember.individual)
        } 
        catch {
            print("authorization failed")
        }
    }
}


