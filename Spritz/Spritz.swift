//
//  Spritz.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 20.03.23.
//

import Foundation
import SwiftUI

public class Spritz{
    
    public typealias StatusBlock = (_ words: SpritzWord?, _ finished: Bool) -> ()
    
    private var text: String
    private var words = [SpritzWord]()
    private var book : Book = Book(location: "",name: "Non")
    private var speed: Double
    private var wordsPerMinute: Int = 400
    private var completion: StatusBlock?
    private(set) var status = Status.notStarted
    var current = 0
    
    // timer vars
    private var timer: Timer?
    private var pauseDate: Date?
    private var previousFireDate: Date?
    
    public init(Eingabe: String, wordsPerMinute: Int = 250) {
        self.text = Eingabe
        self.speed = Double(60/wordsPerMinute)
        self.speed = 1/speed
        
        words = self.package(ofWords: text.components(separatedBy: .whitespaces))
    }
    
    init(book: Book){
        self.book = book
        self.current = book.textReaden
        self.text = book.text
        self.speed = 60.0/Double(wordsPerMinute)
    
        print(speed)
        print("Komische sachen passieren?")
        words = self.package(ofWords: text.components(separatedBy: .whitespaces))
        

    }
    
    public enum Status {
        case stopped
        case reading
        case notStarted
        case finished
    }
    
    private func wordupdater(completion: @escaping StatusBlock, timer: Timer){
        if (self.current != self.words.count) {
            if (self.current > 0) {
                var end = Double(clock()) + (self.speed * Double(CLOCKS_PER_SEC))
                if self.containsFullStop(wordToAnalyze: self.words[self.current - 1].word) {
                    end = Double(clock()) + (self.speed * Double(CLOCKS_PER_SEC))
                    while Double(clock()) < end {
                    }
                }
            }
            self.status = .reading
            completion(self.words[self.current], false)
            self.current += 1
        } else if self.current == self.words.count {
            completion(nil, true);
            timer.invalidate()
            self.status = .finished
        }
    }
    
    /*
    public func startReading2(completion: @escaping StatusBlock) {
        //current = 0


        guard let timer = timer2, timer.isValid, status == .reading else {
            self.timer2?.invalidate()
            self.timer2 = SpritzTimer(timer: Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true, block: { (timer) in
                self.wordupdater(completion: completion, timer: timer)
            }))
            return
        }
    }
     */
     
    public func startReading(completion: @escaping StatusBlock) {
        //current = 0
        
        stopTimer() // stop the previous timer, if any
                
        // create a new timer
        self.completion = completion
        timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true, block: { (timer) in
            self.wordupdater(completion: completion, timer: timer)
        })
    }
     
    
    func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
        
    func updateTimeInterval(newTimeInterval: Double) {
        if timer != nil {
            stopTimer()
            //startReading2(timeInterval: newTimeInterval, action: {})
            self.speed = newTimeInterval
            startReading(completion: self.completion!)
        }
    }
    
    public func resumeReading() {
        if status == .stopped || status == .notStarted{
            status = .reading
            print(status)
            // muss süäter wieder eingebaut werden
            if let pauseDate = pauseDate, let previousFireDate = previousFireDate {
                let pauseTime = -pauseDate.timeIntervalSinceNow
                self.timer?.fireDate = Date(timeInterval: pauseTime, since: previousFireDate)
            }
        } else {
            print("SpritzSwift message: Reading can only be resumed when is stopped")
        }
    }

    public func pauseReading() {
        if status == .reading {
            status = .stopped
            // muss später wieder eingebaut werden 
            pauseDate = Date()
            previousFireDate = self.timer?.fireDate
            self.timer?.fireDate = Date.distantFuture
        } else {
            print("SpritzSwift message: Reading can only be paused when the reading is active")
        }
    }
    
    private func containsFullStop(wordToAnalyze word: String) -> Bool {
        if word.contains(". ") {
            return true
        } else if word.contains("! ") {
            return true
        } else if word.contains(", ") {
            return true
        } else if word.contains("... ") {
            return true
        } else if word.contains("… ") {
            return true
        } else if word.contains("? ") {
            return true
        } else if word.contains(": ") {
            return true
        } else if word.contains("; ") {
            return true
        } else {
            return false
        }
    }
    
    private func package(ofWords words: [String]) -> [SpritzWord]{
        var packageOfWords = [SpritzWord]()
        for word in words {
            packageOfWords.append(SpritzWord(withWord: word))
        }
    
        return packageOfWords
    }
}
