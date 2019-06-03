//
//  RestrictionsViewController.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/2/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation
import UIKit



class RestrictionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restrictionsLabel.text = restrictions
    }
    var restrictions = InfoStrings().restrictions
    @IBOutlet weak var restrictionsLabel: UILabel!
    
}
