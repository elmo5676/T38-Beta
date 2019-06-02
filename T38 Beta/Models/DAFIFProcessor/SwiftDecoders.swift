//
//  SwiftDecoders.swift
//  unZip
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation


struct SwiftDecoders {
    
    private var fileName: URL!
    private var headerDecoders: [String]
    private var bodySampleDecoder: [String]
    private var documentsDirectory: URL
    
    
    init(fileName: URL,
         headerDecoders: [String],
         bodySampleDecoder: [String],
         documentsDirectory: URL) {
        self.fileName = fileName
        self.headerDecoders = headerDecoders
        self.bodySampleDecoder = bodySampleDecoder
        self.documentsDirectory = documentsDirectory
        createSwiftDecoders()
    }
    
    
    //This function creates the Swift decoders to assist in loading the JSON into CoreData.
    private func createSwiftDecoders() {
        let fileName = self.fileName.lastPathComponent
        let swiftFileName = fileName.replacingOccurrences(of: ".TXT", with: "").camelCased(with: "_").capitalizingFirstLetter().appending(".swift")
        let structName = fileName.replacingOccurrences(of: ".TXT", with: "").camelCased(with: "_").capitalizingFirstLetter()
        let urlName = documentsDirectory.appendingPathComponent("DAFIF_JSON/SwiftDecoders/\(swiftFileName)")
        var properties = ""
        var codingKeys = ""
        if self.bodySampleDecoder.count > 1 {
            for i in 0...self.headerDecoders.count - 1 {
                var type = "String?"
                var swiftyHeader = self.headerDecoders[i].camelCased(with: "_")
                if swiftyHeader == "class" { swiftyHeader = "classs"}
                if Double(bodySampleDecoder[i]) != nil {
                    type = "Double?"
                } else {
                    type = "String?"
                }
                properties += "\tlet \(swiftyHeader): \(type) \r"
                codingKeys += "\t\tcase \(swiftyHeader) = \"\(self.headerDecoders[i])\"\r"
            }}
        var swiftFileContent = """
        
        import Foundation
        \r
        struct \(structName): Codable {
        \(properties)
        \r
        \r
        \tenum CodingKeys: String, CodingKey {
        \(codingKeys)
        }
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
