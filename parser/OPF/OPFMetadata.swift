//
//  OPFMetadata.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 28.03.23.
//

import Kanna

struct OPFMetadata {
    // DCMES Required Elements
    private(set) var identifiers = [String]()
    private(set) var titles = [String]()
    private(set) var languages = [String]()
    // DCMES Optional Elements
    private(set) var creators = [String]()
    private(set) var date: String?
    private(set) var publisher: String?
    // Others like contributor, description, etc.
    init?(package: XMLElement) {
        let opfNamespace = ["opf": "http://www.idpf.org/2007/opf"]
        guard let metadata = package.at_xpath("opf:metadata", namespaces: opfNamespace) else { return nil }
        // DCMES
        let dcNamespace = ["dc": "http://purl.org/dc/elements/1.1/"]
        let dcmes = metadata.xpath("dc:*", namespaces: dcNamespace)
        for dc in dcmes {
            guard let text = dc.text else { continue }
            switch dc.tagName {
            case "identifier":
                identifiers.append(text)
            case "title":
                titles.append(text)
            case "language":
                languages.append(text)
            case "creator":
                creators.append(text)
            case "date":
                date = text
            case "publisher":
                publisher = text
            default:
                break
            }
        }
    }
}
