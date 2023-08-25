//
//  ViewBook.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 15.05.23.
//

import SwiftUI
import RealmSwift

struct ViewBook: View {
    @ObservedRealmObject var book: Book
    @State var text: String
    
    init(book: Book){
        self.book = book
        self.text = ""
        
        //self.text = book.getCurrentText()
    }
    
    func nextPage(){
        /*
            guard let thawed = book.thaw(), let realm = thawed.realm else {
                print("Error")
                return
            }
            
            try! realm.write {
                print("is not in Write Transaction")
                self.text = thawed.getNextChapter()
            }
         */
        
        let realm = book.thaw()!.realm!
        
        let thawedBook = self.book.thaw()!
        try! realm.write{
            self.text = thawedBook.getNextChapter()
        }
        
        //let realm = book.realm!.thaw()
        //self.text = (self.book.thaw()?.getNextChapter())!
    }
    
    var body: some View {
        
        ScrollView{
            Text(text)
                .font(.system(size: 15))
                .padding(20)
            Text(book.getChapterID())
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                //self.text = (book.thaw()?.getNextChapter())!
                nextPage()
            }
        }
    }
}

struct ViewBook_Previews: PreviewProvider {
    static var previews: some View {
        ViewBook(book: Book())
    }
}
