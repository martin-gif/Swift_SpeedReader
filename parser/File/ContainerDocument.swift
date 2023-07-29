//
//  ContainerDocument.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 28.03.23.
//

import Kanna

struct ContainerDocument {
    let opfPath: String

    let document: XMLDocument

    init?(url: URL) {
        do {
            // Just one line to get the DOM document of a XML file
            document = try Kanna.XML(url: url, encoding: .utf8)
            // Create namespace for the 'container' element
            let namespace = ["ctn": "urn:oasis:names:tc:opendocument:xmlns:container"]
            // Our first XPath query
            let xpath = "//ctn:rootfile[@full-path]/@full-path"
            // Execute the XPath query by 'at_xpath'
            guard let path = document.at_xpath(xpath, namespaces: namespace)?.text else {
                print(XPath.container.namespace)
                print("path is nil")
                return nil
            }
            opfPath = path
            
        } catch {
            print("Parsing the XML file at \(url) failed with error: \(error)")
            return nil
        }
    }
}
