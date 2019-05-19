//
//  UserPreferencesCD+CoreDataProperties.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//
//

import Foundation
import CoreData


extension UserPreferencesCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPreferencesCD> {
        return NSFetchRequest<UserPreferencesCD>(entityName: "UserPreferencesCD")
    }

    @NSManaged public var homeStation_UP_CD: String?
    @NSManaged public var podInstalled_UP_CD: Bool
    @NSManaged public var runwayLength_UP_CD: Int16
    @NSManaged public var userWeight_UP_CD: Double

}
