//
//  CommunicationCD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension CommunicationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CommunicationCD> {
        return NSFetchRequest<CommunicationCD>(entityName: "CommunicationCD")
    }

    @NSManaged public var airfieldID_CD: Int32
    @NSManaged public var freqs_CD: [FreqCD]?
    @NSManaged public var id_CD: Int32
    @NSManaged public var name_CD: String?
    @NSManaged public var airfields_R_CD: AirfieldCD?
    @NSManaged public var freqs_R_CD: NSSet?

}

// MARK: Generated accessors for freqs_R_CD
extension CommunicationCD {

    @objc(addFreqs_R_CDObject:)
    @NSManaged public func addToFreqs_R_CD(_ value: FreqCD)

    @objc(removeFreqs_R_CDObject:)
    @NSManaged public func removeFromFreqs_R_CD(_ value: FreqCD)

    @objc(addFreqs_R_CD:)
    @NSManaged public func addToFreqs_R_CD(_ values: NSSet)

    @objc(removeFreqs_R_CD:)
    @NSManaged public func removeFromFreqs_R_CD(_ values: NSSet)

}
