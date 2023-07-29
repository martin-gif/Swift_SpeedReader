//
//  TextCell.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 10.03.23.
//

import SwiftUI

struct BookCell: View {
    //var text: Text
    //let texts : [Text]
    let book: Book
    var image: Image
    
    init(book: Book){
        self.book = book
        if book.cover != nil{
            let nsImg = NSImage(contentsOf: URL(string: book.cover!)!)
            if nsImg != nil{
                image = Image(nsImage: nsImg!)
            }else
            {
                image = Image("backupCover")
                
            }
        }else
        {
            image = Image("backupCover")
    
        }
        
       
    }
    
    var body: some View {
        VStack(alignment: .leading){
            image
                .resizable()
                .scaledToFit()
            Text(book.name)
                .font(.title3)
                .bold()
                .lineLimit(1)
        }
    }
}

struct TextCell_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewer()
            .frame(width: 800,height: 900)
    }
}

struct BookButton: ButtonStyle{
    let book: Book
    func makeBody(configuration: Configuration) -> some View{
        BookCell(book: book)
    }
}
