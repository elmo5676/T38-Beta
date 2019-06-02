//
//  VfrRte_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension VfrRte_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VfrRte_CD> {
        return NSFetchRequest<VfrRte_CD>(entityName: "VfrRte_CD")
    }

    @NSManaged public var heliIdent_CD: String?
    @NSManaged public var heliName_CD: String?
    @NSManaged public var ctry_CD: String?
    @NSManaged public var stateProv_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var faaHostId_CD: String?
    @NSManaged public var wgsDatum_CD: String?
    @NSManaged public var wgsLat_CD: String?
    @NSManaged public var rpWgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wgsLong_CD: String?
    @NSManaged public var rpWgsDlong_CD: NSDecimalNumber?
    @NSManaged public var elev_CD: NSDecimalNumber?
    @NSManaged public var magVar_CD: String?
    @NSManaged public var cityCrossRef_CD: String?
    @NSManaged public var locHdatum_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
