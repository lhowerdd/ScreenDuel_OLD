//
//  HomePageView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/7/24.
//

import Foundation
import SwiftUI

struct HomePageView: View {
    
    @State var duelSession: DuelSession = DuelSession(hours: 0, minutes: 5)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to ScreenDuel")
                List {
                    
                    Section(header: Text("Create a screen duel session")) {
                        NavigationLink(destination: TimeSelectorView(hours: $duelSession.hours, minutes: $duelSession.minutes)) {
                            Text("Session Length: \(duelSession.hours)h \(duelSession.minutes)m")
                        }
                        NavigationLink(destination: AppSelectorView(selection: $duelSession.apps)) {
                            Text("Apps to block")
                        }
                    }
                }
                //.frame(maxHeight: 175)
                Button(action: {}) {
                    Label("Begin screen dueling", systemImage: "play.fill")
                }
                Spacer()
                
            }
        }
    }
}

struct HomePageViewPreview: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


