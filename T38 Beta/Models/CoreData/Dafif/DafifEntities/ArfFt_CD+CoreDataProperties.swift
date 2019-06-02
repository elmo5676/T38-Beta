//
//  ArfFt_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension ArfFt_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArfFt_CD> {
        return NSFetchRequest<ArfFt_CD>(entityName: "ArfFt_CD")
    }

    @NSManaged public var arfIdent_CD: String?
    @NSManaged public var direction_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var ftType_CD: String?
    @NSManaged public var ftNo_CD: NSDecimalNumber?
    @NSManaged public var rmkSeq_CD: NSDecimalNumber?
    @NSManaged public var remarks_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
