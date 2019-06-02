//
//  TrmSeg_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension TrmSeg_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrmSeg_CD> {
        return NSFetchRequest<TrmSeg_CD>(entityName: "TrmSeg_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var proc_CD: NSDecimalNumber?
    @NSManaged public var trmIdent_CD: String?
    @NSManaged public var seqNbr_CD: NSDecimalNumber?
    @NSManaged public var type_CD: NSDecimalNumber?
    @NSManaged public var transition_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var trackCd_CD: String?
    @NSManaged public var wptId_CD: String?
    @NSManaged public var wptCtry_CD: String?
    @NSManaged public var wptDesc1_CD: String?
    @NSManaged public var wptDesc2_CD: String?
    @NSManaged public var wptDesc3_CD: String?
    @NSManaged public var wptDesc4_CD: String?
    @NSManaged public var turnDir_CD: String?
    @NSManaged public var nav1Ident_CD: String?
    @NSManaged public var nav1Type_CD: String?
    @NSManaged public var nav1Ctry_CD: String?
    @NSManaged public var nav1KeyCd_CD: String?
    @NSManaged public var nav1Bear_CD: String?
    @NSManaged public var nav1Dist_CD: String?
    @NSManaged public var nav2Ident_CD: String?
    @NSManaged public var nav2Type_CD: String?
    @NSManaged public var nav2Ctry_CD: String?
    @NSManaged public var nav2KeyCd_CD: String?
    @NSManaged public var nav2Bear_CD: String?
    @NSManaged public var nav2Dist_CD: String?
    @NSManaged public var magCrs_CD: String?
    @NSManaged public var distance_CD: String?
    @NSManaged public var altDesc_CD: String?
    @NSManaged public var altOne_CD: String?
    @NSManaged public var altTwo_CD: String?
    @NSManaged public var rnp_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var wptWgsLat_CD: String?
    @NSManaged public var wptWgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wptWgsLong_CD: String?
    @NSManaged public var wptWgsDlong_CD: NSDecimalNumber?
    @NSManaged public var wptMvar_CD: NSDecimalNumber?
    @NSManaged public var nav1WgsLat_CD: String?
    @NSManaged public var nav1WgsDlat_CD: String?
    @NSManaged public var nav1WgsLong_CD: String?
    @NSManaged public var nav1WgsDlong_CD: String?
    @NSManaged public var nav1Mvar_CD: String?
    @NSManaged public var nav1DmeWgsLat_CD: String?
    @NSManaged public var nav1DmeWgsDlat_CD: String?
    @NSManaged public var nav1DmeWgsLong_CD: String?
    @NSManaged public var nav1DmeWgsDlong_CD: String?
    @NSManaged public var nav2WgsLat_CD: String?
    @NSManaged public var nav2WgsDlat_CD: String?
    @NSManaged public var nav2WgsLong_CD: String?
    @NSManaged public var nav2WgsDlong_CD: String?
    @NSManaged public var nav2Mvar_CD: String?
    @NSManaged public var nav2DmeWgsLat_CD: String?
    @NSManaged public var nav2DmeWgsDlat_CD: String?
    @NSManaged public var nav2DmeWgsLong_CD: String?
    @NSManaged public var nav2DmeWgsDlong_CD: String?
    @NSManaged public var speed_CD: String?
    @NSManaged public var speedAc_CD: String?
    @NSManaged public var speedAlt_CD: String?
    @NSManaged public var speed2_CD: String?
    @NSManaged public var speedAc2_CD: String?
    @NSManaged public var speedAlt2_CD: String?
    @NSManaged public var vnav_CD: String?
    @NSManaged public var tch_CD: String?

}
