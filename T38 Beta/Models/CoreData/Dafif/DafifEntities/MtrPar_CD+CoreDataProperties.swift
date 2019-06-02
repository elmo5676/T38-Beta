//
//  MtrPar_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension MtrPar_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MtrPar_CD> {
        return NSFetchRequest<MtrPar_CD>(entityName: "MtrPar_CD")
    }

    @NSManaged public var mtrIdent_CD: String?
    @NSManaged public var origAct_CD: String?
    @NSManaged public var schAct_CD: String?
    @NSManaged public var icaoRegion_CD: String?
    @NSManaged public var ctry_CD: String?
    @NSManaged public var locHdatum_CD: String?
    @NSManaged public var wgsDatum_CD: String?
    @NSManaged public var effTimes_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
