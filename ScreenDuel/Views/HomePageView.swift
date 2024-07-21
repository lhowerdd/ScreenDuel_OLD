//
//  DuelView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/18/24.
//

import Foundation
import SwiftUI
import DeviceActivity

struct HomePageView: View {
    
    @State private var sessionInProgress: Bool = false
    @State private var duelSession: DuelSession = DuelSession(hours: 0, minutes: 5)
    
    
    var body: some View {
        if sessionInProgress {
            VStack {
                Text("Screen Dueling In Progress")
                DuelView(duelSession: duelSession, schedule: setSessionSchedule())
            }
        }
        else {
            VStack {
                DuelCreatorView(duelSession: $duelSession)
                Button(action: {startSession()}) {
                    Label("Begin screen dueling", systemImage: "play.fill")
                }
            }
        }
    }
    
    
    
    func startSession() {
        sessionInProgress = true
    }
    
    func setSessionSchedule() -> DeviceActivitySchedule {
        let currentDate = Date()
        let currentTime = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate)
        let duelSessionDateComponent = DateComponents(hour: duelSession.hours, minute: duelSession.minutes)
        let calendar = Calendar.current
        let endTimeDateWrapped = calendar.date(byAdding: duelSessionDateComponent, to: currentDate)
        let endTime = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: endTimeDateWrapped ?? Date())
        return DeviceActivitySchedule(intervalStart: currentTime, intervalEnd: endTime, repeats: false)
    }
    
}





struct HomePageViewPreview: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
