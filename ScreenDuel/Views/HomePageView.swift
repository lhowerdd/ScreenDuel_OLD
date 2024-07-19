//
//  DuelView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/18/24.
//

import Foundation
import SwiftUI

struct HomePageView: View {
    
    @State private var sessionInProgress: Bool = false
    @State private var duelSession: DuelSession = DuelSession(hours: 0, minutes: 5)
    
    
    var body: some View {
        if sessionInProgress {
            VStack {
                Text("Screen Dueling In Progress")
                DuelView(duelTimer: duelSession.createDuelTimer())
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
}


struct HomePageViewPreview: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
