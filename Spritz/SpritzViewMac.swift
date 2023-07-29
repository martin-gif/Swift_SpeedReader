//
//  SpritzView.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 20.03.23.
//

import SwiftUI

struct SpritzViewMac: View {
    
    
    //var spritz = Spritz(Eingabe:"Welcome to SpritzSwift! Spritz is a brand new revolutionary reading method that will help you to improve your number of words per minute. Take a look at SpritzSwift!", wordsPerMinute: 400)
    
    var spritz : Spritz
    var book: Book
    
    init(book: Book , wordsPerMinute: Int)
    {
        self.spritz = Spritz(book: book)
        self.book = book
    }
    

    @State var spritzWordForText = " "
    @State var markerInt = 0
    
    //let newTextViewRect = self.view.bounds
    

    
    
    
    var body: some View {
        Text("dont needed anymore")
        
    }
    
    /*
     struct TextView: NSViewRepresentable
     {
         @Binding var text: NSMutableAttributedString
         
         func makeNSView(context: Context) -> NSTextView
         {
             NSTextView()
         }
         
         func updateNSView(_ nsView: NSTextView, context: Context)
         {
             nsView.textStorage?.setAttributedString(text)
         }

     }
     */
    
    struct TextView: NSViewRepresentable
    {
        @Binding var text: NSMutableAttributedString
        
        func makeNSView(context: Context) -> NSTextView
        {
            NSTextView()
        }
        
        func updateNSView(_ nsView: NSTextView, context: Context)
        {
            nsView.textStorage?.setAttributedString(text)
        }

    }
}


struct SpritzView_Previews: PreviewProvider {
    static var previews: some View {
        SpritzViewMac(book: Book(name: "Preview"),wordsPerMinute: 200)
            .frame(width: 300,height: 200)
    }
}

