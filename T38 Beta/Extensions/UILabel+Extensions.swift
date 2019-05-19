//
//  UILabel+Extensions.swift
//  T38
//
//  Created by Matthew Elmore on 5/12/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import Foundation
import UIKit


extension UILabel {
    @IBInspectable
    var rotation: Int {
        get {
            return 0
        } set {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
    
}
