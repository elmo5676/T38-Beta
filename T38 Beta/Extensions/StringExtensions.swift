//
//  StringExtensions.swift
//  T38
//
//  Created by elmo on 5/27/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
    
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "." //checks for localization
        
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            
            let digits = split.count == 2 ? split.last ?? "" : ""
            return digits.count <= maxDecimalPlaces
        }
        
        return false
    }
    
    func boolToYesNo() -> String {
            var result = ""
            if self == "0" {
                result = "No"
            } else if self == "1" {
                result = "Yes"
            }
            return result
    }
    
    
    func latitudeStringToDouble() -> Double {
        var lat = 0.0
        var a = self.split(separator: "-")
        let b = Double(a[0])!
        let c = Double(a[1])!/60.0
        let d = a[2]
        if d.contains("N") {
            let e = d.replacingOccurrences(of: "N", with: "")
            let f = Double(e)!/3600
            lat = b + c + f
        } else if d.contains("S") {
            let e = d.replacingOccurrences(of: "S", with: "")
            let f = Double(e)!/3600
            lat = -1 * (b + c + f)
        }
        return lat
    }
    func longitudeStringToDouble() -> Double {
        var long = 0.0
        var a = self.split(separator: "-")
        let b = Double(a[0])!
        let c = Double(a[1])!/60.0
        let d = a[2]
        if d.contains("E") {
            let e = d.replacingOccurrences(of: "E", with: "")
            let f = Double(e)!/3600
            long = b + c + f
        } else if d.contains("W") {
            let e = d.replacingOccurrences(of: "W", with: "")
            let f = Double(e)!/3600
            long = -1 * (b + c + f)
        }
        return long
    }
    
    // MARK: Coordinate Translator
    func coordinateTranslate() -> [Double] {
        let coordInput = self
        let coords = coordInput.capitalized
        var coordsArray = coords.components(separatedBy: "/")
        var lattitude: Double = 0.0
        var longitude = 0.0
        if coordsArray[0].range(of: "N") != nil {
            let lattitudeString = String(coordsArray[0].dropLast())
            lattitude = Double(lattitudeString)!
        } else {
            let lattitudeString = String(coordsArray[0].dropLast())
            lattitude = -1 * Double(lattitudeString)!
        }
        if coordsArray[1].range(of: "W") != nil {
            let longitudeString = String(coordsArray[1].dropLast())
            longitude = -1 * Double(longitudeString)!
        } else {
            let longitudeString = String(coordsArray[1].dropLast())
            longitude = Double(longitudeString)!
        }
        let coordCalculatedArray: Array = [lattitude,longitude]
        return coordCalculatedArray
    }
    // MARK: A Better Coordinate Translator
    /*
     It can handle all of the following formats and returns an Array of Doubles
     [latitude, longitude]
     // MARK: DD°MM.dd
     "S3743.15/W12123.15"
     "s3743.15/w12123.15"
     "3743.15N/12123.15W"
     "3743.15n/12123.15w"
     "3743.15/-12123.15"
     "N3743.15 W12123.15"
     "n3743.15 w12123.15"
     "3743.15N 12123.15W"
     "3743.15n 12123.15w"
     "-3743.15 -12123.15"
     
     // MARK: DD.dddd
     "N37.4315/e121.2315"
     "s37.4315/w121.2315"
     "37.4315N/121.2315W"
     "37.4315n/121.2315w"
     "37.4315/-121.2315"
     "N37.4315 W121.2315"
     "n37.4315 w121.2315"
     "37.4315N 121.2315W"
     "37.4315n 121.2315w"
     "-37.4315 -121.2315"
     
     
     The following formats are acceptable:
     NDD°MM.dd/WDDD°MM.dd
     DD°MM.ddN/DDD°MM.ddW
     nDD°MM.dd/wDDD°MM.dd
     DD°MM.ddn/DDD°MM.ddw
     -DD°MM.dd/-DDD°MM.dd
     
     NDD°MM.dd WDDD°MM.dd
     DD°MM.ddN DDD°MM.ddW
     nDD°MM.dd wDDD°MM.dd
     DD°MM.ddn DDD°MM.ddw
     -DD°MM.dd -DDD°MM.dd
     
     NDD.dddd/WDDD.dddd
     DD.ddddN/DDD.ddddW
     nDD.dddd/wDDD.dddd
     DD.ddddn/DDD.ddddw
     -DD.dddd/-DDD.dddd
     
     NDD.dddd WDDD.dddd
     DD.ddddN DDD.ddddW
     nDD.dddd wDDD.dddd
     DD.ddddn DDD.ddddw
     -DD.dddd -DDD.dddd
     */
    func coordTranslate() -> [Double] {
        let coords = self
        let latDouble: Double
        let longDouble: Double
        var coordArray = [Double]()
        func coordLatConvert(coord: Double) -> Double {
            var result = 0.0
            if coord < 0.0 {
                if abs(coord) > 90.0 {
                    let degrees = floor(abs(coord/100))
                    let decimalDegrees = coord.truncatingRemainder(dividingBy: 100.0)/60.0 * -1
                    result = (degrees + decimalDegrees) * -1
                } else {
                    result = coord
                }
            } else {
                if abs(coord) > 90.0 {
                    let degrees = floor(coord/100)
                    let decimalDegrees = coord.truncatingRemainder(dividingBy: 100.0)/60.0
                    result = degrees + decimalDegrees
                } else {
                    result = coord
                }
            }
            return result
        }
        func coordLongConvert(coord: Double) -> Double {
            var result = 0.0
            if coord < 0.0 {
                if abs(coord) > 180.0 {
                    let degrees = floor(abs(coord)/100)
                    let decimalDegrees = coord.truncatingRemainder(dividingBy: 100.0)/60.0 * -1
                    result = (degrees + decimalDegrees) * -1
                } else {
                    result = coord
                }
            } else {
                if abs(coord) > 180.0 {
                    let degrees = floor(abs(coord)/100)
                    let decimalDegrees = coord.truncatingRemainder(dividingBy: 100.0)/60.0
                    result = degrees + decimalDegrees
                } else {
                    result = coord
                }
            }
            return result
        }
        if coords.contains("/") {
            let latString = coords.split(separator: "/")[0].uppercased()
            if latString.contains("N") {
                latDouble = Double(latString.replacingOccurrences(of: "N", with: ""))!
                coordArray.append(coordLatConvert(coord: latDouble))
            } else if latString.contains("S") {
                latDouble = Double(latString.replacingOccurrences(of: "S", with: ""))!
                coordArray.append(coordLatConvert(coord: latDouble) * (-1))
            } else {
                latDouble = Double(String(latString))!
                coordArray.append(coordLatConvert(coord: latDouble))
            }
            
            let longString = coords.split(separator: "/")[1].uppercased()
            if longString.contains("E") {
                longDouble = Double(longString.replacingOccurrences(of: "E", with: ""))!
                coordArray.append(coordLongConvert(coord: longDouble))
            } else if longString.contains("W") {
                longDouble = Double(longString.replacingOccurrences(of: "W", with: ""))!
                coordArray.append(coordLongConvert(coord: longDouble) * (-1))
            } else {
                longDouble = Double(String(longString))!
                coordArray.append(coordLongConvert(coord: longDouble))
            }
        } else if coords.contains(" ") {
            let latString = coords.split(separator: " ")[0].uppercased()
            if latString.contains("N") {
                latDouble = Double(latString.replacingOccurrences(of: "N", with: ""))!
                coordArray.append(coordLatConvert(coord: latDouble))
            } else if latString.contains("S") {
                latDouble = Double(latString.replacingOccurrences(of: "S", with: ""))!
                coordArray.append(coordLatConvert(coord: latDouble) * (-1))
            } else {
                latDouble = Double(String(latString))!
                coordArray.append(coordLatConvert(coord: latDouble))
            }
            
            let longString = coords.split(separator: " ")[1].uppercased()
            if longString.contains("E") {
                longDouble = Double(longString.replacingOccurrences(of: "E", with: ""))!
                coordArray.append(coordLongConvert(coord: longDouble))
            } else if longString.contains("W") {
                longDouble = Double(longString.replacingOccurrences(of: "W", with: ""))!
                coordArray.append(coordLongConvert(coord: longDouble) * (-1))
            } else {
                longDouble = Double(String(longString))!
                coordArray.append(coordLongConvert(coord: longDouble))
            }
        } else {
            //Insert Alert Here for improper format
            print("nope")
        }
        print(coordArray)
        return coordArray
    }
    
    func jsonCoordProcessing() -> String {
        let coordInput = self
        var coords = ""
        var coordPartArray = coordInput.components(separatedBy: "-")
        let DD = Double(coordPartArray[0])
        let MM = Double(coordPartArray[1])!/60
        let SS = Double(coordPartArray[2].dropLast())!/60/100
        let NSEW = coordPartArray[2].removeLast()
        let DDmmss = "\(NSEW)\(String(DD! + MM + SS))"
        coords = "\(DDmmss)"
        print(coords)
        return coords
    }
    
    func importFlightPlanFromForeflight() -> [String:String] {
        let clipBaord = "Clip Board"
        var importAll = [String:String]()
        let foreflightFlightPlan = self
        var latLong = foreflightFlightPlan.split(separator: " ")
        let positionOfFFAltitudeString = latLong.count - 1
        latLong.remove(at: positionOfFFAltitudeString)
        var coordString = ""
        for latlongs in latLong {
            let x = String(latlongs)
            let lat = x.coordTranslate()[0]
            let long = x.coordTranslate()[1]
            coordString += "\(long),\(lat),500\r"
        }
        importAll[clipBaord] = coordString
        return importAll
    }
}
