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
    @State private var duelSession: DuelSession = DuelSession(hours: 0, minutes: 15)
    
    var body: some View {
        if sessionInProgress {
            VStack {
                Text("Screen Dueling In Progress")
                DuelView(duelSession: duelSession, schedule: setSessionSchedule(hours: duelSession.hours, minutes: duelSession.minutes))
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
    
    
    func setSessionSchedule(hours: Int, minutes: Int) -> DeviceActivitySchedule {
        let currentDate = Date()
            let startInterval = currentDate.addingTimeInterval(20) // 20 seconds after the current time
            
            let calendar = Calendar.current
            
            // Convert start interval to DateComponents
            let startComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startInterval)
            
            // Calculate end interval by adding the specified hours and minutes to the start interval
            var dateComponents = DateComponents()
            dateComponents.hour = hours
            dateComponents.minute = minutes
            
            let endInterval = calendar.date(byAdding: dateComponents, to: startInterval)!
            
            // Convert end interval to DateComponents
            let endComponents = calendar.dateComponents([.year,.month, .day, .hour, .minute, .second], from: endInterval)
            return DeviceActivitySchedule(intervalStart: startComponents, intervalEnd: endComponents, repeats: false)
    }
}


struct HomePageViewPreview: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
