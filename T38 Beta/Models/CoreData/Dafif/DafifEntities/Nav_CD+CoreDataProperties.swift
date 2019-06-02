//
//  Nav_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Nav_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nav_CD> {
        return NSFetchRequest<Nav_CD>(entityName: "Nav_CD")
    }

    @NSManaged public var navIdent_CD: String?
    @NSManaged public var type_CD: NSDecimalNumber?
    @NSManaged public var ctry_CD: String?
    @NSManaged public var navKeyCd_CD: NSDecimalNumber?
    @NSManaged public var stateProv_CD: String?
    @NSManaged public var name_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var wac_CD: NSDecimalNumber?
    @NSManaged public var freq_CD: String?
    @NSManaged public var usageCd_CD: String?
    @NSManaged public var chan_CD: String?
    @NSManaged public var rcc_CD: String?
    @NSManaged public var freqProt_CD: String?
    @NSManaged public var power_CD: String?
    @NSManaged public var navRange_CD: String?
    @NSManaged public var locHdatum_CD: String?
    @NSManaged public var wgsDatum_CD: String?
    @NSManaged public var wgsLat_CD: String?
    @NSManaged public var wgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wgsLong_CD: String?
    @NSManaged public var wgsDlong_CD: NSDecimalNumber?
    @NSManaged public var slavedVar_CD: String?
    @NSManaged public var magVar_CD: String?
    @NSManaged public var elev_CD: NSDecimalNumber?
    @NSManaged public var dmeWgsLat_CD: String?
    @NSManaged public var dmeWgsDlat_CD: String?
    @NSManaged public var dmeWgsLong_CD: String?
    @NSManaged public var dmeWgsDlong_CD: String?
    @NSManaged public var dmeElev_CD: String?
    @NSManaged public var arptIcao_CD: String?
    @NSManaged public var os_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
