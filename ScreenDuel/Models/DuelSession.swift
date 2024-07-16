//
//  DuelSession.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/8/24.
//

import Foundation
import FamilyControls


struct DuelSession {
    //how many hours the session is
    var hours: Int
    //how many minutes the session is
    var minutes: Int
    //abstraction of apps selected in the session
    var apps: FamilyActivitySelection
    
    init(hours: Int, minutes: Int) {
        self.minutes = minutes
        self.hours = hours
        self.apps = FamilyActivitySelection()
    }
    
}
