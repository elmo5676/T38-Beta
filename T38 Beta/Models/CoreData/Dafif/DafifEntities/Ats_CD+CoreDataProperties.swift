//
//  Ats_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Ats_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ats_CD> {
        return NSFetchRequest<Ats_CD>(entityName: "Ats_CD")
    }

    @NSManaged public var atsIdent_CD: String?
    @NSManaged public var seqNbr_CD: NSDecimalNumber?
    @NSManaged public var direction_CD: String?
    @NSManaged public var type_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var bidirect_CD: String?
    @NSManaged public var freqClass_CD: String?
    @NSManaged public var level_CD: String?
    @NSManaged public var status_CD: String?
    @NSManaged public var wpt1Icao_CD: String?
    @NSManaged public var wpt1NavType_CD: String?
    @NSManaged public var wpt1Ident_CD: String?
    @NSManaged public var wpt1Ctry_CD: String?
    @NSManaged public var wpt1Desc1_CD: String?
    @NSManaged public var wpt1Desc2_CD: String?
    @NSManaged public var wpt1Desc3_CD: String?
    @NSManaged public var wpt1Desc4_CD: String?
    @NSManaged public var wpt1WgsLat_CD: String?
    @NSManaged public var wpt1WgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wpt1WgsLong_CD: String?
    @NSManaged public var wpt1WgsDlong_CD: NSDecimalNumber?
    @NSManaged public var wpt2Icao_CD: String?
    @NSManaged public var wpt2NavType_CD: NSDecimalNumber?
    @NSManaged public var wpt2Ident_CD: String?
    @NSManaged public var wpt2Ctry_CD: String?
    @NSManaged public var wpt2Desc1_CD: String?
    @NSManaged public var wpt2Desc2_CD: String?
    @NSManaged public var wpt2Desc3_CD: String?
    @NSManaged public var wpt2Desc4_CD: String?
    @NSManaged public var wpt2WgsLat_CD: String?
    @NSManaged public var wpt2WgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wpt2WgsLong_CD: String?
    @NSManaged public var wpt2WgsDlong_CD: NSDecimalNumber?
    @NSManaged public var outbdCrs_CD: NSDecimalNumber?
    @NSManaged public var distance_CD: NSDecimalNumber?
    @NSManaged public var inbdCrs_CD: NSDecimalNumber?
    @NSManaged public var minAlt_CD: String?
    @NSManaged public var upperLimit_CD: String?
    @NSManaged public var lowerLimit_CD: String?
    @NSManaged public var maa_CD: String?
    @NSManaged public var cruiseLevel_CD: String?
    @NSManaged public var rnp_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var rvsm_CD: String?
    @NSManaged public var fixTurn1_CD: String?
    @NSManaged public var fixTurn2_CD: String?

}
