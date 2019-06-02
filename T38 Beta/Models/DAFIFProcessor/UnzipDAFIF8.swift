//
//  UnzipDAFIF8.swift
//  unZip
//
//  Created by Matthew Elmore on 5/9/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation
import Zip


class UnzipDAFIF8 {
    
    private var wantedData: [FileNames]?
    private let fileManager: FileManager
    private let documentsDirectory: URL
    private var jsonOnly: Bool
    
    init(documentsDirectory: URL,
         jsonOnly: Bool) {
        fileManager = FileManager.default
        self.jsonOnly = jsonOnly
        self.documentsDirectory = documentsDirectory
    }
    
    init(wantedData: [FileNames]?,
         documentsDirectory: URL,
         jsonOnly: Bool) {
        self.wantedData = wantedData
        fileManager = FileManager.default
        self.documentsDirectory = documentsDirectory
        self.jsonOnly = jsonOnly
    }
    
    public func getContentsOf(_ folder: FolderLoc, wantedData: [FileNames]?) -> [URL] {
        let wantedData = wantedData?.returnRawValues()
        var allFileUrls: [URL] = []
        switch folder {
        case .dafif8:
            do {
                let unzippedFolder = documentsDirectory.appendingPathComponent("DAFIF8")
                let subFolders = try fileManager.contentsOfDirectory(at: unzippedFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                for urlFolder in subFolders {
                    allFileUrls.append(urlFolder)
                }} catch {print("You boys like MEHEECOO!!!")}
        case .dafift:
            do {
                let unzippedFolder = documentsDirectory.appendingPathComponent("DAFIFT")
                let subFolders = try fileManager.contentsOfDirectory(at: unzippedFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                for subFolder in subFolders {
                    let fileUrls = try fileManager.contentsOfDirectory(at: subFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                    for fileUrl in fileUrls {
                        if fileUrl.lastPathComponent.contains(".TXT") {
                            //THANKS NGA!! Turds named files the same in subfolders so I had to filter out the helicopter files here.
                            if let fileUrl = fileUrl.filterOutURLThatContainsComponentOf("SUPPH")?.filterOutURLThatContainsComponentOf("TRMH") {
                                if wantedData == nil {
                                    allFileUrls.append(fileUrl)
                                } else {
                                    if wantedData!.contains(fileUrl.lastPathComponent) {
                                        allFileUrls.append(fileUrl)
                                    }}}}}}} catch {print("Do you see me jumpin around all nimbly bimbly?!")}
        case .json:
            do {
                let unzippedFolder = documentsDirectory.appendingPathComponent("DAFIF_JSON")
                let files = try fileManager.contentsOfDirectory(at: unzippedFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                for file in files {
                    if file.lastPathComponent.contains(".json") {
                        allFileUrls.append(file)
                    }}} catch {print("Baby, Imma butter your bread")}}
        return allFileUrls
    }
    
    public func unZipDAFIF8() {
        do {
            let dafif8 = documentsDirectory.appendingPathComponent("DAFIF8").appendingPathExtension("zip")
            let dafift = documentsDirectory.appendingPathComponent("DAFIF8/DAFIFT").appendingPathExtension("zip")
            _ = try Zip.unzipFile(dafif8, destination: documentsDirectory.appendingPathComponent("DAFIF8"), overwrite: true, password: nil)
            _ = try Zip.unzipFile(dafift, destination: documentsDirectory, overwrite: true, password: nil)
        } catch {
            print("He's already pulled over, he can't pull over anymore")
        }}
    
    ///This function creates the folder structure to load all of the resulting files.
    public func createFolderStructer() {
        do {
            try fileManager.createDirectory(at: self.documentsDirectory.appendingPathComponent("DAFIF_JSON/SwiftDecoders"), withIntermediateDirectories: true, attributes: nil)
            try fileManager.createDirectory(at: self.documentsDirectory.appendingPathComponent("DAFIF_JSON/CoreDataXml"), withIntermediateDirectories: true, attributes: nil)
            try fileManager.createDirectory(at: self.documentsDirectory.appendingPathComponent("DAFIF_JSON/SwiftCoreDataUtilities"), withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
    }
}
