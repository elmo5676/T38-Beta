//
//  Metar.swift
//  T38
//
//  Created by Matthew Elmore on 4/7/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import Foundation

public enum MetarLoc {
    case home
    case nrst
    case icao
}

public enum MetarField: String, CaseIterable {
    case metarMain = "METAR"
    case rawText = "raw_text"
    case stationId = "station_id"
    case observationTime = "observation_time"
    case latitude = "latitude"
    case longitude = "longitude"
    case tempC = "temp_c"
    case dewPointC = "dewpoint_c"
    case windDirDegrees = "wind_dir_degrees"
    case windSpeedKts = "wind_speed_kt"
    case windGustKts = "wind_gust_kt"
    case visibilityStatuteMiles = "visibility_statute_mi"
    case altimeterInHg = "altim_in_hg"
    case seaLevelPressureMb = "sea_level_pressure_mb"
    case qualityControlFlags = "quality_control_flags"
    case wxString = "wx_string"
    case skyCondition = "sky_condition"
    case flightCategory = "flight_category"
    case threeHrPressureTendencyMb = "three_hr_pressure_tendency_mb"
    case maxTempPastSixHoursC = "maxT_c"
    case minTempPastSixHoursC = "minT_c"
    case maxTemp24HrC = "maxT24hr_c"
    case minTemp24HrC = "minT24hr_c"
    case precipIn = "precip_in"
    case precipLast3HoursIn = "pcp3hr_in"
    case precipLast6HoursIn = "pcp6hr_in"
    case precipLast24HoursIn = "pcp24hr_in"
    case snowIn = "snow_in"
    case vertVisFt = "vert_vis_ft"
    case metarType = "metar_type"
    case elevationM = "elevation_m"
}

struct Metar {
    var isNil: Bool = true
    var rawText: String?
    var stationId: String?
    var observationTime: String?
    var latitude: String?
    var longitude: String?
    var tempC: String?
    var dewPointC: String?
    var windDirDegrees: String?
    var windSpeedKts: String?
    var windGustKts: String?
    var visibilityStatuteMiles: String?
    var altimeterInHg: String?
    var seaLevelPressureMb: String?
    var qualityControlFlags: String?
    var wxString: String?
    var skyCondition: String?
    var flightCategory: String?
    var threeHrPressureTendencyMb: String?
    var maxTempPastSixHoursC: String?
    var minTempPastSixHoursC: String?
    var maxTemp24HrC: String?
    var minTemp24HrC: String?
    var precipIn: String?
    var precipLast3HoursIn: String?
    var precipLast6HoursIn: String?
    var precipLast24HoursIn: String?
    var snowIn: String?
    var vertVisFt: String?
    var metarType: String?
    var elevationM: String?
    init() {self.isNil = true}
    init(rawText: String?,
         stationId: String?,
         observationTime: String?,
         latitude: String?,
         longitude: String?,
         tempC: String?,
         dewPointC: String?,
         windDirDegrees: String?,
         windSpeedKts: String?,
         windGustKts: String?,
         visibilityStatuteMiles: String?,
         altimeterInHg: String?,
         seaLevelPressureMb: String?,
         qualityControlFlags: String?,
         wxString: String?,
         skyCondition: String?,
         flightCategory: String?,
         threeHrPressureTendencyMb: String?,
         maxTempPastSixHoursC: String?,
         minTempPastSixHoursC: String?,
         maxTemp24HrC: String?,
         minTemp24HrC: String?,
         precipIn: String?,
         precipLast3HoursIn: String?,
         precipLast6HoursIn: String?,
         precipLast24HoursIn: String?,
         snowIn: String?,
         vertVisFt: String?,
         metarType: String?,
         elevationM: String?) {
        self.isNil = false
        self.rawText = rawText
        self.stationId = stationId
        self.observationTime = observationTime
        self.latitude = latitude
        self.longitude = longitude
        self.tempC = tempC
        self.dewPointC = dewPointC
        self.windDirDegrees = windDirDegrees
        self.windSpeedKts = windSpeedKts
        self.windGustKts = windGustKts
        self.visibilityStatuteMiles = visibilityStatuteMiles
        self.altimeterInHg = altimeterInHg
        self.seaLevelPressureMb = seaLevelPressureMb
        self.qualityControlFlags = qualityControlFlags
        self.wxString = wxString
        self.skyCondition = skyCondition
        self.flightCategory = flightCategory
        self.threeHrPressureTendencyMb = threeHrPressureTendencyMb
        self.maxTempPastSixHoursC = maxTempPastSixHoursC
        self.minTempPastSixHoursC = minTempPastSixHoursC
        self.maxTemp24HrC = maxTemp24HrC
        self.minTemp24HrC = minTemp24HrC
        self.precipIn = precipIn
        self.precipLast3HoursIn = precipLast3HoursIn
        self.precipLast6HoursIn = precipLast6HoursIn
        self.precipLast24HoursIn = precipLast24HoursIn
        self.snowIn = snowIn
        self.vertVisFt = vertVisFt
        self.metarType = metarType
        self.elevationM = elevationM
    }
    
}
