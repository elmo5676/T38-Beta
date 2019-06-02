//
//  Hold_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Hold_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hold_CD> {
        return NSFetchRequest<Hold_CD>(entityName: "Hold_CD")
    }

    @NSManaged public var wptId_CD: String?
    @NSManaged public var wptCtry_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var dup_CD: NSDecimalNumber?
    @NSManaged public var inbCrs_CD: NSDecimalNumber?
    @NSManaged public var turnDir_CD: String?
    @NSManaged public var length_CD: NSDecimalNumber?
    @NSManaged public var time_CD: String?
    @NSManaged public var altOne_CD: String?
    @NSManaged public var altTwo_CD: String?
    @NSManaged public var speed_CD: String?
    @NSManaged public var trackCd_CD: String?
    @NSManaged public var navIdent_CD: String?
    @NSManaged public var navType_CD: String?
    @NSManaged public var navCtry_CD: String?
    @NSManaged public var navKeyCd_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
