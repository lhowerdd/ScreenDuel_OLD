//
//  TimeSelectorView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/7/24.
//

import Foundation
import SwiftUI

struct TimeSelectorView: View {
    
    @Binding var hours: Int
    @Binding var minutes: Int
    
    let hourOptions = Array(0...23)
    let minuteOptions = Array(1...59)
    
    var body: some View {
        HStack {
            Picker("Select hours", selection: $hours) {
                ForEach(hourOptions, id: \.self) { number in
                    Text("\(number) hours")
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("Select minutes", selection: $minutes) {
                ForEach(minuteOptions, id: \.self) { number in
                    Text("\(number) minutes")
                }
            }
            .pickerStyle(WheelPickerStyle())
            
        }
    }
}

//struct TimeSelectorViewPreview: PreviewProvider {
    //static var previews: some View {
        //TimeSelectorView(minutes: 5, hours: 4)
    //}
//}
