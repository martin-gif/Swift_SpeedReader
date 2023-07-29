//
//  Text.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 10.03.23.
//

import SwiftUI
import RealmSwift

class Book: Object ,ObjectKeyIdentifiable ,Identifiable, Codable{
    
    
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var location: String
    @Persisted var name : String
    @Persisted var cover : String?
    @Persisted var text: String
    //@Persisted var chapterList: RealmSwift.List<chapter>
    @Persisted var textReaden: Int
    @Persisted var tags: RealmSwift.List<String>
    
    convenience init(location: String,id: UUID = UUID(), name: String, cover: String? = nil, text: String = "", textReaden: Int = 0, tags: RealmSwift.List<String> = preTags()){
        self.init()
        self.location = location
        self.id = id
        self.name = name
        self.cover = cover
        self.text = text
        self.textReaden = textReaden
        self.tags = tags
    }
    
    func getWordsReaden() -> Int
    {
        return textReaden
    }
    
    func getPercentage() -> Int
    {
        let percentage = self.textReaden/self.text.count
        return percentage
    }
}



private func randomColor() -> colorComponent
{
    return colorComponent(
        red:   .random(in: 0..<1),
        green: .random(in: 0..<1),
        blue:  .random(in: 0..<1),
        alpha: 1.0
    )
}

private func preTags() -> RealmSwift.List<String>
{
    let returnTags = RealmSwift.List<String>()
    var str: String
    for _ in 1...5{
        str = String(Int.random(in: 1..<10))
        returnTags.append(str)
    }
    return returnTags
}
