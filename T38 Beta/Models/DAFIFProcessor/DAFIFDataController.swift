//
//  DAFIFDataController.swift
//  unZip
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation
import UIKit


protocol JSONLoaderDelagate {
    ///This is where you put your CoreData handlers
    func loadJSONafterDownloadedAndProcessed()
}


struct DAFIFDataController {
    
    private var wantedData: [FileNames]?
    private var jsonOnly: Bool
    private var coreDataModelName: String
    public var documentsDirectory = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!
    public var jsonLoaderDelegate: JSONLoaderDelagate?
    private let fileManager = FileManager.default
    
    
    
    init(wantedData: [FileNames]?,
         coreDataModelName: String) {
        self.wantedData = wantedData
        self.jsonOnly = true
        self.coreDataModelName = coreDataModelName
    }
    
    
    mutating func handleDAFIF() {
        _ = DAFIFDownloader(myDocuments: documentsDirectory, wantedData: wantedData, completion: whenDownloadCompleteJSONOnly)
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
