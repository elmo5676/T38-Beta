//
//  PDFGenerator.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 5/26/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation
import UIKit


class PDFGenerator: UIPrintPageRenderer {
    
    let A4PageWidth: CGFloat = 560.0
    let A4PageHeight: CGFloat = 800.0
    
    override init() {
        super .init()
        let pageFrame = CGRect(x: 0, y: 0, width: A4PageHeight, height: A4PageWidth)
        self.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        self.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
    }
    
    
}
