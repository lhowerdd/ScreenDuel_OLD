//
// Created for Custom Timer
// by  Stewart Lynch on 2024-05-26
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI

struct TimerView: View {
    let timerObject: TimerObject
    let controls: Bool
    //@State private var width: CGFloat = 0
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text(displayTime(timerObject.remainingTime))
                        .monospacedDigit()
                        //.font(.system(size: width / 3))
                    }
                    .foregroundStyle(timerObject.timerColor)
                    .bold()
                    .contentTransition(.numericText())
                }
            }
           
            if controls {
                HStack {
                    Button {
                        timerObject.startTimer()
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    //.modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.playButtonDisabled))
                    Button {
                        timerObject.stopTimer()
                    } label: {
                        Image(systemName: "pause.fill")
                    }
                   // .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.pauseButtonDisabled))
                    Button {
                        timerObject.resetTimer()
                    } label: {
                        Image(systemName: "gobackward")
                    }
                   // .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.resetButtonDisabled))
                }
            }
        }
    
    func displayTime(_ totalSeconds: Int) -> String {
        //let minutes = totalSeconds / 60
        //let seconds = totalSeconds % 60
        //return String(format: "%01d:%02d", minutes, seconds)
        var minutes = totalSeconds / 60
        let hours = minutes / 60
        minutes = minutes % 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
    
    
#Preview {
    TimerView(timerObject: TimerObject(timerColor: .red, length: 20), controls: true)
}

//struct ControlButtonStyle: ViewModifier {
    //let color: Color
    //let disabled: Bool
    //func body(content: Content) -> some View {
       // content
            //.font(.title)
            //.bold()
            //.frame(width: 50, height: 50)
            //.background(color).opacity(disabled ? 0.5 : 1)
           // .foregroundStyle(.white)
           // .clipShape(Circle())
           // .disabled(disabled)
   // }
//}
