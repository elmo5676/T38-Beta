//
//  Mtr_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Mtr_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mtr_CD> {
        return NSFetchRequest<Mtr_CD>(entityName: "Mtr_CD")
    }

    @NSManaged public var mtrIdent_CD: String?
    @NSManaged public var ptIdent_CD: String?
    @NSManaged public var nxPoint_CD: String?
    @NSManaged public var icaoRegion_CD: String?
    @NSManaged public var crsaltDesc_CD: String?
    @NSManaged public var crsAlt1_CD: String?
    @NSManaged public var crsAlt2_CD: String?
    @NSManaged public var enraltDesc_CD: String?
    @NSManaged public var enrAlt1_CD: String?
    @NSManaged public var enrAlt2_CD: String?
    @NSManaged public var ptNavFlag_CD: String?
    @NSManaged public var navIdent_CD: String?
    @NSManaged public var navType_CD: NSDecimalNumber?
    @NSManaged public var navCtry_CD: String?
    @NSManaged public var navKeyCd_CD: NSDecimalNumber?
    @NSManaged public var bearing_CD: NSDecimalNumber?
    @NSManaged public var distance_CD: NSDecimalNumber?
    @NSManaged public var mtrWidthL_CD: NSDecimalNumber?
    @NSManaged public var mtrWidthR_CD: NSDecimalNumber?
    @NSManaged public var usageCd_CD: String?
    @NSManaged public var wgsLat_CD: String?
    @NSManaged public var wgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wgsLong_CD: String?
    @NSManaged public var wgsDlong_CD: NSDecimalNumber?
    @NSManaged public var turnRad_CD: String?
    @NSManaged public var turnDir_CD: String?
    @NSManaged public var addInfo_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
