//
//  SuasPar_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension SuasPar_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SuasPar_CD> {
        return NSFetchRequest<SuasPar_CD>(entityName: "SuasPar_CD")
    }

    @NSManaged public var suasIdent_CD: String?
    @NSManaged public var sector_CD: String?
    @NSManaged public var type_CD: String?
    @NSManaged public var name_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var conAgcy_CD: String?
    @NSManaged public var locHdatum_CD: String?
    @NSManaged public var wgsDatum_CD: String?
    @NSManaged public var commName_CD: String?
    @NSManaged public var freq1_CD: String?
    @NSManaged public var freq2_CD: String?
    @NSManaged public var level_CD: String?
    @NSManaged public var upperAlt_CD: String?
    @NSManaged public var lowerAlt_CD: String?
    @NSManaged public var effTimes_CD: String?
    @NSManaged public var wx_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var effDate_CD: String?

}
