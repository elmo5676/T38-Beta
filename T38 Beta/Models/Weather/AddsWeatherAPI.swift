//
//  AddsWeatherAPI.swift
//  T38
//
//  Created by Matthew Elmore on 4/7/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit


// MARK: - NOTES:
//Main Page: https://www.aviationweather.gov/dataserver
//MainQueryUrl: https://www.aviationweather.gov/adds/dataserver_current/httpparam?
//METARS
//Explination of fields: https://www.aviationweather.gov/dataserver/fields?datatype=metar
//dataSource=metars&requestType=retrieve&format=xml&hoursBeforeNow=2&stationString=\(icao)
//
//TAF
//Explination of fields: https://www.aviationweather.gov/dataserver/fields?datatype=taf
//https://www.aviationweather.gov/adds/dataserver_current/httpparam?
//datasource=tafs&requesttype=retrieve&format=xml&startTime=1553272955&endTime=1553276555&stationString=\(icao)

struct AddsWeatherAPI {
    private static let baseURLString = "https://www.aviationweather.gov/adds/dataserver_current/httpparam?"
    private static let apiKey = "___"
    enum EndPoint {
        case metar
        case taf
    }
    static func weatherURL(type: EndPoint,
                           icao: String,
                           parameters: [String: String]?) -> URL {
        
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        var baseParams: [String: String] = [:]
        switch type {
        case .metar:
            baseParams = [
                "dataSource"    : "metars",
                "requestType"   : "retrieve",
                "format"        : "xml",
                "hoursBeforeNow": "2",
                "stationString" : icao
            ]
        case .taf:
            baseParams = [
                "dataSource"    : "tafs",
                "requestType"   : "retrieve",
                "format"        : "xml",
                "startTime"     : "1553270000",
                "endTime"       : "1553270000",
                "stationString" : icao
            ]
        }
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }}
        components.queryItems = queryItems
        return components.url!
    }
}
