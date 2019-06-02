//
//  ArfPar_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension ArfPar_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArfPar_CD> {
        return NSFetchRequest<ArfPar_CD>(entityName: "ArfPar_CD")
    }

    @NSManaged public var arfIdent_CD: String?
    @NSManaged public var direction_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var type_CD: String?
    @NSManaged public var ctry_CD: String?
    @NSManaged public var locHdatum_CD: String?
    @NSManaged public var wgsDatum_CD: String?
    @NSManaged public var priFreq_CD: NSDecimalNumber?
    @NSManaged public var bkpFreq_CD: NSDecimalNumber?
    @NSManaged public var apnCode_CD: String?
    @NSManaged public var apxCode_CD: String?
    @NSManaged public var receiver_CD: String?
    @NSManaged public var tanker_CD: String?
    @NSManaged public var alt1Desc_CD: String?
    @NSManaged public var refuel1Alt1_CD: String?
    @NSManaged public var refuel1Alt2_CD: String?
    @NSManaged public var alt2Desc_CD: String?
    @NSManaged public var refuel2Alt1_CD: String?
    @NSManaged public var refuel2Alt2_CD: String?
    @NSManaged public var alt3Desc_CD: String?
    @NSManaged public var refuel3Alt1_CD: String?
    @NSManaged public var refuel3Alt2_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
