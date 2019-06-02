//
//  BdryPar_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension BdryPar_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BdryPar_CD> {
        return NSFetchRequest<BdryPar_CD>(entityName: "BdryPar_CD")
    }

    @NSManaged public var bdryIdent_CD: String?
    @NSManaged public var type_CD: NSDecimalNumber?
    @NSManaged public var name_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var conAuth_CD: String?
    @NSManaged public var locHdatum_CD: String?
    @NSManaged public var wgsDatum_CD: String?
    @NSManaged public var commName_CD: String?
    @NSManaged public var commFreq1_CD: String?
    @NSManaged public var commFreq2_CD: String?
    @NSManaged public var class_CD: String?
    @NSManaged public var classExc_CD: String?
    @NSManaged public var classExRmk_CD: String?
    @NSManaged public var level_CD: String?
    @NSManaged public var upperAlt_CD: String?
    @NSManaged public var lowerAlt_CD: String?
    @NSManaged public var rnp_CD: NSDecimalNumber?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var upRvsm_CD: String?
    @NSManaged public var loRvsm_CD: String?

}
