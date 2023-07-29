//
//  Resources.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 30.03.23.
//

import Foundation

class singleResources{
    var id: String!
    var href: String?
    var fullHref: String?
    var text: String?
    
    init(id: String, fullHref: String? = nil, text: String? = nil) {
        self.id = id
        self.fullHref = fullHref
        if (fullHref?.contains("/"))! && fullHref != nil{
            href = getHref(fullHreg: fullHref!)
        }
        self.text = text
    }
    
    func getHref(fullHreg: String) -> String!{
        if fullHreg.isEmpty { return nil }
        var paths = fullHreg.components(separatedBy: "/")
        return paths.last
    }
    
    func setText(text: String){
        self.text = text
    }
}
