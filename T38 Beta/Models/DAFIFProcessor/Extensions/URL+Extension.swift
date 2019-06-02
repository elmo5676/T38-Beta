//
//  URL+Extension.swift
//  unZip
//
//  Created by Matthew Elmore on 5/9/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation

extension Array where Element == URL {
    
    func filterOutURLThatContainsComponentOf(_ str: String) -> [URL] {
        var result: [URL] = []
        for item in self {
            let components = item.pathComponents
            if components.contains(str) != true {
                result.append(item)
            }}
        return result
    }
}

extension URL {
    func filterOutURLThatContainsComponentOf(_ str: String) -> URL? {
        let components = self.pathComponents
        if components.contains(str) != true {
            return self
        } else { return nil }}
    
    func last2Components() -> String {
        let components = self.pathComponents
        let n = components.count - 1
        return "\(components[n - 1])/\(components[n])"
    }
    
}



