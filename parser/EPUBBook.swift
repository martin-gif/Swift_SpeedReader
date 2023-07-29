//
//  EPUBBook.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 28.03.23.
//

import Foundation

class EPUBBook {
    let container: ContainerDocument
    let opf: OPFDocument
    let baseURLofBook: URL
    
    
    init?(contentsOf baseURL: URL) {
        self.baseURLofBook = baseURL
        // Find the location of container.xml
        let containerURL = baseURL.appendingPathComponent("META-INF/container.xml")
        // Parse the container file
        guard let container = ContainerDocument(url: containerURL) else {
            print("container couldnt be loaded")
            return nil }
        self.container = container
        // Get the location of the OPF file
        let opfURL = baseURL.appendingPathComponent(container.opfPath)
        guard let opf = OPFDocument(url: opfURL) else { return nil }
        
        
        //find and safe all xhtml files
        let subfileURL = baseURL.appending(path: "OEBPS/")
        opf.resource.loadText(url: subfileURL)
        
        self.opf = opf
    }
    func wordCounter(eingabe: String) -> Int {
        let words =  eingabe.split { !$0.isLetter }
        return words.count
    }
    
    func getBook() -> Book{
        
        let name = opf.metadata.titles[0]
        let loaction = baseURLofBook.absoluteString
        let coverURL = getCover()?.absoluteString 
        var text = String("")
        for chapter in opf.spine.idrefs{
            text.append(opf.resource.findById(chapter)?.text ?? "")
            //print(opf.resource.findById(chapter)?.text ?? "")
            //print(wordCounter(eingabe:  opf.resource.findById(chapter)?.text ?? ""))
        }
        print(wordCounter(eingabe: text))
        return Book(location: loaction ,name: name,cover: coverURL ,text: text)
    }
    
    func getCover() -> URL?{
        //let regex = try! NSRegularExpression(pattern: ".*(?i:c)over.*/.(jpg|jpeg|png)")
        
        let enumerator = FileManager.default.enumerator(at: baseURLofBook, includingPropertiesForKeys: [])
        let filePath = enumerator?.allObjects as! [URL]
        
        for dataFile in filePath{
            if (dataFile.lastPathComponent.range(of: ".*(?i:c)over.*\\.(jpg|jpeg|png)", options: .regularExpression) != nil){
                print(dataFile.lastPathComponent)
                return dataFile
            }
        }
        return nil
    }
}
