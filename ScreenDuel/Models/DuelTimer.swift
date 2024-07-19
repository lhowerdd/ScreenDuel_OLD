//
//  DuelTimer.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/18/24.
//

import Foundation
import SwiftUI

@Observable
class DuelTimer {
    
    let length: Int
    
    init(hours: Int, minutes: Int) {
        self.length = ((minutes * 60) + (hours * 3600))
    }
    
    var timer: Timer? = nil
    var timeElapsed = 0
    
    var isTimerRunning = false
    
    var timeRemaining: Int {
        length - timeElapsed
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[self] _ in
            if timeRemaining > 0 {
                timeElapsed += 1
            }
            else {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        if isTimerRunning {
            isTimerRunning = false
            timer?.invalidate()
        }
    }
    
    var playButtonDisabled: Bool {
        guard timeRemaining > 0, !isTimerRunning else { return true}
        return false
    }
    
    var pauseButtonDisabled: Bool {
        guard timeRemaining > 0, isTimerRunning else { return true }
        return false
    }
}
