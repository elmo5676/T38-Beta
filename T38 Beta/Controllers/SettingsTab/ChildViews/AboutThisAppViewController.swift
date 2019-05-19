//
//  AboutThisAppViewController.swift
//  T38
//
//  Created by elmo on 6/10/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit
import CoreData

class AboutThisAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "Version: \(buildNumber) Beta"
        appIcon.layer.cornerRadius = (appIcon.frame.width)/20
        appIcon.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        appIcon.layer.borderWidth = 4
        moc = cdu.moc!
        restrictionsLabel.adjustsFontSizeToFitWidth = true
        restrictionsLabel.text = InfoStrings().restrictions

    }
    let cdu = CoreDataUtilies()
    var moc: NSManagedObjectContext?

    
    let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    
    @IBAction func navaidTestButton(_ sender: UIButton) {
//        print("Frequencies in CoreData: \(freqStuff())")
        print("Number of TACANS: \(navaidStuff())")
    }
    @IBOutlet weak var restrictionsLabel: UILabel!
    
    func navaidStuff() -> Int {
        let result = cdu.getNavaids(moc: moc!)
        var tacanCounter = 0
        for r in result {
            let nav = r.type_CD
            if nav == "TACAN" {
                tacanCounter += 1
            }
        }
        return tacanCounter
    }
    
    func freqStuff() -> Int {
        let result = cdu.getFreqs(moc: moc!).count
        
//        for r in result {
//            print(r.freq_CD)
//            print(r.id_CD)
//        }
        return result
    }
    
}
