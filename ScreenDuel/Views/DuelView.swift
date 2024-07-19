//
//  DuelView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/18/24.
//

import Foundation
import SwiftUI

struct DuelView: View {
    
    var duelTimer: DuelTimer
    
    init(duelTimer: DuelTimer) {
        self.duelTimer = duelTimer
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(formatTime(totalSeconds: duelTimer.timeRemaining))
                    .monospacedDigit()
                    .bold()
            }
            .contentTransition(.numericText())
            HStack {
                Button {duelTimer.startTimer()}
                    label: { Image(systemName: "play.fill")}
                    .disabled(duelTimer.playButtonDisabled)
                Button {duelTimer.stopTimer()}
                    label: {Image(systemName: "pause.fill")}
                    .disabled(duelTimer.pauseButtonDisabled)
            }
        }
        .onAppear() {
            duelTimer.startTimer()
        }
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

struct ControlButtonStyle: ViewModifier {
    //let color: Color
    let disabled: Bool
    func body(content: Content) -> some View {
        content
            .font(.title)
            .bold()
            .frame(width: 50, height: 50)
            //.background(color).opacity(disabled ? 0.5 : 1)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .disabled(disabled)
    }
}
