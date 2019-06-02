//
//  SuasCtry_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension SuasCtry_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SuasCtry_CD> {
        return NSFetchRequest<SuasCtry_CD>(entityName: "SuasCtry_CD")
    }

    @NSManaged public var suasIdent_CD: String?
    @NSManaged public var sector_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var ctry1_CD: String?
    @NSManaged public var ctry2_CD: String?
    @NSManaged public var ctry3_CD: String?
    @NSManaged public var ctry4_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
