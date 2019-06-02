//
//  MtrOv_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension MtrOv_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MtrOv_CD> {
        return NSFetchRequest<MtrOv_CD>(entityName: "MtrOv_CD")
    }

    @NSManaged public var mtrIdent_CD: String?
    @NSManaged public var segNbr_CD: NSDecimalNumber?
    @NSManaged public var ptIdent_CD: String?
    @NSManaged public var ptUsage_CD: String?
    @NSManaged public var ptLat_CD: String?
    @NSManaged public var ptDlat_CD: NSDecimalNumber?
    @NSManaged public var ptLong_CD: String?
    @NSManaged public var ptDlong_CD: NSDecimalNumber?
    @NSManaged public var ptWdthL_CD: NSDecimalNumber?
    @NSManaged public var ptWdthR_CD: NSDecimalNumber?
    @NSManaged public var ptTrnRad_CD: String?
    @NSManaged public var ptTrnDir_CD: String?
    @NSManaged public var ptBiSec_CD: NSDecimalNumber?
    @NSManaged public var nxPoint_CD: String?
    @NSManaged public var nxUsage_CD: String?
    @NSManaged public var nxLat_CD: String?
    @NSManaged public var nxDlat_CD: NSDecimalNumber?
    @NSManaged public var nxLong_CD: String?
    @NSManaged public var nxDlong_CD: NSDecimalNumber?
    @NSManaged public var nxWdthL_CD: NSDecimalNumber?
    @NSManaged public var nxWdthR_CD: NSDecimalNumber?
    @NSManaged public var nxTrnRad_CD: String?
    @NSManaged public var nxTrnDir_CD: String?
    @NSManaged public var nxBiSec_CD: NSDecimalNumber?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
