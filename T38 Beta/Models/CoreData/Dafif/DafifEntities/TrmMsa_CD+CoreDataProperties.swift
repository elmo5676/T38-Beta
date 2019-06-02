//
//  TrmMsa_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension TrmMsa_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrmMsa_CD> {
        return NSFetchRequest<TrmMsa_CD>(entityName: "TrmMsa_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var proc_CD: NSDecimalNumber?
    @NSManaged public var trmIdent_CD: String?
    @NSManaged public var secNbr_CD: NSDecimalNumber?
    @NSManaged public var secAlt_CD: NSDecimalNumber?
    @NSManaged public var icao_CD: String?
    @NSManaged public var navIdent_CD: String?
    @NSManaged public var navType_CD: String?
    @NSManaged public var navCtry_CD: String?
    @NSManaged public var navKeyCd_CD: String?
    @NSManaged public var secBear1_CD: NSDecimalNumber?
    @NSManaged public var secBear2_CD: String?
    @NSManaged public var wptIdent_CD: String?
    @NSManaged public var wptCtry_CD: String?
    @NSManaged public var secMile1_CD: NSDecimalNumber?
    @NSManaged public var secMile2_CD: NSDecimalNumber?
    @NSManaged public var wgsLat_CD: String?
    @NSManaged public var wgsDlat_CD: NSDecimalNumber?
    @NSManaged public var wgsLong_CD: String?
    @NSManaged public var wgsDlong_CD: NSDecimalNumber?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
