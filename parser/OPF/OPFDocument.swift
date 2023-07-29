//
//  OPFDocument.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 28.03.23.
//

import Kanna

struct OPFDocument {
    let metadata: OPFMetadata
    let manifest: OPFManifest
    let spine: OPFSpine
    let resource: Resource
    // Other elements, like collection, guide, etc.
    let document: XMLDocument

    init?(url: URL) {
        do {
            // Get the OPF XMLDocument
            document = try Kanna.XML(url: url, encoding: .utf8)
            // Create namespace for the 'package' element
            let opfNamespace = ["opf": "http://www.idpf.org/2007/opf"]
            // Execute XPath query to fetch the 'package' element
            guard let package = document.at_xpath("/opf:package", namespaces: opfNamespace) else { return nil }
            // Parse the three main elements
            guard let metadata = OPFMetadata(package: package) else { return nil }
            guard let manifest = OPFManifest(package: package) else { return nil }
            guard let spine = OPFSpine(package: package) else { return nil }
            guard let resource = Resource(manifest: manifest) else { return nil }
            self.metadata = metadata
            self.manifest = manifest
            self.spine = spine
            self.resource = resource
        } catch {
            print("Parsing the XML file at \(url) failed with error: \(error)")
            return nil
        }
    }
}
