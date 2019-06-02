//
//  Wpt_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Wpt_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wpt_CD> {
        return NSFetchRequest<Wpt_CD>(entityName: "Wpt_CD")
    }

    @NSManaged public var wptIdent_CD: String?
    @NSManaged public var ctry_CD: String?
    @NSManaged public var stateProv_CD: NSDecimalNumber?
    @NSManaged public var wptNavFlag_CD: String?
    @NSManaged public var type_CD: String?
    @NSManaged public var desc_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var usageCd_CD: String?
    @NSManaged public var bearing_CD: NSDecimalNumber?
    @NSManaged public var distance_CD: NSDecimalNumber?
    @NSManaged public var wac_CD: NSDecimalNumber?
    @NSManaged public var locHdatum_CD: String?
    @NSManaged public var wgsDatum_CD: String?
    @NSManaged public var wgsLat_CD: String?
    @NSManaged public var wgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wgsLong_CD: String?
    @NSManaged public var wgsDlong_CD: NSDecimalNumber?
    @NSManaged public var magVar_CD: String?
    @NSManaged public var navIdent_CD: String?
    @NSManaged public var navType_CD: NSDecimalNumber?
    @NSManaged public var navCtry_CD: String?
    @NSManaged public var navKeyCd_CD: NSDecimalNumber?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var wptRvsm_CD: String?
    @NSManaged public var rwyId_CD: String?
    @NSManaged public var rwyIcao_CD: String?

}
