//
//  ArfSch_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension ArfSch_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArfSch_CD> {
        return NSFetchRequest<ArfSch_CD>(entityName: "ArfSch_CD")
    }

    @NSManaged public var arfIdent_CD: String?
    @NSManaged public var direction_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var schUnit_CD: String?
    @NSManaged public var dsn_CD: String?
    @NSManaged public var comNo_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
