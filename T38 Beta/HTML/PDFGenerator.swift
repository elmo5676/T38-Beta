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
    
    let A4PageWidth: CGFloat = 740//595.2
    let A4PageHeight: CGFloat = 841.8
    
    override init() {
        super .init()
        let pageFrame = CGRect(x: 0, y: 0, width: A4PageHeight, height: A4PageWidth)
//        let printFrame = CGRect(x: 0.0, y: 0.0, width: A4PageWidth - 10, height: A4PageHeight - 10)
        self.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        self.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
    }
    
    
}
