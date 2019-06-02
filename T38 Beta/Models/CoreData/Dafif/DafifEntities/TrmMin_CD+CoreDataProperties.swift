//
//  TrmMin_CD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension TrmMin_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrmMin_CD> {
        return NSFetchRequest<TrmMin_CD>(entityName: "TrmMin_CD")
    }

    @NSManaged public var arptIdent_CD: String?
    @NSManaged public var proc_CD: NSDecimalNumber?
    @NSManaged public var trmIdent_CD: String?
    @NSManaged public var appType_CD: String?
    @NSManaged public var icao_CD: String?
    @NSManaged public var catADh_CD: NSDecimalNumber?
    @NSManaged public var catARv_CD: String?
    @NSManaged public var catAHa_CD: NSDecimalNumber?
    @NSManaged public var catAWxCl_CD: NSDecimalNumber?
    @NSManaged public var catAWxPv_CD: String?
    @NSManaged public var catBDh_CD: NSDecimalNumber?
    @NSManaged public var catBRv_CD: String?
    @NSManaged public var catBHa_CD: NSDecimalNumber?
    @NSManaged public var catBWxCl_CD: NSDecimalNumber?
    @NSManaged public var catBWxPv_CD: String?
    @NSManaged public var catCDh_CD: NSDecimalNumber?
    @NSManaged public var catCRv_CD: String?
    @NSManaged public var catCHa_CD: NSDecimalNumber?
    @NSManaged public var catCWxCl_CD: NSDecimalNumber?
    @NSManaged public var catCWxPv_CD: String?
    @NSManaged public var catDDh_CD: NSDecimalNumber?
    @NSManaged public var catDRv_CD: String?
    @NSManaged public var catDHa_CD: NSDecimalNumber?
    @NSManaged public var catDWxCl_CD: NSDecimalNumber?
    @NSManaged public var catDWxPv_CD: String?
    @NSManaged public var catEDh_CD: String?
    @NSManaged public var catERv_CD: String?
    @NSManaged public var catEHa_CD: String?
    @NSManaged public var catEWxCl_CD: String?
    @NSManaged public var catEWxPv_CD: String?
    @NSManaged public var minRmk_CD: String?
    @NSManaged public var cycleDate_CD: NSDecimalNumber?

}
