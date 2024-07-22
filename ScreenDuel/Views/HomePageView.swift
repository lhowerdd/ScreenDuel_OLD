//
//  DuelView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/18/24.
//

import Foundation
import SwiftUI
import DeviceActivity
import FamilyControls

struct HomePageView: View {
    
    @State private var sessionInProgress: Bool = false
    @State private var duelSession: DuelSession = DuelSession(hours: 0, minutes: 15)
    @State var deviceSchedule = DeviceActivitySchedule(intervalStart: DateComponents(), intervalEnd: DateComponents(), repeats: false)
    
    
    var body: some View {
        if sessionInProgress {
            VStack {
                Text("Screen Dueling In Progress")
                let schedule = deviceSchedule
                DuelView(duelSession: duelSession, schedule: schedule)
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
    
    
    func startSession()  {
        let schedule = setSessionSchedule(hours: duelSession.hours, minutes: duelSession.minutes)
        print(schedule.intervalStart)
        print(schedule.intervalEnd)
        //
        print("selection before encoding")
        print(duelSession.apps.applicationTokens)
        saveSelection()
        print("selection after encoding")
        if let decodedSession = decodeSelection() {
            print(decodedSession.applicationTokens)
        }
        let deviceActivityCenter = DeviceActivityCenter()
        do {
            try deviceActivityCenter.startMonitoring(.duelActivity, during: schedule)
        }
        catch {
            print("deviceMonitor error: \(error)")
        }
        deviceSchedule = schedule
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
    
    
    func saveSelection() {
        let encoder = PropertyListEncoder()
        if let userDefaults = UserDefaults(suiteName: "group.378NQ4JQ6T.com.ScreenDuel.Len") {
            userDefaults.set(
                try? encoder.encode(duelSession.apps),
                forKey: "duelSelection"
            )
        }
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

extension DeviceActivityName {
    static let duelActivity = Self("duelActivity")
}


struct HomePageViewPreview: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
