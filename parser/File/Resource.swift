//
//  Resource.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 30.03.23.
//

import Foundation
import SwiftSoup

class Resource{
    var resources = [String: singleResources]()
    var htmlToId = [String: String]()
    
    
    
    init?(manifest: OPFManifest){
        for item in manifest.items.values{
            self.resources[item.id] = singleResources(id: item.id, fullHref: item.href)
            self.htmlToId[item.href] = item.id
        }
    }
    
    func loadText(url: URL) {
        print("start file printing")
        let res = getFilesOfType(fileType: "xhtml", from: url)
        for item in res{
            print(item)
            guard let singleScr = findByHref(item.lastPathComponent) else{
                continue
            }
            singleScr.text = getDisplayedTextFromLocalHTMLFile(at: item)
        }
        print("end file printing")
    }
    
    func getFilesOfType(fileType: String, from url: URL) -> [URL] {
        var files = [URL]()
        let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [])
        let filePath = enumerator?.allObjects as! [URL]
        for dataFile in filePath{
            if (dataFile.pathExtension == fileType){
                files.append(dataFile)
                print(dataFile.pathExtension)
            }
        }
        return files
    }
    
    func getDisplayedTextFromLocalHTMLFile(at url: URL) -> String? {
        do {
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(htmlString)
                //print(doc)
                let bodyElements = doc.body()
            let displayedText = try getTextFromHTML((bodyElements?.children())!)
                //print(displayedText)
                return displayedText
            } catch {
                print("Error reading or parsing HTML file: \(error.localizedDescription)")
                return nil
            }
    }

    // hier letztes problem, das tag "<section>" gescannt wurde und dann nocheinmal alle subelemente wodurch text doppelt vorkamm 
    private func getTextFromHTML(_ elements: Elements) throws -> String {
        var displayedText = [String]()
        for element in elements {
            displayedText.append(try element.text())
            //print(try element.text())
        }
        return displayedText.joined(separator: " ")
    }
    

    
    func add(resource: singleResources){
        self.resources[resource.fullHref!] = resource
    }
    
    /**
     Gets the resource with the given href.
     */
    func findByHref(_ href: String) -> singleResources? {
        guard !href.isEmpty else { return nil }

        // This clean is neede because may the toc.ncx is not located in the root directory
        let cleanHref = href.replacingOccurrences(of: "../", with: "")
        
        return resources[htmlToId[href]!]
    }

    /**
     Gets the resource with the given href.
     */
    func findById(_ id: String?) -> singleResources? {
        guard let id = id else { return nil }

        for resource in resources.values {
            if let resourceID = resource.id, resourceID == id {
                return resource
            }
        }
        return nil
    }

    /**
     Whether there exists a resource with the given href.
     */
    func containsByHref(_ href: String) -> Bool {
        guard !href.isEmpty else { return false }

        return resources.keys.contains(href)
    }

    /**
     Whether there exists a resource with the given id.
     */
    func containsById(_ id: String?) -> Bool {
        guard let id = id else { return false }

        for resource in resources.values {
            if let resourceID = resource.id, resourceID == id {
                return true
            }
        }
        return false
    }
}
