//
//  ViewSpritz.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 15.05.23.
//

import SwiftUI
import RealmSwift

struct ViewSpritz: View {
    
    @ObservedRealmObject var book: Book
    
    @State private var wpm: Int
    @State private var markerInt = 0
    @State private var spritzWordForText = " "
    @State private var current: Int
    var spritz : Spritz
    
    init(book: Book){
        self.book = book
        self.wpm = 250
        self.current = book.textReaden
        self.spritz = Spritz(book: book)
    }
    
    func updateWord(_ wordInput: SpritzWord){
        markerInt = wordInput.markerPosition
        spritzWordForText = wordInput.word
        current = spritz.current
        //print(spritzWordForText, markerInt)
    }
    
    func buttonManager() {
        switch spritz.status {
        case .notStarted:
            spritz.startReading{ (word, finshed) in
                if !finshed{
                    updateWord(word ?? SpritzWord(withWord: "Hallo Welt"))
                }
            }
        case .stopped:
            spritz.resumeReading()
            print("Resume")
        case .reading:
            spritz.pauseReading()
            //$book.textReaden = spritz.current
            $book.textReaden.wrappedValue = current
            print(spritz.status)
        default:
            print("Starge problem")
        }
    }
    
    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                HStack{
                    Text("Name:")
                    Text(book.name)
                }
                HStack{
                    Text("Words Per Minute")
                    TextField("", value: $wpm, formatter: NumberFormatter())
                        .frame(width: 50)
                    Button("Update Speed", action: {
                        self.spritz.updateTimeInterval(newTimeInterval: 60.0/Double(wpm))
                    })
                }
                .frame(maxWidth: 300)
                Spacer()
                
                VStack {
                    SpritzWordViewMac(word: spritzWordForText, markerPosition: markerInt)

                    Spacer()
                    HStack{
                        Button("action", action: {
                            buttonManager()
                        })
                    }
                }
                .padding()
                
                HStack {
                    ForEach(book.tags,id: \.self){ tag in
                        Text(tag)
                    }
                }
                Button("print Status", action:{
                    print(self.spritz.status, book.textReaden)
                })
                Text("Wörter gelesen \(current)")
            }
        }
    }
}
