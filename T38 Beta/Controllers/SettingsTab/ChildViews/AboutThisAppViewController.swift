//
//  AboutThisAppViewController.swift
//  T38
//
//  Created by elmo on 6/10/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit

class AboutThisAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setFormatting()
        setLabelsText()
    }

    
    let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    let restrictions = InfoStrings().restrictions
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var restrictionsLabel: UILabel!
    
    func setFormatting() {
        appIcon.layer.cornerRadius = (appIcon.frame.width)/20
        appIcon.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        appIcon.layer.borderWidth = 4
        restrictionsLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setLabelsText() {
        versionLabel.text = "Version: \(buildNumber) Beta"
        restrictionsLabel.text = restrictions
    }
    
    
}
