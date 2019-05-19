//
//  FreqCD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension FreqCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FreqCD> {
        return NSFetchRequest<FreqCD>(entityName: "FreqCD")
    }

    @NSManaged public var communicationsId_CD: Int32
    @NSManaged public var freq_CD: Double
    @NSManaged public var id_CD: Int32
    @NSManaged public var communication_R_CD: CommunicationCD?

}
