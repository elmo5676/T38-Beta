//
//  InitialLoadViewController.swift
//  T38
//
//  Created by elmo on 5/27/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit
import CoreData

class InitialLoadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }

    
    override func viewDidAppear(_ animated: Bool) {
        statusViewOutlet.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        statusViewOutlet.layer.borderWidth = 2
        statusViewOutlet.layer.cornerRadius = 15
        iconImage.layer.cornerRadius = 3
        
        
        if jsonH.initialVerification(pc: pc, moc: moc) == false {
            //data missing
            jsonH.removeAllFiles()
            if reachable.isConnectedToNetowrk() {
                jsonH.initialVerificationWithProgressBar(pc: pc, moc: moc, progress: progressUpdate)
                manuallyEnterDataButtonOutlet.isHidden = false
            } else {
                initialLoadInfoLabel.text = "You are not connected to the internet and you are missing required downloads. If you would like to take advantage of the features, in T-38 version \(buildNumber), please connect to the internet and restart the app."
                manuallyEnterDataButtonOutlet.isHidden = false
            }
        }
        if jsonH.initialVerification(pc: pc, moc: moc) ==  true {
            cdu.verifyCoreDataMatchesJSON(pc: pc, moc: moc)
            initialLoadProgressBar.progress = 0.999
            initialLoadProgressBar.progressTintColor = #colorLiteral(red: 0.2196078431, green: 0.2509803922, blue: 0.3058823529, alpha: 1)
            
            
            manuallyEnterDataButtonOutlet.isHidden = false
            manuallyEnterDataButtonOutlet.setTitle("Proceed", for: .normal)
            performSegue(withIdentifier: "initialLoadToTabBar", sender: nil)
        }
    }
    
    
    
    let cdu = CoreDataUtilies()
    let jsonH = JSONHandler()
    let reachable = Reachability()
    var pc: NSPersistentContainer!
    var moc: NSManagedObjectContext!
    let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

    @IBOutlet weak var percentageCompleteLabel: UILabel!
    @IBOutlet weak var initialLoadProgressBar: UIProgressView!
    @IBOutlet weak var initialLoadInfoLabel: UILabel!
    @IBOutlet weak var statusViewOutlet: UIView!
    
    
    func progressUpdate() {
        initialLoadProgressBar.progress += 0.01
        if initialLoadProgressBar.progress < 0.48 {
            initialLoadInfoLabel.text = "Welcome to T-38 Version \(buildNumber). Sit tight for a moment while the application downloads DAFIF from the NGA to make filling out TOLD a breeze."
        }
        if initialLoadProgressBar.progress >= 0.49 {
            initialLoadInfoLabel.text = "Ok. All the files have been downloaded! Now to make them useful, you can do fun things like: hit the Divert Button on the Calc and go DIRECT to the closest suitable airfield or have it autofill TOLD fields."
        }
        if initialLoadProgressBar.progress < 0.999 {
            percentageCompleteLabel.text = "\(String(format: "%.0f",initialLoadProgressBar.progress * 100))%"
        }
        if initialLoadProgressBar.progress > 0.999 {
            initialLoadProgressBar.progress = 0.0
            percentageCompleteLabel.text = "100%"
            initialLoadInfoLabel.text = "All Done! Enjoy!!"
            performSegue(withIdentifier: "initialLoadToTabBar", sender: nil)
        }
        print(initialLoadProgressBar.progress)
    }
    
    
    @IBOutlet weak var iconImageUIView: UIView!
    @IBOutlet weak var iconImage: UIImageView!

    
    @IBOutlet weak var manuallyEnterDataButtonOutlet: UIButton!
    @IBAction func manuallyEnterDataButton(_ sender: UIButton) {
        performSegue(withIdentifier: "initialLoadToTabBar", sender: nil)
    }
    
    
    
    

    
}
