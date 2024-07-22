//
//  DuelView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/18/24.
//

import Foundation
import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct DuelView: View {
    
    let duelTimer: DuelTimer
    let duelSession: DuelSession
    let deviceActivityEvent: DeviceActivityEvent
    var deviceActivitySchedule: DeviceActivitySchedule
    let deviceActivityCenter: DeviceActivityCenter = DeviceActivityCenter()
    
    
    init(duelSession: DuelSession, schedule: DeviceActivitySchedule) {
        self.duelTimer = duelSession.createDuelTimer()
        self.duelSession = duelSession
        self.deviceActivityEvent = DeviceActivityEvent(applications: duelSession.apps.applicationTokens, threshold: DateComponents(second: 0))
        self.deviceActivitySchedule = schedule
    }
        
    
    var body: some View {
        VStack {
            //Text("Start Time: \(formatDate(dateComp: makeMutableInterval(wantStart: true)))")
                //.font(.headline)
            //Text("End Time: \(formatDate(dateComp: makeMutableInterval(wantStart: false)))")
                //.font(.headline)
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
            do {
                duelTimer.startTimer()
                /*
                print(deviceActivitySchedule.intervalStart)
                print(deviceActivitySchedule.intervalEnd)
                //
                print("selection before encoding")
                print(duelSession.apps.applicationTokens)
                saveSelection()
                print("selection after encoding")
                if let decodedSession = decodeSelection() {
                    print(decodedSession.applicationTokens)
                }
                try deviceActivityCenter.startMonitoring(.duelActivity, during: deviceActivitySchedule)
                */
            }
            catch {
                print("error: \(error)")
            }
        }
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
    
    
    
    func formatTime(totalSeconds: Int) -> String {
        var minutes = totalSeconds / 60
        let hours = minutes / 60
        minutes = minutes % 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    func formatDate(dateComp: DateComponents) -> String {
        guard let hour = dateComp.hour,
                  let minute = dateComp.minute,
                  let second = dateComp.second else {
                return ""
            }
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
}

/*
extension DeviceActivityName {
    static let duelActivity = Self("duelActivity")
}
*/


struct DuelViewPreview: PreviewProvider {
    static var previews: some View {
        DuelView(duelSession: DuelSession(hours: 1, minutes: 5), schedule: DeviceActivitySchedule(intervalStart: DateComponents(), intervalEnd: DateComponents(), repeats: true))
    }
}


//struct ControlButtonStyle: ViewModifier {
    //let color: Color
    //let disabled: Bool
    //func body(content: Content) -> some View {
        //content
            //.font(.title)
            //.bold()
            //.frame(width: 50, height: 50)
            //.background(color).opacity(disabled ? 0.5 : 1)
            //.foregroundStyle(.white)
            //.clipShape(Circle())
            //.disabled(disabled)
   //}
//}
