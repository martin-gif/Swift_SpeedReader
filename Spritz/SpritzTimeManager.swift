//
//  SpritzTimeManager.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 22.04.23.
//

import Foundation

class SpritzTimeManager {
    private var timer: Timer?
    
    func startTimer(timeInterval: TimeInterval, action: @escaping () -> Void) {
        stopTimer() // stop the previous timer, if any
        
        // create a new timer
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            action()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateTimeInterval(newTimeInterval: TimeInterval) {
        if timer != nil {
            stopTimer()
            startTimer(timeInterval: newTimeInterval, action: {})
        }
    }
}
