//
//  VfrRteSeg_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension VfrRteSeg_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VfrRteSeg_CD> {
        return NSFetchRequest<VfrRteSeg_CD>(entityName: "VfrRteSeg_CD")
    }

    @NSManaged public var heliIdent_CD: String?
    @NSManaged public var rteIdent_CD: NSDecimalNumber?
    @NSManaged public var segNbr_CD: NSDecimalNumber?
    @NSManaged public var rteName_CD: String?
    @NSManaged public var ptName_CD: String?
    @NSManaged public var ptIdentity_CD: String?
    @NSManaged public var ptWgsLat_CD: String?
    @NSManaged public var ptWgsDlat_CD: NSDecimalNumber?
    @NSManaged public var ptWgsLong_CD: String?
    @NSManaged public var ptWgsDlong_CD: NSDecimalNumber?
    @NSManaged public var utmGrid_CD: String?
    @NSManaged public var ptLatOffR_CD: String?
    @NSManaged public var ptDlatOffR_CD: String?
    @NSManaged public var ptLongOffR_CD: String?
    @NSManaged public var ptDlongOffR_CD: String?
    @NSManaged public var ptLatOffL_CD: String?
    @NSManaged public var ptDlatOffL_CD: String?
    @NSManaged public var ptLongOffL_CD: String?
    @NSManaged public var ptDlongOffL_CD: String?
    @NSManaged public var ptType_CD: String?
    @NSManaged public var ptSym_CD: String?
    @NSManaged public var atHeli_CD: String?
    @NSManaged public var segName_CD: String?
    @NSManaged public var magCrs_CD: String?
    @NSManaged public var pathCode_CD: String?
    @NSManaged public var altDesc_CD: String?
    @NSManaged public var alt_CD: NSDecimalNumber?
    @NSManaged public var turnDir_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
