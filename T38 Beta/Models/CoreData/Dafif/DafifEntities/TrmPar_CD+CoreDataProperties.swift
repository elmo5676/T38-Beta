//
//  TrmPar_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension TrmPar_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrmPar_CD> {
        return NSFetchRequest<TrmPar_CD>(entityName: "TrmPar_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var proc_CD: NSDecimalNumber?
    @NSManaged public var trmIdent_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var esAlt_CD: String?
    @NSManaged public var julianDate_CD: NSDecimalNumber?
    @NSManaged public var amdtNo_CD: NSDecimalNumber?
    @NSManaged public var opr_CD: String?
    @NSManaged public var hostCtryAuth_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var altMin_CD: String?
    @NSManaged public var tranAlt_CD: NSDecimalNumber?
    @NSManaged public var tranLvl_CD: NSDecimalNumber?
    @NSManaged public var rteTypeQual_CD: String?

}
