//
//  JSONFromDAFFIF.swift
//  DAFIF_CLI
//
//  Created by Matthew Elmore on 5/4/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation

struct JSONFromDAFFIF {
    
    private var fileName: URL!
    public var headerDecoders: [String] = []
    public var bodySampleDecoder: [String] = []
    public var json: Data?
    public var printableJson: String?
    public var jsonFileName: String?
    private let fileManager: FileManager
    private let documentsDirectory: URL
    private var jsonOnly: Bool
    
    
    init(fileName: URL,
         writeToFile: Bool,
         jsonOnly: Bool,
         documentsDirectory: URL) {
        self.jsonOnly = jsonOnly
        self.fileName = fileName
        fileManager = FileManager.default
        self.documentsDirectory = documentsDirectory
        let json = makeJson()
        self.json = json.json
        self.printableJson = json.printableJson
        if writeToFile {
            if let validData = self.json {
                self.writeJsonToFile(json: validData)
            }}}
    
    private func getFileNamed(_ filename: URL) -> String {
        var result = ""
        do {
            let fileUrl: URL = filename
            let data = try Data(contentsOf: fileUrl)
            result = String(decoding: data, as: UTF8.self)
        } catch {
            print(error)
        }
        return result
    }

    private func removeCarriageReturn(_ a: [String]) -> [String] {
        var result: [String] = []
        for i in a {
            var placeHolder = ""
            if i.contains("\r") {
                placeHolder = i.replacingOccurrences(of: "\r", with: "")
            } else {
                placeHolder = i
            }
            result.append(placeHolder)
        }
        return result
    }
    
    private mutating func getDAFFIFDict(fileName: URL) -> (headers: [String], body: [[String]]) {
        let completeArrayDFFIF = getFileNamed(fileName).components(separatedBy: "\n")
        var headers: [String] = []
        var body: [[String]] = []
        let end = completeArrayDFFIF.count - 1
        for i in 0...end {
            switch i {
            case 0:
                headers = removeCarriageReturn(completeArrayDFFIF[i].components(separatedBy: "\t"))
            case 1:
                let bodyRow = removeCarriageReturn(completeArrayDFFIF[i].components(separatedBy: "\t"))
                self.bodySampleDecoder = bodyRow
                body.append(bodyRow)
            default:
                switch self.jsonOnly {
                case true:
                    let bodyRow = removeCarriageReturn(completeArrayDFFIF[i].components(separatedBy: "\t"))
                    body.append(bodyRow)
                case false:
                    break
                }
                
            }}
        return (headers: headers, body: body)
    }
    
    
    private func makeJsonReadyDictDaffif(headers: [String], body: [[String]]) -> [[String: String]]{
        var result: [[String: String]] = []
        for b in body {
            var tempDict: [String:String] = [:]
            for i in 0...(b.count - 1) {
                tempDict[headers[i]] = b[i]
            }
            result.append(tempDict)
        }
        return result
    }
    
    private mutating func makeJson() -> (json: Data?, printableJson: String?)  {
        var result: Data?
        var printableJson: String?
        let x = getDAFFIFDict(fileName: self.fileName)
        self.headerDecoders = x.headers
        let json = makeJsonReadyDictDaffif(headers: x.headers, body: x.body)
        if JSONSerialization.isValidJSONObject(json) {
            if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                result = data
                printableJson = String(decoding: data, as: UTF8.self)
        }}
        return (json: result, printableJson: printableJson)
    }
    
    ///This function creates the JSON files from the DAFIF8 text files.
    public mutating func writeJsonToFile(json: Data) {
        let jsonFileName: String = {
            let folderStruct = self.fileName.pathComponents
            let n = folderStruct.count - 1
            let folder = folderStruct[n - 1]
            let lastC = folderStruct[n].replacingOccurrences(of: ".TXT", with: ".json")
            return "\(folder)_\(lastC)"
        }()
        let urlName = documentsDirectory.appendingPathComponent("DAFIF_JSON/\(jsonFileName)")
        self.jsonFileName = jsonFileName//"\(documentsDirectory).appendingPathComponent(\"DAFIF_JSON/\(jsonFileName)\")"
        let myData = json
        switch self.jsonOnly {
        case true:
            do {
                try myData.write(to: urlName, options: .atomic)
            } catch {
                print(error)
            }
        case false:
            break
            
        }
    }
    
}

