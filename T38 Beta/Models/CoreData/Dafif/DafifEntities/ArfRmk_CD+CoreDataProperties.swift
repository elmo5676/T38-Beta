//
//  ArfRmk_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension ArfRmk_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArfRmk_CD> {
        return NSFetchRequest<ArfRmk_CD>(entityName: "ArfRmk_CD")
    }

    @NSManaged public var arfIdent_CD: String?
    @NSManaged public var direction_CD: String?
    @NSManaged public var rmkSeq_CD: NSDecimalNumber?
    @NSManaged public var icao_CD: String?
    @NSManaged public var remarks_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
