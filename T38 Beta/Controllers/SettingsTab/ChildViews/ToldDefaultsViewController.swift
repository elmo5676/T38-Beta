//
//  PreferencesViewController.swift
//  T38
//
//  Created by elmo on 4/13/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit
import CoreData

class ToldDefaultsViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Initial Setup
    var airport: [NSManagedObject] = []
    var jsonH = JSONHandler()
    var reachable = Reachability()
    var cdu = CoreDataUtilies()
    var moc: NSManagedObjectContext!
//    var cw: Weather?
    var pc: NSPersistentContainer?
    
   // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        self.hideKeyboardWhenTappedAround()
        self.runwayLengthTextfield.delegate = self
        self.acGrossWeightTextfield.delegate = self
        self.weightOfCargoInPodTextfield.delegate = self
        self.givenEngFailTextfield.delegate = self
        self.rcrTextField.delegate = self
        self.temperatureTextField.delegate = self
        self.pressureAltTextField.delegate = self
        self.runwayHDGTextField.delegate = self
        self.runwaySlopeTextField.delegate = self
        self.windDirectionTextField.delegate = self
        self.windVelocityTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserDefaultsIntoTextfields()
        setSwitches()
    }
    
    // MARK: - Textfields
    @IBOutlet weak var runwayLengthTextfield: UITextField!
    @IBOutlet weak var acGrossWeightTextfield: UITextField!
    @IBOutlet weak var weightOfCargoInPodTextfield: UITextField!
    @IBOutlet weak var givenEngFailTextfield: UITextField!
    @IBOutlet weak var rcrTextField: UITextField!
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var pressureAltTextField: UITextField!
    @IBOutlet weak var runwayHDGTextField: UITextField!
    @IBOutlet weak var runwaySlopeTextField: UITextField!
    @IBOutlet weak var windDirectionTextField: UITextField!
    @IBOutlet weak var windVelocityTextField: UITextField!
    
    // MARK: - Switches
    @IBOutlet weak var t38AorCLabel: UILabel!
    @IBAction func aOrCmodelSwitch(_ sender: UISwitch) {
        if sender.isOn {
            t38AorCLabel.text = "T-38 C"
        } else {
            t38AorCLabel.text = "T-38 A"
        }
    }
    @IBOutlet weak var aeroBreakingYesOrNoLabel: UILabel!
    @IBOutlet weak var aerobrakingOutlet: UISwitch!
    @IBAction func aeroBreakingSwitch(_ sender: UISwitch) {
        if sender.isOn {
            aeroBreakingYesOrNoLabel.text = "Yes"
        } else {
            aeroBreakingYesOrNoLabel.text = "No"
        }
    }
    @IBOutlet weak var podInstalledYesOrNoLabel: UILabel!
    @IBOutlet weak var podInstalledOutlet: UISwitch!
    @IBAction func podSwitch(_ sender: UISwitch) {
        if sender.isOn {
            podInstalledYesOrNoLabel.text = "Yes"
        } else {
            podInstalledYesOrNoLabel.text = "No"
        }
    }
    
    
    // MARK: - Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == runwayLengthTextfield {
            runwayHDGTextField.becomeFirstResponder()
        } else if textField == runwayHDGTextField {
            runwaySlopeTextField.becomeFirstResponder()
        } else if textField == runwaySlopeTextField {
            acGrossWeightTextfield.becomeFirstResponder()
        } else if textField == acGrossWeightTextfield {
            weightOfCargoInPodTextfield.becomeFirstResponder()
        } else if textField == weightOfCargoInPodTextfield {
            givenEngFailTextfield.becomeFirstResponder()
        } else if textField == givenEngFailTextfield {
            temperatureTextField.becomeFirstResponder()
        } else if textField == temperatureTextField {
            pressureAltTextField.becomeFirstResponder()
        } else if textField == pressureAltTextField {
            windDirectionTextField.becomeFirstResponder()
        } else if textField == windDirectionTextField {
            windVelocityTextField.becomeFirstResponder()
        } else if textField == windVelocityTextField {
            rcrTextField.becomeFirstResponder()
        } else if textField == rcrTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    func setUserDefaultsIntoTextfields(){
        runwayLengthTextfield.text = cdu.getUserDefaults().runwayLength_UD
        acGrossWeightTextfield.text = cdu.getUserDefaults().aircraftGrossWeight_UD
        weightOfCargoInPodTextfield.text = cdu.getUserDefaults().weightOfCargoInPOD_UD
        givenEngFailTextfield.text = cdu.getUserDefaults().givenEngineFailure_UD
        runwayHDGTextField.text = cdu.getUserDefaults().runwayHeading_UD
        runwaySlopeTextField.text = cdu.getUserDefaults().runwaySlope_UD
        temperatureTextField.text = cdu.getUserDefaults().temperature_UD
        pressureAltTextField.text = cdu.getUserDefaults().pressureAlt_UD
        windDirectionTextField.text = cdu.getUserDefaults().windDirection_UD
        windVelocityTextField.text = cdu.getUserDefaults().windVelocity_UD
        rcrTextField.text = cdu.getUserDefaults().rcr_UD
        
    }
    
    func setSwitches() {
        if cdu.getUserDefaults().aeroBraking_UD == "No" {
            aerobrakingOutlet.isOn = false
            aeroBreakingYesOrNoLabel.text = "No"
        } else {
            aerobrakingOutlet.isOn = true
            aeroBreakingYesOrNoLabel.text = "Yes"
        }
        if cdu.getUserDefaults().podInstalled_UD == "No" {
            podInstalledOutlet.isOn = false
            podInstalledYesOrNoLabel.text = "No"
        } else {
            podInstalledOutlet.isOn = true
            podInstalledYesOrNoLabel.text = "Yes"
        }
    }
    
    func verifyNoBlankTextFields() {
        if runwayLengthTextfield.text! == ""
            || runwayHDGTextField.text! == ""
            || runwaySlopeTextField.text! == ""
            || acGrossWeightTextfield.text! == ""
            || weightOfCargoInPodTextfield.text! == ""
            || givenEngFailTextfield.text! == ""
            || temperatureTextField.text! == ""
            || pressureAltTextField.text! == ""
            || windDirectionTextField.text! == ""
            || windVelocityTextField.text! == ""
            || rcrTextField.text! == "" {
            let alertController = UIAlertController(title: "Missing Data", message:
                "You're missing one of the required fields to calculate the TOLD correctly", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true)
            return
        }
    }
    
    func saveUserDefaults(){
        verifyNoBlankTextFields()
        cdu.setUserDefaults(runwayLength: runwayLengthTextfield.text!,
            aeroBraking: aeroBreakingYesOrNoLabel.text!,
            tempScaleCorF: "C",
            aircraftGrossWeight: acGrossWeightTextfield.text!,
            aircraftBasicWeight: "8461",
            fuelWeight: "4000",
            pilotAndGearWeight: "4000",
            podInstalled: podInstalledYesOrNoLabel.text!,
            weightOfCargoInPOD: weightOfCargoInPodTextfield.text!,
            weightUsedForTOLD: acGrossWeightTextfield.text!,
            givenEngineFailure: givenEngFailTextfield.text!,
            temperature: temperatureTextField.text!,
            pressureAlt: pressureAltTextField.text!,
            runwayHeading: runwayHDGTextField.text!,
            windDirection: windDirectionTextField.text!,
            windVelocity: windVelocityTextField.text!,
            runwaySlope: runwaySlopeTextField.text!,
            rcr: rcrTextField.text!
        )
        print(cdu.getUserDefaults())
    }
    
    func retrieveFromDB() {
        let airportRequest: NSFetchRequest<AirfieldCD> = AirfieldCD.fetchRequest()
        airportRequest.returnsObjectsAsFaults = true
        var airportICAOArray = [AirfieldCD]()
        do {
            airportICAOArray = try moc.fetch(airportRequest)
            for i in airportICAOArray {
                if let icao = i.icao_CD {
                    print(icao)
                }
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Buttons
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBAction func saveButton(_ sender: UIButton) {
        sender.showPressed()
        saveUserDefaults()
        
    }
    
    
    
    
}
