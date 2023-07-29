//
//  OnboardingSheet.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 23.04.23.
//

import SwiftUI

struct OnboardingSheet: View {
    
    enum sheet: String, Identifiable{
        case welcome, loaction
        
        var id: String {rawValue}
    }
    @State var presentetSheet: sheet?
    
    var body: some View {
        VStack {
            Button("Welcom") {
                presentetSheet = .welcome
            }
            Button("location") {
                presentetSheet = .loaction
            }
        }
        .sheet(item: $presentetSheet, content: { sheet in
            switch sheet{
            case .welcome:
                welcomeView()
            case .loaction:
                locationView()
            }
        })
        .padding()
        .frame(width: 400, height: 300)
    }
}

struct OnboardingSheet_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSheet()
    }
}
