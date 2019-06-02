//
//  TrmRmk_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension TrmRmk_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrmRmk_CD> {
        return NSFetchRequest<TrmRmk_CD>(entityName: "TrmRmk_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var proc_CD: NSDecimalNumber?
    @NSManaged public var trmIdent_CD: String?
    @NSManaged public var appType_CD: String?
    @NSManaged public var rmkSeq_CD: NSDecimalNumber?
    @NSManaged public var icao_CD: String?
    @NSManaged public var remarks_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?
    @NSManaged public var rmkType_CD: String?

}
