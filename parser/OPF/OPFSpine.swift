//
//  OPFSpine.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 28.03.23.
//

import Kanna

struct OPFSpine {
    private(set) var idrefs = [String]()

    init?(package: XMLElement) {
        guard let spine = package.at_xpath("opf:spine", namespaces: XPath.opf.namespace) else { return nil }
        idrefs = spine.xpath("opf:itemref[@idref]/@idref", namespaces: XPath.opf.namespace)
                      .map { $0.text }
                      .compactMap { $0 }
    }
}
