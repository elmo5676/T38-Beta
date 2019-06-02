//
//  FileNames+Extension.swift
//  unZip
//
//  Created by Matthew Elmore on 5/19/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation


extension Array where Element == FileNames {
    func returnRawValues() -> [FileNames.RawValue] {
        var result: [FileNames.RawValue] = []
        for eachFileName in self {
            result.append(eachFileName.rawValue)
        }
        return result
    }}
