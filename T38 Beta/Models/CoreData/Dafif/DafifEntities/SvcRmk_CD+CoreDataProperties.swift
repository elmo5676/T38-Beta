//
//  SvcRmk_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension SvcRmk_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SvcRmk_CD> {
        return NSFetchRequest<SvcRmk_CD>(entityName: "SvcRmk_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var type_CD: String?
    @NSManaged public var rmkSeq_CD: NSDecimalNumber?
    @NSManaged public var icao_CD: String?
    @NSManaged public var remarks_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
