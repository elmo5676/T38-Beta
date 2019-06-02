//
//  Arpt_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Arpt_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Arpt_CD> {
        return NSFetchRequest<Arpt_CD>(entityName: "Arpt_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var name_CD: String?
    @NSManaged public var stateProv_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var faaHostId_CD: String?
    @NSManaged public var locHdatum_CD: String?
    @NSManaged public var wgsDatum_CD: String?
    @NSManaged public var wgsLat_CD: String?
    @NSManaged public var wgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wgsLong_CD: String?
    @NSManaged public var wgsDlong_CD: NSDecimalNumber?
    @NSManaged public var elev_CD: NSDecimalNumber?
    @NSManaged public var type_CD: String?
    @NSManaged public var magVar_CD: String?
    @NSManaged public var wac_CD: NSDecimalNumber?
    @NSManaged public var beacon_CD: String?
    @NSManaged public var secondArpt_CD: String?
    @NSManaged public var oprAgy_CD: String?
    @NSManaged public var secName_CD: String?
    @NSManaged public var secIcao_CD: String?
    @NSManaged public var secFaa_CD: String?
    @NSManaged public var secOprAgy_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var terrain_CD: String?
    @NSManaged public var hydro_CD: String?

}
