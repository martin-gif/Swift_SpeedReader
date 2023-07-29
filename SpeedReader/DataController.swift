//
//  DataController.swift
//  SpeedReader
//
//  Created by Marvin Raschke on 22.03.23.
//

import CoreData
import Foundation
/*
class DataController{
    static let shared = DataController()
    
    static var preview: DataController = {
        let result = DataController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            //let newBook = BookEntity(context: viewContext)
            //newBook.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false){
        let container = NSPersistentContainer(name: "Bookworm")
        
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: {
            (description, error) in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
}
 */
