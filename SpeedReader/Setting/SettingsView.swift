//
//  SettingsView.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 26.04.23.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, location
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem{
                    Label("General",systemImage: "gear")
                }
                .tag(Tabs.general)
            LocationSettingsView()
                .tabItem{
                    Label("Loacation",systemImage: "externaldrive")
                }
                .tag(Tabs.location)
        }
        .padding(20)
        .frame(width: 475,height: 350)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
