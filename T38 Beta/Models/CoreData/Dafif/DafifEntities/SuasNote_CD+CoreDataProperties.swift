//
//  SuasNote_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension SuasNote_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SuasNote_CD> {
        return NSFetchRequest<SuasNote_CD>(entityName: "SuasNote_CD")
    }

    @NSManaged public var suasIdent_CD: String?
    @NSManaged public var sector_CD: String?
    @NSManaged public var noteType_CD: String?
    @NSManaged public var noteNbr_CD: NSDecimalNumber?
    @NSManaged public var remarks_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
