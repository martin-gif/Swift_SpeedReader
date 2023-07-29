//
//  SpritzWordViewMac.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 22.03.23.
//

import SwiftUI

struct SpritzWordViewMac: View {
    
    var markerColor = Color.red
    var normalColor = Color.white
    @State var size: CGSize = .zero

    
    let word: [Character]
    let markerPosition: Int
        
    init(word: String, markerPosition: Int) {
        self.word = Array(word) // for convenience of `ForEach` used below
        self.markerPosition = markerPosition
    }
    
    var body: some View {
        
        HStack(alignment: .center,spacing: 0) {
            
            if(word.count > markerPosition){
                Spacer().overlay(
                HStack(spacing: 0) {
                    ForEach(0..<markerPosition, id: \.self) { index in
                        Text(String(word[index]))
                            .foregroundColor(normalColor)
                    }
                },
                alignment: .trailing)
                Text(String(word[markerPosition]))
                    .foregroundColor(markerColor)
                Spacer().overlay(
                HStack(spacing: 0) {
                    ForEach(markerPosition+1..<word.count, id: \.self) { index in
                        Text(String(word[index]))
                            .foregroundColor(normalColor)
                    }
                },
                alignment: .leading)
            } else {
                Text(String(word))
            }
            
            
        }
        .font(.system(size: 30))
        .monospaced()
        .frame(
        minWidth: 0,
        maxWidth: .infinity,
        minHeight: 40
        )
    }
}



struct SpritzWordViewMac_Previews: PreviewProvider {
    static var previews: some View {
        SpritzWordViewMac(word: "ssss", markerPosition: 4)
            .frame(width: 300,height: 100)
    }
}


