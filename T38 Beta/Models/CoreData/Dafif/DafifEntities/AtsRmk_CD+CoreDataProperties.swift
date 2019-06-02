//
//  AtsRmk_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension AtsRmk_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AtsRmk_CD> {
        return NSFetchRequest<AtsRmk_CD>(entityName: "AtsRmk_CD")
    }

    @NSManaged public var atsIdent_CD: String?
    @NSManaged public var seqNbr_CD: NSDecimalNumber?
    @NSManaged public var direction_CD: String?
    @NSManaged public var type_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var rmkSeq_CD: NSDecimalNumber?
    @NSManaged public var remark_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
