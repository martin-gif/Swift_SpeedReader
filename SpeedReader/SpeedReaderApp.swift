//
//  SpeedReaderApp.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 25.02.23.
//

import SwiftUI

@main
struct SpeedReaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands{
            commands()
        }
        
        WindowGroup(for: Book.self){ $book in
            if book != nil{
                BookDetail(book: book!)
            }
        }
        
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
