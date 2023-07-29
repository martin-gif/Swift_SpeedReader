//
//  OnboardingView.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 23.04.23.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var currentPage: onboardingPage = .welcome
    private let pages: [onboardingPage]
    
    init(pages: [onboardingPage]){
        self.pages = pages
    }
    
    var body: some View {
        VStack {
            ForEach(pages, id: \.self) { page in
                if page == currentPage {
                    page.view(action: showNextPage)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(AnyTransition.asymmetric(
                                        insertion: .move(edge: .trailing),
                                        removal: .move(edge: .leading))
                                    )
                        .animation(.default, value: 1)
                }
            }
            
            if currentPage.shouldShowNextButton {
                HStack {
                    Spacer()
                    Button(action: showNextPage, label: {
                        Text("Next")
                    })
                }
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 50, trailing: 50))
                .transition(AnyTransition.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading))
                            )
                .animation(.default, value: 1)
            }
        }
            .frame(width: 800, height: 600)
            .onAppear {
                self.currentPage = pages.first!
            }
    }
    
    private func showNextPage() {
        guard let currentIndex = pages.firstIndex(of: currentPage), pages.count > currentIndex + 1 else {
            return
        }
        currentPage = pages[currentIndex + 1]
    }
}


