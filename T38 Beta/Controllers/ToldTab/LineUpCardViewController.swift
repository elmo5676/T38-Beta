//
//  LineUpCardViewController.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 5/26/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import UIKit

class LineUpCardViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFormatting()
        self.hideKeyboardWhenTappedAround()
        for tf in textFields {
            tf.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let i = textFields.firstIndex(of: textField)
        if textField == textFields[i!] {
            if i == textFields.count - 1 {
                textField.resignFirstResponder()
                return true
            }
            textFields[i! + 1].becomeFirstResponder()
        }
        return true
    }
    
    var results: (headWind: String?, crossWind: String?, macs: String?, macsDistance: String?, decisionSpeed: String?, refusalSpeed_EF: String?, setos: String?, speedAtEndOfRunway: String?, gearDnSECG: String?, gearUpSECG: String?, criticalFieldLength: String?, nacs: String?, refusalSpeedBEO: String?, rotationSpeed: String?, takeoffSpeed: String?, takeoffDistance: String?, criticalEngineFailureSpeed: String?, SpeedAtEndOfRunway_EF: String?, gearDnSECG_EF: String?, gearUpSECG_EF: String?, ErrorMessages: [Any?]?)
    var metar: Metar?
    var leadTail: String?
    var pa: Double?
    
    var callSign_1 = ""
    var callSign_2 = ""
    var callSign_3 = ""
    var callSign_4 = ""
    var callSignNum_1 = ""
    var callSignNum_2 = ""
    var callSignNum_3 = ""
    var callSignNum_4 = ""
    var front_1 = ""
    var front_2 = ""
    var front_3 = ""
    var front_4 = ""
    var back_1 = ""
    var back_2 = ""
    var back_3 = ""
    var back_4 = ""
    var tail_1 = ""
    var tail_2 = ""
    var tail_3 = ""
    var tail_4 = ""
    var show = ""
    var brief = ""
    var step = ""
    var to = ""
    var land = ""
    var joker = ""
    var bingo = ""
    var missionObj1 = ""
    var missionObj2 = ""
    var trainingObj_1 = ""
    var trainingObj_2 = ""
    var trainingObj_3 = ""
    var trainingObj_4 = ""
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewBlur: UIVisualEffectView!
    
    @IBOutlet var textFields: [UITextField]!
    @IBAction func callSign_1(_ sender: UITextField) {
        if let strValue = sender.text {
            callSign_1 = strValue
            print(strValue)
        }
    }
    @IBAction func callSign_2(_ sender: UITextField) {
        if let strValue = sender.text {
            callSign_2 = strValue
        }
    }
    @IBAction func callSign_3(_ sender: UITextField) {
        if let strValue = sender.text {
            callSign_3 = strValue
        }
    }
    @IBAction func callSign_4(_ sender: UITextField) {
        if let strValue = sender.text {
            callSign_4 = strValue
        }
    }
    @IBAction func callSignNum_1(_ sender: UITextField) {
        if let strValue = sender.text {
            callSignNum_1 = strValue
        }
    }
    @IBAction func callSignNum_2(_ sender: UITextField) {
        if let strValue = sender.text {
            callSignNum_2 = strValue
        }
    }
    @IBAction func callSignNum_3(_ sender: UITextField) {
        if let strValue = sender.text {
            callSignNum_3 = strValue
        }
    }
    @IBAction func callSignNum_4(_ sender: UITextField) {
        if let strValue = sender.text {
            callSignNum_4 = strValue
        }
    }
    @IBAction func front_1(_ sender: UITextField) {
        if let strValue = sender.text {
            front_1 = strValue
        }
    }
    @IBAction func front_2(_ sender: UITextField) {
        if let strValue = sender.text {
            front_2 = strValue
        }
    }
    @IBAction func front_3(_ sender: UITextField) {
        if let strValue = sender.text {
            front_3 = strValue
        }
    }
    @IBAction func front_4(_ sender: UITextField) {
        if let strValue = sender.text {
            front_4 = strValue
        }
    }
    @IBAction func back_1(_ sender: UITextField) {
        if let strValue = sender.text {
            back_1 = strValue
        }
    }
    @IBAction func back_2(_ sender: UITextField) {
        if let strValue = sender.text {
            back_2 = strValue
        }
    }
    @IBAction func back_3(_ sender: UITextField) {
        if let strValue = sender.text {
            back_3 = strValue
        }
    }
    @IBAction func back_4(_ sender: UITextField) {
        if let strValue = sender.text {
            back_4 = strValue
        }
    }
    @IBAction func tail_1(_ sender: UITextField) {
        if let strValue = sender.text {
            tail_1 = strValue
        }
    }
    @IBAction func tail_2(_ sender: UITextField) {
        if let strValue = sender.text {
            tail_2 = strValue
        }
    }
    @IBAction func tail_3(_ sender: UITextField) {
        if let strValue = sender.text {
            tail_3 = strValue
        }
    }
    @IBAction func tail_4(_ sender: UITextField) {
        if let strValue = sender.text {
            tail_4 = strValue
        }
    }
    @IBAction func show(_ sender: UITextField) {
        if let strValue = sender.text {
            show = strValue
        }
    }
    @IBAction func brief(_ sender: UITextField) {
        if let strValue = sender.text {
            brief = strValue
        }
    }
    @IBAction func step(_ sender: UITextField) {
        if let strValue = sender.text {
            step = strValue
        }
    }
    @IBAction func to(_ sender: UITextField) {
        if let strValue = sender.text {
            to = strValue
        }
    }
    @IBAction func land(_ sender: UITextField) {
        if let strValue = sender.text {
            land = strValue
        }
    }
    @IBAction func joker(_ sender: UITextField) {
        if let strValue = sender.text {
            joker = strValue
        }
    }
    @IBAction func bingo(_ sender: UITextField) {
        if let strValue = sender.text {
            bingo = strValue
        }
    }
    @IBAction func missionObj1(_ sender: UITextField) {
        if let strValue = sender.text {
            missionObj1 = strValue
        }
    }
    @IBAction func missionObj2(_ sender: UITextField) {
        if let strValue = sender.text {
            missionObj2 = strValue
        }
    }
    @IBAction func trainingObj_1(_ sender: UITextField) {
        if let strValue = sender.text {
            trainingObj_1 = strValue
        }
    }
    @IBAction func trainingObj_2(_ sender: UITextField) {
        if let strValue = sender.text {
            trainingObj_2 = strValue
        }
    }
    @IBAction func trainingObj_3(_ sender: UITextField) {
        if let strValue = sender.text {
            trainingObj_3 = strValue
        }
    }
    @IBAction func trainingObj_4(_ sender: UITextField) {
        if let strValue = sender.text {
            trainingObj_4 = strValue
        }
    }
    
    
    
    @IBAction func dismiss(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exportLineUpCard(_ sender: UIButton) {
        var setosp10: String = ""
        if let setos = results.setos {
            guard var setosp10D = Double(setos) else { return }
            setosp10D = setosp10D + 10.0
            setosp10 = setosp10D.toStringWithZeroDecimal()
        }
        if let metar = metar {
            let htmlH = HTMLHandler()
            if let luc = htmlH.putCalculatedValuesInLineUpCard(callSign_1: callSign_1,
                                                               callSign_2: callSign_2,
                                                               callSign_3: callSign_3,
                                                               callSign_4: callSign_4,
                                                               callSignNum_1: callSignNum_1,
                                                               callSignNum_2: callSignNum_2,
                                                               callSignNum_3: callSignNum_3,
                                                               callSignNum_4: callSignNum_4,
                                                               frontPilot_1: front_1,
                                                               frontPilot_2: front_2,
                                                               frontPilot_3: front_3,
                                                               frontPilot_4: front_4,
                                                               backPilot_1: back_1,
                                                               backPilot_2: back_2,
                                                               backPilot_3: back_3,
                                                               backPilot_4: back_4,
                                                               aircraft_1: leadTail ?? tail_1,
                                                               aircraft_2: tail_2,
                                                               aircraft_3: tail_3,
                                                               aircraft_4: tail_4,
                                                               joker: joker,
                                                               bingo: bingo,
                                                               macsSpeed: results.macs ?? "",
                                                               macsDist: results.macsDistance ?? "",
                                                               ds: results.decisionSpeed ?? "",
                                                               rsEf: results.refusalSpeed_EF ?? "",
                                                               setos: results.setos ?? "",
                                                               setosp10: setosp10,
                                                               cfl: results.criticalFieldLength ?? "",
                                                               eor: results.SpeedAtEndOfRunway_EF ?? "",
                                                               rsBeo: results.refusalSpeedBEO ?? "",
                                                               grDnSecg: results.gearDnSECG ?? "",
                                                               grUpSecg: results.gearUpSECG ?? "",
                                                               pa: "\(pa?.numberOfDecimalPlaces(0) ?? -9999.0)",
                temp: "\(metar.tempC ?? "")°C",
                winds: "\(metar.windDirDegrees ?? "") / \(metar.windSpeedKts ?? "")",
                cieling: "",
                icing: "",
                show: show,
                brief: brief,
                step: step,
                to: to,
                land: land,
                missionOb1: missionObj1,
                missionOb2: missionObj2,
                trainingObj1: trainingObj_1,
                trainingObj2: trainingObj_2,
                trainingObj3: trainingObj_3,
                trainingObj4: trainingObj_4,
                trainingObj5: "") {
                htmlH.exportHTMLContentToPDF(HTMLContent: luc, view: self)
            }
            
        }
        
    }
    
    func setFormatting() {
        let cornerRadius: CGFloat = 10
        mainView.layer.cornerRadius = cornerRadius
        mainViewBlur.layer.cornerRadius = cornerRadius
        
    }
    
}
