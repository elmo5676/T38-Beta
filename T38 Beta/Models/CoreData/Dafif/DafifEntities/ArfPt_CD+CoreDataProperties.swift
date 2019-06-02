//
//  ArfPt_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension ArfPt_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArfPt_CD> {
        return NSFetchRequest<ArfPt_CD>(entityName: "ArfPt_CD")
    }

    @NSManaged public var arfIdent_CD: String?
    @NSManaged public var direction_CD: String?
    @NSManaged public var ptSeqNbr_CD: NSDecimalNumber?
    @NSManaged public var icao_CD: String?
    @NSManaged public var usage_CD: String?
    @NSManaged public var ptNavFlag_CD: String?
    @NSManaged public var navIdent_CD: String?
    @NSManaged public var navType_CD: String?
    @NSManaged public var navCtry_CD: String?
    @NSManaged public var navKeyCd_CD: String?
    @NSManaged public var bearing_CD: String?
    @NSManaged public var distance_CD: String?
    @NSManaged public var wgsLat_CD: String?
    @NSManaged public var wgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wgsLong_CD: String?
    @NSManaged public var wgsDlong_CD: NSDecimalNumber?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var ptIdent_CD: String?

}
