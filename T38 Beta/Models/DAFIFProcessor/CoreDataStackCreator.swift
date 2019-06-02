//
//  CoreDataStackCreator.swift
//  DAFIFtoCoreData
//
//  Created by Matthew Elmore on 5/22/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation


struct CoreDataStackCreator {
    
    private var documentsDirectory: URL
    private var coreDataModelName: String
    
    
    init(documentsDirectory: URL,
        coreDataModelName: String) {
        self.documentsDirectory = documentsDirectory
        self.coreDataModelName = coreDataModelName
        createJSONtoCoreDataLoaders()
    }
    
    private func createJSONtoCoreDataLoaders() {
        let urlName = documentsDirectory.appendingPathComponent("DAFIF_JSON/\(coreDataModelName)CDStack.swift")
        
        var swiftFileContent = """
        import Foundation
        import CoreData
        \r
        \r
        struct \(coreDataModelName)CDStack {
        \r
        \t// MARK: - Core Data stack
        \tlazy var persistentContainer: NSPersistentContainer = {
        \r
        \t\tlet container = NSPersistentContainer(name: "\(coreDataModelName)")
        \t\tcontainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
        \t\t\tif let error = error as NSError? {
        \t\t\t\tfatalError("Unresolved error \\(error), \\(error.userInfo)")
        \t\t\t}
        \t\t})
        \t\treturn container
        \t}()
        \r
        \t// MARK: - Core Data Saving support
        \tmutating func saveContext () {
        \t\tlet context = persistentContainer.viewContext
        \t\tif context.hasChanges {
        \t\t\tdo {
        \t\t\t\ttry context.save()
        \t\t\t} catch {
        \t\t\t\tlet nserror = error as NSError
        \t\t\t\tfatalError("Unresolved error \\(nserror), \\(nserror.userInfo)")
        \t\t\t}}}
        \r
        }
        """
        let myData = Data(swiftFileContent.utf8)
        do {
            try myData.write(to: urlName, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    
}
