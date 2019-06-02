//
//  ArfAtc_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension ArfAtc_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArfAtc_CD> {
        return NSFetchRequest<ArfAtc_CD>(entityName: "ArfAtc_CD")
    }

    @NSManaged public var arfIdent_CD: String?
    @NSManaged public var direction_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var usage_CD: String?
    @NSManaged public var center_CD: String?
    @NSManaged public var cntrMult_CD: NSDecimalNumber?
    @NSManaged public var freq1_CD: String?
    @NSManaged public var eW1_CD: String?
    @NSManaged public var freq2_CD: String?
    @NSManaged public var eW2_CD: String?
    @NSManaged public var freq3_CD: String?
    @NSManaged public var eW3_CD: String?
    @NSManaged public var freq4_CD: String?
    @NSManaged public var eW4_CD: String?
    @NSManaged public var freq5_CD: String?
    @NSManaged public var eW5_CD: String?
    @NSManaged public var atcRmk_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
