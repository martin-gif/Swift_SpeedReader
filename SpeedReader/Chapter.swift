//
//  chapter.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 15.05.23.
//

import Foundation
import RealmSwift
import SwiftSoup

class chapter: Object, Codable{
    
    @Persisted var id = ""
    @Persisted var href = ""
    @Persisted var htmlString = ""
    @Persisted var textReaden = 0
    /*
    @Persisted var nextChapter: chapter?
    @Persisted var previusChapter: chapter?
     */
    
    func setTextReaden(count: Int){
        self.textReaden = count
    }
    func getTextReaden() -> Int {
        return textReaden
    }
    
    func getID() -> String{
        return self.id
    }
    
    func getText() -> String{
        if htmlString == ""{
            return ""
        }
        else {
            do {
                let doc = try SwiftSoup.parse(htmlString)

                let bodyElements = doc.body()
                let displayedText = try getTextFromHTML((bodyElements?.children())!)
                return displayedText
            }
            catch {
                print("Error reading or parsing HTML file: \(error.localizedDescription)")
                return ""
            }
        }
    }
    
    // hier letztes problem, das tag "<section>" gescannt wurde und dann nocheinmal alle subelemente wodurch text doppelt vorkamm
    private func getTextFromHTML(_ elements: Elements) throws -> String {
        var displayedText = [String]()
        for element in elements {
            displayedText.append(try element.text())
            //print(try element.text())
        }
        return displayedText.joined(separator: " ")
    }
    
    /*
    func setNextChapter(next: chapter){
        self.nextChapter = next
    }
    
    func setPreviusChapter(prev: chapter){
        self.previusChapter = prev
    }
    
    func printneighbours() -> String{
        return (previusChapter?.getID() ?? "empty") + " " + self.id + " " + (nextChapter?.getID() ?? " empty")
    }
     */
}
