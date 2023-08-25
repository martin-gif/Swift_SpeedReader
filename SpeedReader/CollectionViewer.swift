//
//  CollectionViewer.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 09.03.23.
//

import SwiftUI
import RealmSwift

struct CollectionViewer: View {
    
    @ObservedResults(Book.self, configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true)) var allBooks
    @Environment(\.openWindow) private var openWindow
    

  
    let columnLayout = Array(repeating: GridItem(.adaptive(minimum: 200, maximum: 220 ),spacing: 10), count: 3)
    private var gridItemLayout = [GridItem(.adaptive(minimum: 50,maximum: 80),spacing: 20)]
    

    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: columnLayout, spacing: 20){
                    ForEach(allBooks)
                    { book in
                        Button(action: {
                            openWindow(value: book)
                        }) {
                            BookCell(book: book)
                        }
                        .buttonStyle(BookButton(book: book))
                        .padding()
                        .contextMenu{
                            Button("Delete"){
                                deleteBook(book)
                            }
                        }
                    }
                    .onDelete(perform: $allBooks.remove)
                    
                }
            }
        }
    }
    func deleteBook(_ book: Book) {
        $allBooks.remove(book)
    }
}



extension View{
    private func newWindowInternal(with title: String, book: Book) {
            let reader = BookDetail(book:  book)
        
            let window = NSWindow(
                contentRect: NSRect(x: 20, y: 20, width: 680, height: 600),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            window.center()
            window.isReleasedWhenClosed = false
            window.title = title
            
            // Create a new toolbar
            window.center()
            // Assign the toolbar to the window object
            window.toolbar = .taskListToolbar
            window.titleVisibility = .hidden
            window.setFrameAutosaveName("Main Window")
            window.contentView = NSHostingView(rootView: reader)
            window.makeKeyAndOrderFront(nil)
        }
        
    func openNewWindow(title: String = "new Window", book: Book) {
            //self.newWindowInternal(with: title).contentView = NSHostingView(rootView: self)
            self.newWindowInternal(with: title, book: book)
        }
    
    @discardableResult
    func openInWindow(title: String, sender: Any?) -> NSWindow {
        let controller = NSHostingController(rootView: self)
        let win = NSWindow(contentViewController: controller)
        win.contentViewController = controller
        //win.title = title
        win.makeKeyAndOrderFront(sender)
        
        //prepare Toolbar
        let toolbar = NSToolbar(identifier: "CustomToolbar")
        toolbar.allowsUserCustomization = true
        win.toolbar = toolbar
        
        return win
    }
}

// Preview
struct CollectionViewer_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewer()
            .frame(width: 800,height: 900)
    }
}
