//
//  VfrRteRmk_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension VfrRteRmk_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VfrRteRmk_CD> {
        return NSFetchRequest<VfrRteRmk_CD>(entityName: "VfrRteRmk_CD")
    }

    @NSManaged public var heliIdent_CD: String?
    @NSManaged public var rmkSeq_CD: NSDecimalNumber?
    @NSManaged public var remarks_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
