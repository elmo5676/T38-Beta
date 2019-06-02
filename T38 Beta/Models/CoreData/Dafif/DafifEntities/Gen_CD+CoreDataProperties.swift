//
//  Gen_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension Gen_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gen_CD> {
        return NSFetchRequest<Gen_CD>(entityName: "Gen_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var altName_CD: String?
    @NSManaged public var cityCrossRef_CD: String?
    @NSManaged public var islGroup_CD: String?
    @NSManaged public var notam_CD: String?
    @NSManaged public var oprHrs_CD: String?
    @NSManaged public var clearStatus_CD: String?
    @NSManaged public var utmGrid_CD: String?
    @NSManaged public var time_CD: String?
    @NSManaged public var daylightSave_CD: String?
    @NSManaged public var flipPub_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
