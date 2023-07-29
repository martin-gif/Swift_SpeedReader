//
//  SpritzTimer.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 20.03.23.
//

import Foundation

class SpritzTimer {
    let timer: Timer
    var pauseDate: Date?
    var previousFireDate: Date?
    var isValid: Bool = true
    
    init(timer: Timer) {
        self.timer = timer
        self.isValid = timer.isValid
    }
    
    func invalidate() {
        self.timer.invalidate()
    }
    
    func pause() {
        pauseDate = Date()
        previousFireDate = self.timer.fireDate
        self.timer.fireDate = Date.distantFuture
    }
    
    func resume() {
        if let pauseDate = pauseDate, let previousFireDate = previousFireDate {
            let pauseTime = -pauseDate.timeIntervalSinceNow
            self.timer.fireDate = Date(timeInterval: pauseTime, since: previousFireDate)
        }
    }
    
    func intervall(time: TimeInterval)
    {
        self.timer.fireDate = Date(timeIntervalSinceNow: time)
    }
}
