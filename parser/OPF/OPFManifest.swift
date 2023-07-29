//
//  OPFManifest.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 28.03.23.
//

import Kanna

struct OPFManifest {
    private(set) var items = [String: ManifestItem]()

    init?(package: XMLElement) {
        let opfNamespace = ["opf": "http://www.idpf.org/2007/opf"]
        guard let manifest = package.at_xpath("opf:manifest", namespaces: opfNamespace) else { return nil }
        let itemElements = manifest.xpath("opf:item", namespaces: opfNamespace)
        for itemElement in itemElements {
            guard let item = ManifestItem(itemElement) else { continue }
            items[item.id] = item
        }
    }
    
    func getAllItems() -> [String : ManifestItem] {
        return items
    }
    
    func getCoverItem() -> ManifestItem{
        return items["cover"]!
    }
}

public struct ManifestItem {
    let id: String
    let href: String
    let mediaType: String
    let properties: String?
    // Others like duration, fallback, etc.
    init?(_ item: XMLElement) {
        guard let itemId = item["id"] else { return nil }
        guard let itemHref = item["href"] else { return nil }
        guard let itemMediaType = item["media-type"] else { return nil }
        id = itemId
        href = itemHref
        mediaType = itemMediaType
        properties = item["properties"]
    }
}
