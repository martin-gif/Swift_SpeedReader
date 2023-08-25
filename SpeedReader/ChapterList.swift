//
//  ChapterList.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 01.08.23.
//

import Foundation
import RealmSwift

class chapterList: Object, Codable{
    
    @Persisted var _list: RealmSwift.List<chapter>
    @Persisted var _currentChapter: chapter? = chapter()
    @Persisted var _head: chapter? = chapter()
    @Persisted var _tail: chapter? = chapter()
    @Persisted var _indexChapter = 0
    
    
    override init() {
        super.init()
        
        //init head and tail from double linked List
        self._head = chapter()
        self._head?.id = "head"
        self._tail = chapter()
        self._tail?.id = "tail"
        
        self._currentChapter = _head
    }
    
    func loadList(list: [chapter]){
        self._list.append(objectsIn: list)
        self._currentChapter = _list[0]
    }
    
    /**
     Later used to get the current position of the reader but for now it will give a random chapter
     */
    func getCurrentText() -> String{
        return self._currentChapter!.getText()
    }
    
    func getNextChapter() -> String {
        do {
            let realm = self.realm!.thaw()
            try realm.write{
                self.thaw()?._indexChapter += 1
            }
        } catch {
            print("Error in Chapterlist", error)
        }
        
        return self._list[_indexChapter].getText()
    }

}
