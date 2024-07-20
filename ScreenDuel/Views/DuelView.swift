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

struct DuelView: View {
    
    let duelTimer: DuelTimer
    let duelSession: DuelSession
    let deviceActivityEvent: DeviceActivityEvent
    lazy var deviceActivitySchedule: DeviceActivitySchedule = {
        let currentDate = Date()
        let currentTime = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate)
        let duelSessionDateComponent = DateComponents(hour: duelSession.hours, minute: duelSession.minutes)
        let calendar = Calendar.current
        let endTimeDateWrapped = calendar.date(byAdding: duelSessionDateComponent, to: currentDate)
        let endTime = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: endTimeDateWrapped ?? Date())
        return DeviceActivitySchedule(intervalStart: currentTime, intervalEnd: endTime, repeats: false)
    }()
    let deviceActivityCenter: DeviceActivityCenter = DeviceActivityCenter()
    let activityName: DeviceActivityName = DeviceActivityName("duelActivity")
    
    init(duelSession: DuelSession) {
        self.duelTimer = duelSession.createDuelTimer()
        self.duelSession = duelSession
        self.deviceActivityEvent = DeviceActivityEvent(applications: duelSession.apps.applicationTokens, threshold: DateComponents(second: 0))
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
            duelTimer.startTimer()
            deviceActivityCenter.startMonitoring(activityName, during: deviceActivitySchedule)
        }
    }
    
    
    
    func formatTime(totalSeconds: Int) -> String {
        var minutes = totalSeconds / 60
        let hours = minutes / 60
        minutes = minutes % 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
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
    
    
    func formatDate(dateComp: DateComponents) -> String {
        guard let hour = dateComp.hour,
                  let minute = dateComp.minute,
                  let second = dateComp.second else {
                return ""
            }
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
    
    func makeMutableInterval(wantStart: Bool) -> DateComponents {
        var mutable = self
        if wantStart {
            return mutable.deviceActivitySchedule.intervalStart
        }
        else{
            return mutable.deviceActivitySchedule.intervalEnd
        }
    }
    
    
}



struct DuelViewPreview: PreviewProvider {
    static var previews: some View {
        DuelView(duelSession: DuelSession(hours: 1, minutes: 5))
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
