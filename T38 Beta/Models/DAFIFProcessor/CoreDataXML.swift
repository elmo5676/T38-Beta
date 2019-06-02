//
//  CoreDataXML.swift
//  unZip
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation


struct CoreDataXML {
    
    var internalXML: String?
    private var documentsDirectory: URL
    
    init(fileName: URL,
         headerDecoders: [String],
         bodySampleDecoder: [String],
         documentsDirectory: URL) {
        self.documentsDirectory = documentsDirectory
        self.internalXML = internalCoreDataXML(fileName: fileName, headerDecoders: headerDecoders, bodySampleDecoder: bodySampleDecoder)
    }
    
    init(internalXML: String?,
        documentsDirectory: URL,
        coreDataModelName: String) {
        self.documentsDirectory = documentsDirectory
        createCoreDataModel(internalCoreDataXML: internalXML, coreDataModelName: coreDataModelName)
    }
    
    
    //This is a subfunction to create the internal XML for the CoreData model.
    private func internalCoreDataXML(fileName: URL,
                                    headerDecoders: [String],
                                    bodySampleDecoder: [String]) -> String {
        let fileName = fileName.lastPathComponent
        let entityElementName = fileName.camelCased(with: "_").capitalizingFirstLetter().replacingOccurrences(of: ".txt", with: "_CD").replacingOccurrences(of: ".Txt", with: "_CD")
        let entity = "\t<entity name=\"\(entityElementName)\" representedClassName=\".\(entityElementName)\" syncable=\"YES\">\r"
        var attribute = ""
        if bodySampleDecoder.count > 1 {
            for i in 0...headerDecoders.count - 1 {
                let swiftyAttribute = "\(headerDecoders[i].camelCased(with: "_"))_CD"
                var attributeType = "String"
                if Double(bodySampleDecoder[i]) != nil {
                    attributeType = "Decimal"
                }
                attribute += "\t\t<attribute name=\"\(swiftyAttribute)\" optional=\"YES\" attributeType=\"\(attributeType)\" />\r"
            }}
        return "\(entity)\(attribute)</entity>\r"
    }
    
//    syncable=\"YES\"
    
    public func createCoreDataModel(internalCoreDataXML: String?, coreDataModelName: String) {
        if let internalXML = internalCoreDataXML {
            let urlName = documentsDirectory.appendingPathComponent("DAFIF_JSON/CoreDataXml/contents")
            var CoreDataModel = """
            <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
            <model type="com.apple.IDECoreDataModeler.DataModel" documentVersion="1.0" lastSavedToolsVersion="14133" systemVersion="17E202" minimumToolsVersion="Automatic" sourceLanguage="Swift" userDefinedModelVersionIdentifier="">
            \(internalXML)
            </model>
            
            """
            let myData = Data(CoreDataModel.utf8)
            do {
                try myData.write(to: urlName, options: .atomic)
            } catch {
                print(error)
            }
            let fileManager = FileManager.default
            do {
                try fileManager.createDirectory(at: self.documentsDirectory.appendingPathComponent("DAFIF_JSON/1"), withIntermediateDirectories: true, attributes: nil)
                try fileManager.moveItem(at: documentsDirectory.appendingPathComponent("DAFIF_JSON/CoreDataXml"), to: documentsDirectory.appendingPathComponent("DAFIF_JSON/1/\(coreDataModelName).xcdatamodel"))
                try fileManager.moveItem(at: documentsDirectory.appendingPathComponent("DAFIF_JSON/1"), to: documentsDirectory.appendingPathComponent("DAFIF_JSON/\(coreDataModelName).xcdatamodeld"))
            } catch {
                print(error)
            }
        }
    }
    
}
