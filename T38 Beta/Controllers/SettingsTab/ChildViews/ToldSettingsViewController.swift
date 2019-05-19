//
//  ToldSettingsViewController.swift
//  T38
//
//  Created by elmo on 6/6/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit
import CoreData

class ToldSettingsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Initial Setup
    let defaults = UserDefaults.standard
    var airport: [NSManagedObject] = []
    var jsonH = JSONHandler()
    var reachable = Reachability()
    var cdu = CoreDataUtilies()
    var moc: NSManagedObjectContext!
    var dafifUrlJSONBase = "http://getatis.com/DAFIF/GetAirfieldsByState?state="
    var weatherUrlJSONBase = "https://www.getatis.com/services/GetMETAR?stations="
//    var cw: Weather?
    var pc: NSPersistentContainer?
    var useHomeAirfieldICAO: Bool = true
    
    var tabBarItemOne: UITabBarItem = UITabBarItem()
    var tabBarItemTwo: UITabBarItem = UITabBarItem()
    var tabBarItemThree: UITabBarItem = UITabBarItem()
    var tabBarItemFour: UITabBarItem = UITabBarItem()
    var tabBarItemFive: UITabBarItem = UITabBarItem()
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        self.hideKeyboardWhenTappedAround()
        self.homeStationICAOTextfield.delegate = self
        self.minRunwayLengthTextfield.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserDefaultsIntoTextfields()
        setSwitches()
//        let tabBarControllerItems = self.tabBarController?.tabBar.items
//        if let arrayOfTabBarItems = tabBarControllerItems as AnyObject as? NSArray {
//            tabBarItemOne = arrayOfTabBarItems[0] as! UITabBarItem
//            tabBarItemTwo = arrayOfTabBarItems[1] as! UITabBarItem
//            tabBarItemThree = arrayOfTabBarItems[2] as! UITabBarItem
//            tabBarItemFour = arrayOfTabBarItems[3] as! UITabBarItem
//            tabBarItemFive = arrayOfTabBarItems[4] as! UITabBarItem
//        }
    }
    
    // MARK: - Textfields
    @IBOutlet weak var homeStationICAOTextfield: UITextField!
    @IBOutlet weak var minRunwayLengthTextfield: UITextField!
    
    @IBOutlet weak var downloadLabel: UILabel!
    
    // MARK: - Switches
    @IBOutlet weak var useHomeStationICAOSLabel: UILabel!
    @IBOutlet weak var useHomeStationICAOSwitchOutlet: UISwitch!
    @IBAction func useHomeStationICAOSwitch(_ sender: UISwitch) {
        if sender.isOn {
            useHomeStationICAOSLabel.text = "Use Home Airfield ICAO"
            useHomeAirfieldICAO = true
        } else {
            useHomeStationICAOSLabel.text = "Use NRST Airfield ICAO"
            useHomeAirfieldICAO = false
        }
    }
    
    
    // MARK: - Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == homeStationICAOTextfield {
            minRunwayLengthTextfield.becomeFirstResponder()
        } else if textField == minRunwayLengthTextfield {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func setSwitches() {
        if cdu.getUserSettings().useHomeField_UD == true {
            useHomeStationICAOSwitchOutlet.isOn = true
            useHomeStationICAOSLabel.text = "Use Home Airfield ICAO"
        } else {
            useHomeStationICAOSwitchOutlet.isOn = false
            useHomeStationICAOSLabel.text = "Use NRST Airfield ICAO"
        }
    }
    
    func setUserDefaultsIntoTextfields() {
        homeStationICAOTextfield.text = cdu.getUserSettings().homeAirfieldICAO_UD
        minRunwayLengthTextfield.text = cdu.getUserSettings().minRwyLength_UD
        print(cdu.getUserSettings())
    }
    
    func verifyNoBlankTextFields() {
        if homeStationICAOTextfield.text! == ""
            || minRunwayLengthTextfield.text! == ""
             {
            let alertController = UIAlertController(title: "Missing Data", message:
                "You're missing one of the required fields to calculate the TOLD correctly", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true)
            return
        }
    }
    
    func saveUserSettings(){
        verifyNoBlankTextFields()
        cdu.setUserSettings(useHomeField: useHomeAirfieldICAO,
                            homeAirfieldICAO: homeStationICAOTextfield.text!,
                            minRwyLength: minRunwayLengthTextfield.text!)
    }
    
    @IBOutlet weak var updateDataProgress: UIProgressView!
    func progressUpdate() {
        updateDataProgress.progress += 0.01
        
        if updateDataProgress.progress < 0.998 {
            let titleLabel = "\(String(format: "%.0f", updateDataProgress.progress * 100))%"
//            updateDAFIFButtonOutlet.setTitle("\(titleLabel)", for: .normal)
            downloadLabel.text = "\(titleLabel)"
        }
        if updateDataProgress.progress > 0.999 {
            let titleLabel = "Download"
//            updateDAFIFButtonOutlet.setTitle("\(titleLabel)", for: .normal)
            downloadLabel.text = "\(titleLabel)"
            updateDataProgress.progress = 0.0
//            updateDataProgress.progressTintColor = #colorLiteral(red: 0, green: 0.9027383924, blue: 0.02147088759, alpha: 1)
        }
        print(updateDataProgress.progress)
    }
    
    
    // MARK: - Buttons
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBAction func saveButton(_ sender: UIButton) {
        saveUserSettings()
    }
    
    @IBOutlet weak var updateDAFIFButtonOutlet: UIButton!
    @IBAction func updateDAFIFButton(_ sender: UIButton) {
        if reachable.isConnectedToNetowrk() {
            sender.showPressed()
            pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
            tabBarItemFour.isEnabled = false
            jsonH.removeAllFiles()
            cdu.deleteAllFromDB(moc: moc)
            updateDataProgress.progress = 0
            jsonH.initialVerificationWithTabBarMutingAndProgressBar(pc: pc!, moc: moc, tabBarItem: tabBarItemFour, progress: progressUpdate)
        } else {
            let alertController = UIAlertController(title: "No Internet Connection", message:
                "Please make sure you are connected to the internet and try again", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true)
            return
        }
    }
    
    
}
