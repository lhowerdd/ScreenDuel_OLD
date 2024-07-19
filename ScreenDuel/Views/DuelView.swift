//
//  DuelView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/18/24.
//

import Foundation
import SwiftUI

struct DuelView: View {
    
    @ObservedObject var duelTimer: DuelTimer
    
    init(duelTimer: DuelTimer) {
        self.duelTimer = duelTimer
    }
    
    var body: some View {
        VStack {
            Text(formatTime(totalSeconds: duelTimer.timeRemaining))
            Button(action: {duelTimer.startTimer()}) {
                Label("start timer", systemImage: "play.fill")
            }
        }
        .bold()
        .contentTransition(.numericText())
        .animation(.linear, value: duelTimer.timeRemaining)
    }
    
    func formatTime(totalSeconds: Int) -> String {
        var minutes = totalSeconds / 60
        let hours = minutes / 60
        minutes = minutes % 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}



struct DuelViewPreview: PreviewProvider {
    static var previews: some View {
        DuelView(duelTimer: DuelTimer(hours: 1, minutes: 5))
    }
}
