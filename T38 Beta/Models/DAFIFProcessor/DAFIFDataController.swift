//
//  DAFIFDataController.swift
//  unZip
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation
import UIKit

///Added to be called after JSON is downloaded and processed. This is where you put your CoreData handlers
protocol JSONLoaderDelagate {
    func loadJSONafterDownloadedAndProcessed()

//    Below goes where you are going to load the JSON into CoreData, Same place that subscribes to JSONLoaderDelagate protocol
//    var moc: NSManagedObjectContext? {
//        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//    }
//    var dafif = DAFIFDataController(wantedData: wantedData, jsonOnly: false)
//    dafif.jsonLoaderDelegate = self
//    dafif.handleDAFIF()
    
}

/**
 DAFIFDataController: Can either be set up for the initial build of an application where it will create all of the CoreData
 and JSON processing files needed to handle the DAFIF or it can be set to process the DAFIF in the app for updates.
 
 Zip Framework:
 - Terminal:
 	- Navigate to folder containing .xcodeproj file
 	- touch Cartfile
 	- github "marmelroy/Zip"
 	- carthage update
 - Finder:
 	- drag and drop Zip framework into xcode: Target > General > Embedded Binaries"
 - Xcode:
 	- Build Phases > + Run Script Phase
 		- /usr/local/bin/carthage copy-frameworks
 		- + Input Files
        - $(SRCROOT)/Carthage/Build/iOS/Zip.framework
 */
struct DAFIFDataController {
    
    private var wantedData: [FileNames]?
    private var jsonOnly: Bool
    private var coreDataModelName: String
    public var documentsDirectory = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!
    public var jsonLoaderDelegate: JSONLoaderDelagate?
    private let fileManager = FileManager.default
    
    init(wantedData: [FileNames]?,
         jsonOnly: Bool,
         coreDataModelName: String) {
        self.wantedData = wantedData
        self.jsonOnly = jsonOnly
        self.coreDataModelName = coreDataModelName
    }
    
    
    mutating func handleDAFIF() {
        switch self.jsonOnly {
        case true:
            _ = DAFIFDownloader(myDocuments: documentsDirectory, wantedData: wantedData, completion: whenDownloadCompleteJSONOnly)
        case false:
            print("You can't do that on television!!")
        }
    }
    
    private func whenDownloadCompleteJSONOnly(wantedData: [FileNames]?) {
        let unZipper = UnzipDAFIF8(wantedData: wantedData, documentsDirectory: documentsDirectory, jsonOnly: jsonOnly)
        unZipper.createFolderStructer()
        unZipper.unZipDAFIF8()
        let listOfFileNames = unZipper.getContentsOf(.dafift, wantedData: wantedData)
        for file in listOfFileNames {
            _ = JSONFromDAFFIF(fileName: file, writeToFile: true, jsonOnly: self.jsonOnly, documentsDirectory: documentsDirectory)
        }
        jsonLoaderDelegate?.loadJSONafterDownloadedAndProcessed()
        cleanUpFolder()
    }
    
    private func whenDownloadCompleteHandleEverything(wantedData: [FileNames]?) {
        let unZipper = UnzipDAFIF8(wantedData: wantedData, documentsDirectory: documentsDirectory, jsonOnly: jsonOnly)
        unZipper.createFolderStructer()
        unZipper.unZipDAFIF8()
        let listOfFileNames = unZipper.getContentsOf(.dafift, wantedData: wantedData)
        var internalCoreDataXML = ""
        for file in listOfFileNames {
            let json = JSONFromDAFFIF(fileName: file, writeToFile: true, jsonOnly: self.jsonOnly, documentsDirectory: documentsDirectory)
            _ = SwiftDecoders(fileName: file, headerDecoders: json.headerDecoders, bodySampleDecoder: json.bodySampleDecoder, documentsDirectory: documentsDirectory)
            internalCoreDataXML += CoreDataXML(fileName: file, headerDecoders: json.headerDecoders, bodySampleDecoder: json.bodySampleDecoder, documentsDirectory: documentsDirectory).internalXML!
            _ = CDUCreator(fileName: file, headerDecoders: json.headerDecoders, bodySampleDecoder: json.bodySampleDecoder, jsonFileName: json.jsonFileName, documentsDirectory: documentsDirectory)
        }
        _ = CoreDataXML(internalXML: internalCoreDataXML, documentsDirectory: documentsDirectory, coreDataModelName: coreDataModelName)
        _ = CoreDataStackCreator(documentsDirectory: documentsDirectory, coreDataModelName: coreDataModelName)
        consolidateJson()
        
        }
    
    
    func consolidateJson() {
        do {
            let fileUrls = try fileManager.contentsOfDirectory(at: documentsDirectory.appendingPathComponent("DAFIF_JSON"), includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for fileUrl in fileUrls {
                if fileUrl.lastPathComponent.contains("json") {
                    try fileManager.removeItem(at: fileUrl)
            }}} catch {
                print(error)
            }}
    
    func cleanUpFolder() {
        do {
            try fileManager.removeItem(at: self.documentsDirectory.appendingPathComponent("DAFIF_JSON/SwiftDecoders"))
            try fileManager.removeItem(at: self.documentsDirectory.appendingPathComponent("DAFIF_JSON/CoreDataXml"))
            try fileManager.removeItem(at: self.documentsDirectory.appendingPathComponent("DAFIF_JSON/SwiftCoreDataUtilities"))
        } catch {
            print(error)
        }
    }
}
