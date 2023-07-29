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
    
    init(book: Book){
        self.book = book
    }
    
    var body: some View {
        
        ScrollView{
            Text(self.book.text)
                .font(.system(size: 15))
                .padding(20)
        }
        
            
    }
}

struct ViewBook_Previews: PreviewProvider {
    static var previews: some View {
        ViewBook(book: Book())
    }
}
