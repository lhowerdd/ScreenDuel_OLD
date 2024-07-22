//
//  DuelSessionMonitor.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/19/24.
//

import Foundation
import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

class DuelSessionMonitor: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        print("hi")
        super.intervalDidStart(for: activity)
        let selection = decodeSelection()
        let blockedApps = selection?.applicationTokens
        store.shield.applications = blockedApps
        
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        store.shield.applications = nil
    }
    
    
    func decodeSelection() -> FamilyActivitySelection? {
        let userDefaults = UserDefaults(suiteName: "group.378NQ4JQ6T.com.ScreenDuel.Len")
        guard let encodedSelection = userDefaults?.data(forKey: "duelSelection") else {
            return nil
        }
           
        let decoder = PropertyListDecoder()
        do {
            let selection = try decoder.decode(FamilyActivitySelection.self, from: encodedSelection)
            return selection
        }
        catch {
            print("Failed to decode FamilyActivitySelection: \(error)")
            return nil
        }
    }
    
}
