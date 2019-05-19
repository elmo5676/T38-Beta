//
//  TafParser.swift
//  T38
//
//  Created by Matthew Elmore on 4/7/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

class TafParser: NSObject, XMLParserDelegate {
    private let taf = TafField.tafMain.rawValue
    private let tafKeys = TafField.allCases.map { $0.rawValue }
    private var results: [[String: String]]?
    private var currentTaf: [String: String]?
    private var currentValue: String?
    var tafs: [Taf] = []
    
    convenience init(data: Data) {
        self.init()
        let parser = XMLParser(data: data)
        parser.delegate = self
        let success = parser.parse()
        print("Parsing was Successful: \(success)")
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        results = []
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == taf {
            currentTaf = [:]
        } else if tafKeys.contains(elementName) {
            currentValue = ""
        }}
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue? += string
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == taf {
            results!.append(currentTaf!)
            currentTaf = nil
        } else if tafKeys.contains(elementName) {
            currentTaf![elementName] = currentValue
            currentValue = nil
        }}
    
    func parserDidEndDocument(_ parser: XMLParser) {
        if let resultTafs = results {
            for taf in resultTafs {
                let wx = Taf(rawText: taf[TafField.rawText.rawValue],
                             stationId: taf[TafField.stationId.rawValue],
                             issueTime: taf[TafField.issueTime.rawValue],
                             bulletinTime: taf[TafField.bulletinTime.rawValue],
                             validTimeFrom: taf[TafField.validTimeFrom.rawValue],
                             validTimeTo: taf[TafField.validTimeTo.rawValue],
                             remarks: taf[TafField.remarks.rawValue],
                             latitude: taf[TafField.latitude.rawValue],
                             longitude: taf[TafField.longitude.rawValue],
                             elevationM: taf[TafField.elevationM.rawValue],
                             forecast: taf[TafField.forecast.rawValue],
                             timeFrom: taf[TafField.timeFrom.rawValue],
                             timeTo: taf[TafField.timeTo.rawValue],
                             changeIndicator: taf[TafField.changeIndicator.rawValue],
                             timeBecoming: taf[TafField.timeBecoming.rawValue],
                             probability: taf[TafField.probability.rawValue],
                             windDirDegrees: taf[TafField.windDirDegrees.rawValue],
                             windSpeedKts: taf[TafField.windSpeedKts.rawValue],
                             windGustKts: taf[TafField.windGustKts.rawValue],
                             windShearHeightAboveGroundFt: taf[TafField.windShearHeightAboveGroundFt.rawValue],
                             windShearDirDegrees: taf[TafField.windShearDirDegrees.rawValue],
                             windShearSpeedKts: taf[TafField.windShearSpeedKts.rawValue],
                             visibilityStatuteMiles: taf[TafField.visibilityStatuteMiles.rawValue],
                             altimeterInHg: taf[TafField.altimeterInHg.rawValue],
                             vertVisFt: taf[TafField.vertVisFt.rawValue],
                             weatherString: taf[TafField.weatherString.rawValue],
                             notDecoded: taf[TafField.notDecoded.rawValue],
                             skyCondition: taf[TafField.skyCondition.rawValue],
                             turbulanceCondition: taf[TafField.turbulanceCondition.rawValue],
                             icingCondition: taf[TafField.icingCondition.rawValue],
                             temperature: taf[TafField.temperature.rawValue],
                             validTime: taf[TafField.validTime.rawValue],
                             surfaceTempC: taf[TafField.surfcaeTempC.rawValue],
                             maxTempC: taf[TafField.maxTempC.rawValue],
                             minTempC: taf[TafField.minTempC.rawValue])
                tafs.append(wx)
            }}}
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        currentValue = nil
        currentTaf = nil
        results = nil
    }
}
