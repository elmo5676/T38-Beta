//
//  AtsCtry_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension AtsCtry_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AtsCtry_CD> {
        return NSFetchRequest<AtsCtry_CD>(entityName: "AtsCtry_CD")
    }

    @NSManaged public var atsIdent_CD: String?
    @NSManaged public var seqNbr_CD: NSDecimalNumber?
    @NSManaged public var direction_CD: String?
    @NSManaged public var type_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var ctry_CD: String?
    @NSManaged public var stateProv_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
