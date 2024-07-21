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

class DuelSessionMonitor: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        let blockedApps = BlockedApps.shared()
        let applications = blockedApps.selection.applicationTokens
        store.shield.applications = applications.isEmpty ? nil : applications
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        store.shield.applications = nil
    }
}
