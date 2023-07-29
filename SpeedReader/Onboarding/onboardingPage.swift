//
//  welcomView.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 23.04.23.
//

import SwiftUI

enum onboardingPage: CaseIterable {
    case welcome
    case location
    
    static let fullOnboarding = onboardingPage.allCases
    
    var shouldShowNextButton: Bool {
        switch self {
        case .welcome:
            return true
        default:
            return false
        }
    }
    
    @ViewBuilder
    func view(action: @escaping () -> Void) -> some View {
        switch self {
        case .welcome:
            Text("Welcom")
        case .location:
            Text("Location")
        }
    }
}
    

