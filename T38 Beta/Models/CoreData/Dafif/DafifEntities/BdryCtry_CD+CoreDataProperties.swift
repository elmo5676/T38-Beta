//
//  BdryCtry_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension BdryCtry_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BdryCtry_CD> {
        return NSFetchRequest<BdryCtry_CD>(entityName: "BdryCtry_CD")
    }

    @NSManaged public var bdryIdent_CD: String?
    @NSManaged public var segNbr_CD: NSDecimalNumber?
    @NSManaged public var ctry1_CD: String?
    @NSManaged public var ctry2_CD: String?
    @NSManaged public var ctry3_CD: String?
    @NSManaged public var ctry4_CD: String?
    @NSManaged public var ctry5_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
