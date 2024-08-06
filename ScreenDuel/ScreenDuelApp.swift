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
            if familyControlsAuthorizer.authorized {
                HomePageView()
            }
            else{
                ReauthorizeView(familyControlsAuthorizer: familyControlsAuthorizer)
            }
            //ContentView()
            //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


struct ReauthorizeView: View {
    
    @ObservedObject var familyControlsAuthorizer: FamilyControlsAuthorizer
    
    var body: some View {
        if familyControlsAuthorizer.authorized {
            HomePageView()
        }
        else {
            Button(action:
                {Task {
                    await familyControlsAuthorizer.reauthorize()
                }
            })
            { Label("grant acesss", systemImage: "arrow.uturn.forward.circle.fill")}
        }
    }
}



class FamilyControlsAuthorizer: ObservableObject {
     @Published var authorized = true
    
    init() {
        Task {
            await authorize()
        }
    }
    
    final func authorize() async {
        let center = AuthorizationCenter.shared
        do {
            try await center.requestAuthorization(for: FamilyControlsMember.individual)
            authorized = true
        }
        catch {
            print("authorization failed")
            authorized = false
        }
    }
    
    func reauthorize() async {
        let center = AuthorizationCenter.shared
        do {
            try await center.requestAuthorization(for: FamilyControlsMember.individual)
            authorized = true
        }
        catch {
            print("authorization failed")
            authorized = false
        }
    }
    
}


