//
//  MtrRmk_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension MtrRmk_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MtrRmk_CD> {
        return NSFetchRequest<MtrRmk_CD>(entityName: "MtrRmk_CD")
    }

    @NSManaged public var mtrIdent_CD: String?
    @NSManaged public var rmkSeq_CD: NSDecimalNumber?
    @NSManaged public var remarks_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
