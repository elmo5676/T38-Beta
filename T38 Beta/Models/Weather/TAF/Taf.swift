//
//  Taf.swift
//  T38
//
//  Created by Matthew Elmore on 4/7/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import Foundation

public enum TafField: String, CaseIterable {
    case tafMain = "TAF"
    case rawText = "raw_text"
    case stationId = "station_id"
    case issueTime = "issue_time"
    case bulletinTime = "bulletin_time"
    case validTimeFrom = "valid_time_from"
    case validTimeTo = "valid_time_to"
    case remarks = "remarks"
    case latitude = "latitude"
    case longitude = "longitude"
    case elevationM = "elevation_m"
    case forecast = "forecast"
    case timeFrom = "time_from"
    case timeTo = "time_to"
    case changeIndicator = "change_indicator"
    case timeBecoming = "time_becoming"
    case probability = "probability"
    case windDirDegrees = "wind_dir_degrees"
    case windSpeedKts = "wind_speed_kt"
    case windGustKts = "wing_gust_kt"
    case windShearHeightAboveGroundFt = "wind_shear_hgt_ft_agl"
    case windShearDirDegrees = "wind_shear_dir_degrees"
    case windShearSpeedKts = "wind_shear_speed_kt"
    case visibilityStatuteMiles = "visibility_statute_mi"
    case altimeterInHg = "altim_in_hg"
    case vertVisFt = "vert_vis_ft"
    case weatherString = "wx_string"
    case notDecoded = "not_decoded"
    case skyCondition = "sky_condition"
    case turbulanceCondition = "turbulence_condition"
    case icingCondition = "icing_condition"
    case temperature = "temperature"
    case validTime = "valid_time"
    case surfcaeTempC = "sfc_temp_c"
    case maxTempC = "max_temp_c"
    case minTempC = "min_temp_c"
}
struct Taf {
    var rawText: String?
    var stationId: String?
    var issueTime: String?
    var bulletinTime: String?
    var validTimeFrom: String?
    var validTimeTo: String?
    var remarks: String?
    var latitude: String?
    var longitude: String?
    var elevationM: String?
    var forecast: String?
    var timeFrom: String?
    var timeTo: String?
    var changeIndicator: String?
    var timeBecoming: String?
    var probability: String?
    var windDirDegrees: String?
    var windSpeedKts: String?
    var windGustKts: String?
    var windShearHeightAboveGroundFt: String?
    var windShearDirDegrees: String?
    var windShearSpeedKts: String?
    var visibilityStatuteMiles: String?
    var altimeterInHg: String?
    var vertVisFt: String?
    var weatherString: String?
    var notDecoded: String?
    var skyCondition: String?
    var turbulanceCondition: String?
    var icingCondition: String?
    var temperature: String?
    var validTime: String?
    var surfaceTempC: String?
    var maxTempC: String?
    var minTempC: String?
    init(rawText: String?,
         stationId: String?,
         issueTime: String?,
         bulletinTime: String?,
         validTimeFrom: String?,
         validTimeTo: String?,
         remarks: String?,
         latitude: String?,
         longitude: String?,
         elevationM: String?,
         forecast: String?,
         timeFrom: String?,
         timeTo: String?,
         changeIndicator: String?,
         timeBecoming: String?,
         probability: String?,
         windDirDegrees: String?,
         windSpeedKts: String?,
         windGustKts: String?,
         windShearHeightAboveGroundFt: String?,
         windShearDirDegrees: String?,
         windShearSpeedKts: String?,
         visibilityStatuteMiles: String?,
         altimeterInHg: String?,
         vertVisFt: String?,
         weatherString: String?,
         notDecoded: String?,
         skyCondition: String?,
         turbulanceCondition: String?,
         icingCondition: String?,
         temperature: String?,
         validTime: String?,
         surfaceTempC: String?,
         maxTempC: String?,
         minTempC: String?) {
        self.rawText = rawText
        self.stationId = stationId
        self.issueTime = issueTime
        self.bulletinTime = bulletinTime
        self.validTimeFrom = validTimeFrom
        self.validTimeTo = validTimeTo
        self.remarks = remarks
        self.latitude = latitude
        self.longitude = longitude
        self.elevationM = elevationM
        self.forecast = forecast
        self.timeFrom = timeFrom
        self.timeTo = timeTo
        self.changeIndicator = changeIndicator
        self.timeBecoming = timeBecoming
        self.probability = probability
        self.windDirDegrees = windDirDegrees
        self.windSpeedKts = windSpeedKts
        self.windGustKts = windGustKts
        self.windShearHeightAboveGroundFt = windShearHeightAboveGroundFt
        self.windShearDirDegrees = windShearDirDegrees
        self.windShearSpeedKts = windShearSpeedKts
        self.visibilityStatuteMiles = visibilityStatuteMiles
        self.altimeterInHg = altimeterInHg
        self.vertVisFt = vertVisFt
        self.weatherString = weatherString
        self.notDecoded = notDecoded
        self.skyCondition = skyCondition
        self.turbulanceCondition = turbulanceCondition
        self.icingCondition = icingCondition
        self.temperature = temperature
        self.validTime = validTime
        self.surfaceTempC = surfaceTempC
        self.maxTempC = maxTempC
        self.minTempC = minTempC
    }
}
