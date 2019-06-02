//
//  Ortca_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Ortca_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ortca_CD> {
        return NSFetchRequest<Ortca_CD>(entityName: "Ortca_CD")
    }

    @NSManaged public var ortcaIdent_CD: NSDecimalNumber?
    @NSManaged public var alt_CD: NSDecimalNumber?
    @NSManaged public var nwLat_CD: String?
    @NSManaged public var nwDlat_CD: NSDecimalNumber?
    @NSManaged public var nwLong_CD: String?
    @NSManaged public var nwDlong_CD: NSDecimalNumber?
    @NSManaged public var neLat_CD: String?
    @NSManaged public var neDlat_CD: NSDecimalNumber?
    @NSManaged public var neLong_CD: String?
    @NSManaged public var neDlong_CD: NSDecimalNumber?
    @NSManaged public var swLat_CD: String?
    @NSManaged public var swDlat_CD: NSDecimalNumber?
    @NSManaged public var swLong_CD: String?
    @NSManaged public var swDlong_CD: NSDecimalNumber?
    @NSManaged public var seLat_CD: String?
    @NSManaged public var seDlat_CD: NSDecimalNumber?
    @NSManaged public var seLong_CD: String?
    @NSManaged public var seDlong_CD: NSDecimalNumber?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var ortcaId_CD: NSDecimalNumber?

}
