//
//  ContentView.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 25.02.23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
   
    //let realmConf = Realm.Configuration(
    //    deleteRealmIfMigrationNeeded: true
    //)
    
    
    @ObservedResults(Book.self, configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true)) var books
    
    @State var slected: Int? = nil
    //@State var alreadypresentet: false
    
    var body: some View {
        NavigationView {
            NavigationBarLeft()
            CollectionViewer()
        }
        //.sheet(isPresented: $alreadypresentet, content: {
         //   OnboardingView(pages: .welcome)
        //})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
