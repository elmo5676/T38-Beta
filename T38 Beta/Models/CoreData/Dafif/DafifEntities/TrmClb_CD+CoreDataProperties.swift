//
//  TrmClb_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension TrmClb_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrmClb_CD> {
        return NSFetchRequest<TrmClb_CD>(entityName: "TrmClb_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var proc_CD: NSDecimalNumber?
    @NSManaged public var trmIdent_CD: String?
    @NSManaged public var rwyId_CD: NSDecimalNumber?
    @NSManaged public var occNo_CD: NSDecimalNumber?
    @NSManaged public var icao_CD: String?
    @NSManaged public var desig_CD: NSDecimalNumber?
    @NSManaged public var knots_CD: NSDecimalNumber?
    @NSManaged public var rateDesc_CD: NSDecimalNumber?
    @NSManaged public var alt_CD: NSDecimalNumber?
    @NSManaged public var ftnote_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
