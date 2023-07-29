//
//  chapter.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 15.05.23.
//

import Foundation
import RealmSwift

class chapter: EmbeddedObject{
    
    @Persisted var id: String!
    @Persisted var href: String?
    @Persisted var fullHref: String?
    @Persisted var text: String?
}
