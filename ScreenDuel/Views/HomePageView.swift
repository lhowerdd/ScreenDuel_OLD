//
//  HomePageView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/7/24.
//

import Foundation
import SwiftUI

struct HomePageView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to ScreenDuel")
                List {
                    Section(header: Text("Create a screen duel session")) {
                        NavigationLink(destination: TimeSelectorView()) {
                            Text("Item 1")
                        }
                    }
                }
            }
        }
    }
}

struct HomePageViewPreview: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
