//
//  FileManagerSingelton.swift
//  
//
//  Created by Marvin Raschke on 24.04.23.
//

import Foundation
import AppKit

class FileManagerSingelton {
    
    static let shared = FileManagerSingelton()
    private var url: URL
    private var fileManager: FileManager
    
    private init(){
        self.fileManager = FileManager.default
        self.url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path = UserDefaults.standard.url(forKey: "url")
        if (path == nil){
            print("use init Func for Location")
            let localUrl = initFolder()
            self.url = localUrl
            print(url)
        }
    }
    
    func getPath() -> URL{
        return url
    }
    
    func setPath(newUrl: URL){
        UserDefaults.standard.set(newUrl, forKey: "url")
    }
    
    func secureCopyItem(at srcURL: URL, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
        } catch (let error) {
            print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
            return false
        }
        return true
    }
    
    func initFolder() -> URL{
        var returnURL = self.url
        do {
            let rootFolderURL = try fileManager.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: false
                )
            print("rootFolder: ",rootFolderURL)
            let nestedFolderURL = rootFolderURL.appendingPathComponent("DocumentFolder")
            
            if !isDirectory(at: nestedFolderURL){
                try fileManager.createDirectory(
                    at: nestedFolderURL,
                    withIntermediateDirectories: false,
                    attributes: nil
                )
            }
            setPath(newUrl: nestedFolderURL)
            returnURL = nestedFolderURL
        }
        catch let error as NSError {
            print("Unable to create directory \(error.debugDescription)")
        }
        
        return returnURL
    }
    
    func createFolder(url: URL){
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
        }
        catch let error as NSError {
            print("Unable to create directory \(error.debugDescription)")
        }
    }
    
    func moveFolder(from: URL, to: URL){
        do {
            try fileManager.moveItem(at: from, to: to)
        }
        catch let error as NSError {
            print("Unable to move directory \(error.debugDescription)")
        }
    }
    
    func copyInAppFolder(from: URL) -> Result<URL,Error>{
        var newURL = self.url
        newURL = newURL.appendingPathComponent(from.lastPathComponent)
        do{
            if fileManager.fileExists(atPath: newURL.absoluteString){
                try fileManager.removeItem(at: newURL.absoluteURL)
            }
            try fileManager.moveItem(at: from, to: newURL)
            
            return .success(newURL)
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
    func isDirectory(at: URL) -> Bool {
        do {
            return (try at.resourceValues(forKeys: [.isDirectoryKey]).isDirectory ?? false)
        }
        catch let error as NSError {
            print("Unable to directory \(error.debugDescription)")
            return false
        }
    }
    
    func showInFinder(url: URL?) {
        guard let url = url else { return }
        
        if isDirectory(at: url) {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: url.path)
        } else {
            NSWorkspace.shared.activateFileViewerSelecting([url])
        }
    }
    
}
