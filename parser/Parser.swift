//
//  Parser.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 08.04.23.
//

import Foundation


class Parser{
    static func parseFile(at sourceURL: URL) -> Book?{
        switch (sourceURL.pathExtension){
        case "epub":
            guard let epub = EPUBParser.parseFile(at: sourceURL) else {
                return nil
            }
            return epub.getBook()
        default:
            return nil
        }
    }
    
}
