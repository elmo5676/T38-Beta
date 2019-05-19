//
//  InfoStrings.swift
//  T38
//
//  Created by Matthew Elmore on 5/8/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import Foundation


struct InfoStrings {
    
    init() {
        buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        
        disclaimer = "This data is provided for reference use only and it is the end user’s responsibility to verify all data with an approved source."
        
        restrictions = """
        T38 V\(self.buildNumber) Beta::\(disclaimer)
        
        DISTRIBUTION STATEMENT E - Distribution authorized to DoD Components only for unclassified and classified technical data. (16 November 2011). Other requests for this document shall be referred to OO-ALC/WLDEJ, 6057 Box Elder Lane, Hill AFB, UT 84056-5811.
        
        EXPORT CONTROL WARNING - This document contains technical data whose export is restricted by the Arms Export Control Act (Title 22, U.S.C., Sec. 2751 et seq.) or the Export Administration Act of 1979, as amended (Title 50, S.C., App. 2401 et seq.). Violations of these export laws are subject to severe criminal penalties. Disseminate in accordance with provisions of DOD Directive 5230.25.
        
        HANDLING AND DESTRUCTION NOTICE - Unclassified/Limited Distribution documents shall be handled using the same standard as ""For Official Use Only (FOUO)"" material and will be destroyed in any method that will prevent disclosure of the contents or reconstruction of the document.
        
        MODEL: T-38A (AFGSC), DATE: 29 Sep 11
        DATA BASIS: FLIGHT TEST
        """
    }
    
    var buildNumber: String = ""
    
    var restrictions: String = ""
    
    var disclaimer: String = ""
}
