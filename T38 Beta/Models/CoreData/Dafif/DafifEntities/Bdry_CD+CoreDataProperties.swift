//
//  Bdry_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Bdry_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bdry_CD> {
        return NSFetchRequest<Bdry_CD>(entityName: "Bdry_CD")
    }

    @NSManaged public var bdryIdent_CD: String?
    @NSManaged public var segNbr_CD: NSDecimalNumber?
    @NSManaged public var name_CD: String?
    @NSManaged public var type_CD: NSDecimalNumber?
    @NSManaged public var icao_CD: String?
    @NSManaged public var shap_CD: String?
    @NSManaged public var derivation_CD: String?
    @NSManaged public var wgsLat1_CD: String?
    @NSManaged public var wgsDlat1_CD: NSDecimalNumber?
    @NSManaged public var wgsLong1_CD: String?
    @NSManaged public var wgsDlong1_CD: NSDecimalNumber?
    @NSManaged public var wgsLat2_CD: String?
    @NSManaged public var wgsDlat2_CD: NSDecimalNumber?
    @NSManaged public var wgsLong2_CD: String?
    @NSManaged public var wgsDlong2_CD: NSDecimalNumber?
    @NSManaged public var wgsLat0_CD: String?
    @NSManaged public var wgsDlat0_CD: String?
    @NSManaged public var wgsLong0_CD: String?
    @NSManaged public var wgsDlong0_CD: String?
    @NSManaged public var radius1_CD: String?
    @NSManaged public var radius2_CD: String?
    @NSManaged public var bearing1_CD: String?
    @NSManaged public var bearing2_CD: String?
    @NSManaged public var navIdent_CD: String?
    @NSManaged public var navType_CD: String?
    @NSManaged public var navCtry_CD: String?
    @NSManaged public var navKeyCd_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
