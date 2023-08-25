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
    @Persisted var chapterList: SpeedReader.chapterList?
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
        self.chapterList = SpeedReader.chapterList()
    }
    
    func getWordsReaden() -> Int
    {
        return textReaden
    }
    
    func initChapterList(list: [chapter]){
        self.chapterList?.loadList(list: list)
    }
    
    func getCurrentText() -> String{
        self.text = chapterList!.getCurrentText()
        return self.text
    }
    
    func getNextChapter() -> String{
        self.text = chapterList!.getNextChapter()
        return text
    }
    func getChapterID() -> String{
        return self.chapterList?._currentChapter?.getID() ?? "empty"
    }
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
