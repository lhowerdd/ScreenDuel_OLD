//
//  AppSelectorView.swift
//  ScreenDuel
//
//  Created by Leo Howerdd on 7/8/24.
//

import Foundation
import SwiftUI
import FamilyControls

struct AppSelectorView: View {
    
    @Binding var selection: FamilyActivitySelection

    var body: some View {
        VStack {
            Image(systemName: "eye")
                .font(.system(size: 76.0))
                .padding()
            
            FamilyActivityPicker(selection: $selection)
            
            Image(systemName: "hourglass")
                .font(.system(size: 76.0))
                .padding()
        }
        //.onChange(of: selection) { newSelection in
                   //let applications = selection.applications
                   //let categories = selection.categories
                   //let webDomains = selection.webDomains
        //}
    }
}
