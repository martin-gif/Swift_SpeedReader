//
//  SwiftUIView.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 11.03.23.
//

import SwiftUI


struct Item: Identifiable {


    let id = UUID()

    let url: URL


}


extension Item: Equatable {

    static func ==(lhs: Item, rhs: Item) -> Bool {

        return lhs.id == rhs.id && lhs.id == rhs.id

    }

}
