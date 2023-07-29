//
//  SpritzWord.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 20.03.23.
//

import Foundation

public class SpritzWord {
    private static let minimum = 0.18
    private static let maximum = 0.3
    private static let minTreshold = 4.0
    private static let maxTreshold = 10.0
    private var delay: TimeInterval = 0
    private(set) var markerPosition: Int = 0
    
    public var word: String = ""
    
    public convenience init(withWord word: String = "Spritz") {
        self.init()
        self.word = word
        self.delay = self.calculateDelay()
        self.markerPosition = self.getReaderMarkerPosition()
    }
    
    private func calculateDelay() -> TimeInterval {
        let length = Double(self.word.count)
        
        if (length < SpritzWord.minTreshold) {
            return SpritzWord.minimum
        }
        if (length > SpritzWord.maxTreshold) {
            return SpritzWord.maximum
        }
        
        return SpritzWord.minimum + ((SpritzWord.maximum - SpritzWord.minimum)/(SpritzWord.maxTreshold - SpritzWord.minTreshold))
    }
    
    func updateDelay(newDelay: TimeInterval)
    {
        
    }
    
    private func getReaderMarkerPosition() -> Int {
        let length = self.word.count
        var letter = 0
        switch (length) {
        case 1, 2:
            letter = 0
        case 3, 4, 5:
            letter = 1
        case 6, 7, 8, 9:
            letter = 2
        case 10, 11, 12, 13:
            letter = 3
        default:
            letter = 4
        }
        
        return letter
    }
}
