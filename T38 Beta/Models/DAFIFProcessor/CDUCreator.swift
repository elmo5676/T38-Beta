//
//  CDUCreator.swift
//  unZip
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation

struct CDUCreator {
    
    private var fileName: URL!
    private var headerDecoders: [String]
    private var bodySampleDecoder: [String]
    private var documentsDirectory: URL
    
    
    init(fileName: URL,
         headerDecoders: [String],
         bodySampleDecoder: [String],
         jsonFileName: String?,
         documentsDirectory: URL) {
        self.fileName = fileName
        self.headerDecoders = headerDecoders
        self.bodySampleDecoder = bodySampleDecoder
        self.documentsDirectory = documentsDirectory
        createJSONtoCoreDataLoaders(jsonFileName: jsonFileName)
    }
    
    
    //This function creates the Swift decoders to assist in loading the JSON into CoreData.
    private func createJSONtoCoreDataLoaders(jsonFileName: String?) {
        guard let jsonFileName = jsonFileName else {return}
        let fileName = self.fileName.lastPathComponent
        let swiftFileName = fileName.replacingOccurrences(of: ".TXT", with: "_C_D_U").camelCased(with: "_").capitalizingFirstLetter().appending(".swift")
        let structName = fileName.replacingOccurrences(of: ".TXT", with: "").camelCased(with: "_").capitalizingFirstLetter()
        let entityName = "\(structName)_CD"
        let urlName = documentsDirectory.appendingPathComponent("DAFIF_JSON/SwiftCoreDataUtilities/\(swiftFileName)")
        var encoders = ""
        if self.bodySampleDecoder.count > 1 {
            for i in 0...self.headerDecoders.count - 1 {
                if Double(self.bodySampleDecoder[i]) != nil {
                    var swiftyHeader = self.headerDecoders[i].camelCased(with: "_")
                    if swiftyHeader == "class" { swiftyHeader = "classs"}
                    encoders += "\t\t\t\t\(entityName.lowerCaseFirstLetter())_DB.\(swiftyHeader)_CD = \(entityName.lowerCaseFirstLetter()).\(swiftyHeader) as? NSDecimalNumber\r"
                } else {
                    var swiftyHeader = self.headerDecoders[i].camelCased(with: "_")
                    if swiftyHeader == "class" { swiftyHeader = "classs"}
                    encoders += "\t\t\t\t\(entityName.lowerCaseFirstLetter())_DB.\(swiftyHeader)_CD = \(entityName.lowerCaseFirstLetter()).\(swiftyHeader)\r"
                }}}
        var swiftFileContent = """
                                \r
                                \r
                                import Foundation
                                import CoreData
                                \r
                                \r
                                struct \(structName)CDU {
                                \r
                                \r
                                \tfunc load\(structName)ToCDfromJSON(moc: NSManagedObjectContext){
                                \t\tlet decoder = JSONDecoder()
                                \t\tlet fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/\(jsonFileName)")
                                \r
                                \t\tdo {
                                \t\t\tlet results = try decoder.decode([\(structName)].self, from: Data(contentsOf: fileName))
                                \t\t\t_ = results.map { (\(entityName.lowerCaseFirstLetter())) -> \(entityName) in
                                \t\t\t\tlet \(entityName.lowerCaseFirstLetter())_DB = \(entityName)(context: moc)
                                \(encoders)
                                \t\t\t\treturn \(entityName.lowerCaseFirstLetter())_DB
                                \t\t\t}
                                \t\t\tmoc.performAndWait {
                                \t\t\t\tdo {
                                \t\t\t\t\ttry moc.save()
                                \t\t\t\t} catch {
                                \t\t\t\t\tprint(error)
                                \t\t\t\t}}
                                \t\t} catch {print(error)}
                                \t}
                                \r
                                \r
                                \tfunc delete\(entityName)FromDB(moc: NSManagedObjectContext) {
                                \t\tlet delete\(entityName) = NSBatchDeleteRequest(fetchRequest: \(entityName).fetchRequest())
                                \t\tdo {
                                \t\t\ttry moc.execute(delete\(entityName))
                                \t\t\ttry moc.save()
                                \t\t\tprint("All \(entityName) were succesfully deleted from CoreData")
                                \t\t} catch {
                                \t\t\tprint("Nope")
                                \t\t}
                                \t}
                                \r
                                \r
                                \tfunc getAll\(entityName)(moc: NSManagedObjectContext) -> [\(entityName)] {
                                \t\tvar \(entityName.lowerCaseFirstLetter()) = [\(entityName)]()
                                \t\tlet \(entityName.lowerCaseFirstLetter())FetchRequest = NSFetchRequest<\(entityName)>(entityName: "\(entityName)")
                                \t\tdo {
                                \t\t\t\(entityName.lowerCaseFirstLetter()) = try moc.fetch(\(entityName.lowerCaseFirstLetter())FetchRequest)
                                \t\t} catch {
                                \t\t\tprint(error)
                                \t\t}
                                \t\treturn \(entityName.lowerCaseFirstLetter())
                                \t}
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


