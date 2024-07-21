//
//  BlockedApps.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/20/24.
//

import Foundation
import FamilyControls

class BlockedApps {
    
    private static var sharedBlockedApps: BlockedApps = {
        let blockedApps = BlockedApps(selection: FamilyActivitySelection())
        return blockedApps
    }()
    
    var selection: FamilyActivitySelection
    
    private init(selection: FamilyActivitySelection) {
        self.selection = selection
    }
    
    class func shared() -> BlockedApps {
        return sharedBlockedApps
    }
    
    func setSelection(selection: FamilyActivitySelection) {
        self.selection = selection
    }
    
}
