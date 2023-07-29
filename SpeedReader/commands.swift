//
//  commands.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 08.04.23.
//

import SwiftUI
import RealmSwift

struct commands: Commands{
    
    @ObservedResults(Book.self) var allBooks
    
    @State private var isShowing = false
    var fileManager = FileManagerSingelton.shared
    
    var body: some Commands {
        CommandMenu("import"){
            Button("Import File"){
                isShowing.toggle()
            }
            .fileImporter(isPresented: $isShowing, allowedContentTypes: [.item]) {result in
                switch result {
                case .success(let url):
                    switch fileManager.copyInAppFolder(from: url){
                    case .success(let newUrl):
                        guard let book = Parser.parseFile(at: newUrl) else {
                            print("Error while Parsing book")
                            return
                        }
                        $allBooks.append(book)
                    case .failure(let error):
                        print(error)
                        return
                    }
                case .failure(let error):
                    print(error)
                    return
                    
                }
            }
        }
    }
    
    
}


