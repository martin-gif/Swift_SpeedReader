//
//  BookDetail.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 11.03.23.
//


import SwiftUI
import RealmSwift

struct BookDetail: View{
    
    @ObservedRealmObject var book: Book

    enum ViewChoice: String, CaseIterable, Identifiable {
      case spritz, text
        var id: Self { self }
    }
    @State private var toView: ViewChoice = .spritz
    
    
    @ViewBuilder
    var body: some View {
        containerView()
            .toolbar{
                ToolbarItem(placement: .principal){
                    Picker("", selection: $toView){
                        ForEach(ViewChoice.allCases){ choice in
                            Text(choice.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
    }
    
    func containerView() -> AnyView{
        switch(toView) {
        case .spritz:
            return AnyView(ViewSpritz(book: book))
        case .text:
            return AnyView(ViewBook(book: book))
        }
    }
}

//class test: UIV

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(book: Book(location: "",name: "Preview"))
            .frame(width: 500,height: 800)
    }
}

