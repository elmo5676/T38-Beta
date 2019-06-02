//
//  MtrOsm_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension MtrOsm_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MtrOsm_CD> {
        return NSFetchRequest<MtrOsm_CD>(entityName: "MtrOsm_CD")
    }

    @NSManaged public var mtrIdent_CD: String?
    @NSManaged public var segNbr_CD: NSDecimalNumber?
    @NSManaged public var seqNbr_CD: NSDecimalNumber?
    @NSManaged public var suasMoaId_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var sector_CD: String?
    @NSManaged public var ptIdent_CD: String?
    @NSManaged public var nxPoint_CD: String?

}
