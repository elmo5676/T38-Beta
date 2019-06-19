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
        setInitialValues()
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
    let defaults = UserDefaults.standard
    
    func setInitialValues() {
        tail_1_Outlet.insertText(leadTail ?? "")
        if let callSign_1 = defaults.string(forKey: "callSign_1") {
            self.callSign_1 = callSign_1
            callSignOutlet_1.text = self.callSign_1
        }
        if let callSign_2 = defaults.string(forKey: "callSign_2") {
            self.callSign_2 = callSign_2
        }
        if let callSign_3 = defaults.string(forKey: "callSign_3") {
            self.callSign_3 = callSign_3
        }
        if let callSign_4 = defaults.string(forKey: "callSign_4") {
            self.callSign_4 = callSign_4
        }
        if let callSignNum_1 = defaults.string(forKey: "callSignNum_1") {
            self.callSignNum_1 = callSignNum_1
        }
        if let callSignNum_2 = defaults.string(forKey: "callSignNum_2") {
            self.callSignNum_2 = callSignNum_2
        }
        if let callSignNum_3 = defaults.string(forKey: "callSignNum_3") {
            self.callSignNum_3 = callSignNum_3
        }
        if let callSignNum_4 = defaults.string(forKey: "callSignNum_4") {
            self.callSignNum_4 = callSignNum_4
        }
        if let front_1 = defaults.string(forKey: "front_1") {
            self.front_1 = front_1
        }
        if let front_2 = defaults.string(forKey: "front_2") {
            self.front_2 = front_2
        }
        if let front_3 = defaults.string(forKey: "front_3") {
            self.front_3 = front_3
        }
        if let front_4 = defaults.string(forKey: "front_4") {
            self.front_4 = front_4
        }
        if let back_1 = defaults.string(forKey: "back_1") {
            self.back_1 = back_1
        }
        if let back_2 = defaults.string(forKey: "back_2") {
            self.back_2 = back_2
        }
        if let back_3 = defaults.string(forKey: "back_3") {
            self.back_3 = back_3
        }
        if let back_4 = defaults.string(forKey: "back_4") {
            self.back_4 = back_4
        }
        if let aa_01 = defaults.string(forKey: "aa_01") {
            self.aa_01 = aa_01
        }
        if let aa_02 = defaults.string(forKey: "aa_02") {
            self.aa_02 = aa_02
        }
        if let aa_03 = defaults.string(forKey: "aa_03") {
            self.aa_03 = aa_03
        }
        if let aa_04 = defaults.string(forKey: "aa_04") {
            self.aa_04 = aa_04
        }
        if let line_01 = defaults.string(forKey: "line_01") {
            self.line_01 = line_01
        }
        if let line_02 = defaults.string(forKey: "line_02") {
            self.line_02 = line_02
        }
        if let line_03 = defaults.string(forKey: "line_03") {
            self.line_03 = line_03
        }
        if let line_04 = defaults.string(forKey: "line_04") {
            self.line_04 = line_04
        }
        if let event = defaults.string(forKey: "event") {
            self.event = event
        }
        if let tail_1 = defaults.string(forKey: "tail_1") {
            self.tail_1 = tail_1
        }
        if let tail_2 = defaults.string(forKey: "tail_2") {
            self.tail_2 = tail_2
        }
        if let tail_3 = defaults.string(forKey: "tail_3") {
            self.tail_3 = tail_3
        }
        if let tail_4 = defaults.string(forKey: "tail_4") {
            self.tail_4 = tail_4
        }
        if let show = defaults.string(forKey: "show") {
            self.show = show
        }
        if let brief = defaults.string(forKey: "brief") {
            self.brief = brief
        }
        if let step = defaults.string(forKey: "step") {
            self.step = step
        }
        if let to = defaults.string(forKey: "to") {
            self.to = to
        }
        if let land = defaults.string(forKey: "land") {
            self.land = land
        }
        if let joker = defaults.string(forKey: "joker") {
            self.joker = joker
        }
        if let bingo = defaults.string(forKey: "bingo") {
            self.bingo = bingo
        }
    }
    
    var callSign_1 = "" {
        didSet{
            callSignOutlet_1.text = callSign_1
        defaults.set(callSign_1, forKey: "callSign_1")
        }}
    var callSign_2 = "" {
        didSet{
            callSign_2_Outlet.text = callSign_2
            defaults.set(callSign_2, forKey: "callSign_2")
        }}
    var callSign_3 = "" {
        didSet{
            callSign_3_Outlet.text = callSign_3
            defaults.set(callSign_3, forKey: "callSign_3")
        }}
    var callSign_4 = "" {
        didSet{
            callSign_4_Outlet.text = callSign_4
            defaults.set(callSign_4, forKey: "callSign_4")
        }}
    var callSignNum_1 = "" {
        didSet{
            callSignNum_1_Outlet.text = callSignNum_1
            defaults.set(callSignNum_1, forKey: "callSignNum_1")
        }}
    var callSignNum_2 = "" {
        didSet{
            callSignNum_2_Outlet.text = callSignNum_2
            defaults.set(callSignNum_2, forKey: "callSignNum_2")
        }}
    var callSignNum_3 = "" {
        didSet{
            callSignNum_3_Outlet.text = callSignNum_3
            defaults.set(callSignNum_3, forKey: "callSignNum_3")
        }}
    var callSignNum_4 = "" {
        didSet{
            callSignNum_4_Outlet.text = callSignNum_4
            defaults.set(callSignNum_4, forKey: "callSignNum_4")
        }}
    var front_1 = "" {
        didSet{front_1_Outlet.text = front_1
            defaults.set(front_1, forKey: "front_1")
        }}
    var front_2 = "" {
        didSet{
            front_2_Outlet.text = front_2
            defaults.set(front_2, forKey: "front_2")
        }}
    var front_3 = "" {
        didSet{
            front_3_Outlet.text = front_3
            defaults.set(front_3, forKey: "front_3")
        }}
    var front_4 = "" {
        didSet{
            front_4_Outlet.text = front_4
            defaults.set(front_4, forKey: "front_4")
        }}
    var back_1 = "" {
        didSet{
            back_1_Outlet.text = back_1
            defaults.set(back_1, forKey: "back_1")
        }}
    var back_2 = "" {
        didSet{
            back_2_Outlet.text = back_2
            defaults.set(back_2, forKey: "back_2")
        }}
    var back_3 = "" {
        didSet{
            back_3_Outlet.text = back_3
            defaults.set(back_3, forKey: "back_3")
        }}
    var back_4 = "" {
        didSet{
            back_4_Outlet.text = back_4
            defaults.set(back_4, forKey: "back_4")
        }}
    var aa_01 = "" {
        didSet{
            aa_1_Outlet.text = aa_01
            defaults.set(aa_01, forKey: "aa_01")
        }}
    var aa_02 = "" {
        didSet{
            aa_2_Outlet.text = aa_02
            defaults.set(aa_02, forKey: "aa_02")
        }}
    var aa_03 = "" {
        didSet{
            aa_3_Outlet.text = aa_03
            defaults.set(aa_03, forKey: "aa_03")
        }}
    var aa_04 = "" {
        didSet{
            aa_4_Outlet.text = aa_04
            defaults.set(aa_04, forKey: "aa_04")
        }}
    var line_01 = "" {
        didSet{
            line_1_Outlet.text = line_01
            defaults.set(line_01, forKey: "line_01")
        }}
    var line_02 = "" {
        didSet{
            line_2_Outlet.text = line_02
            defaults.set(line_02, forKey: "line_02")
        }}
    var line_03 = "" {
        didSet{
            line_3_Outlet.text = line_03
            defaults.set(line_03, forKey: "line_03")
        }}
    var line_04 = "" {
        didSet{
            line_4_Outlet.text = line_04
            defaults.set(line_04, forKey: "line_04")
        }}
    var event = "" {
        didSet{
            event_Outlet.text = event
            defaults.set(event, forKey: "event")
        }}
    var tail_1 = "" {
        didSet{
            tail_1_Outlet.text = tail_1
            defaults.set(tail_1, forKey: "tail_1")
        }}
    var tail_2 = "" {
        didSet{
            tail_2_Outlet.text = tail_2
            defaults.set(tail_2, forKey: "tail_2")
        }}
    var tail_3 = "" {
        didSet{
            tail_3_Outlet.text = tail_3
            defaults.set(tail_3, forKey: "tail_3")
        }}
    var tail_4 = "" {
        didSet{
            tail_4_Outlet.text = tail_4
            defaults.set(tail_4, forKey: "tail_4")
        }}
    var show = "" {
        didSet{
            show_Outlet.text = show
            defaults.set(show, forKey: "show")
        }}
    var brief = "" {
        didSet{
            brief_Outlet.text = brief
            defaults.set(brief, forKey: "brief")
        }}
    var step = "" {
        didSet{
            step_Outlet.text = step
            defaults.set(step, forKey: "step")
        }}
    var to = "" {
        didSet{
            to_Outlet.text = to
            defaults.set(to, forKey: "to")
        }}
    var land = "" {
        didSet{
            land_Outlet.text = land
            defaults.set(land, forKey: "land")
        }}
    var joker = "" {
        didSet{
            joker_Outlet.text = joker
            defaults.set(joker, forKey: "joker")
        }}
    var bingo = "" {
        didSet{
            bingo_Outlet.text = bingo
            defaults.set(bingo, forKey: "bingo")
        }}
    
    @IBOutlet weak var callSignOutlet_1: UITextField!
    @IBOutlet weak var callSign_2_Outlet: UITextField!
    @IBOutlet weak var callSign_3_Outlet: UITextField!
    @IBOutlet weak var callSign_4_Outlet: UITextField!
    @IBOutlet weak var callSignNum_1_Outlet: UITextField!
    @IBOutlet weak var callSignNum_2_Outlet: UITextField!
    @IBOutlet weak var callSignNum_3_Outlet: UITextField!
    @IBOutlet weak var callSignNum_4_Outlet: UITextField!
    @IBOutlet weak var front_1_Outlet: UITextField!
    @IBOutlet weak var front_2_Outlet: UITextField!
    @IBOutlet weak var front_3_Outlet: UITextField!
    @IBOutlet weak var front_4_Outlet: UITextField!
    @IBOutlet weak var back_1_Outlet: UITextField!
    @IBOutlet weak var back_2_Outlet: UITextField!
    @IBOutlet weak var back_3_Outlet: UITextField!
    @IBOutlet weak var back_4_Outlet: UITextField!
    @IBOutlet weak var aa_1_Outlet: UITextField!
    @IBOutlet weak var aa_2_Outlet: UITextField!
    @IBOutlet weak var aa_3_Outlet: UITextField!
    @IBOutlet weak var aa_4_Outlet: UITextField!
    @IBOutlet weak var line_1_Outlet: UITextField!
    @IBOutlet weak var line_2_Outlet: UITextField!
    @IBOutlet weak var line_3_Outlet: UITextField!
    @IBOutlet weak var line_4_Outlet: UITextField!
    @IBOutlet weak var tail_1_Outlet: UITextField!
    @IBOutlet weak var tail_2_Outlet: UITextField!
    @IBOutlet weak var tail_3_Outlet: UITextField!
    @IBOutlet weak var tail_4_Outlet: UITextField!
    @IBOutlet weak var show_Outlet: UITextField!
    @IBOutlet weak var brief_Outlet: UITextField!
    @IBOutlet weak var step_Outlet: UITextField!
    @IBOutlet weak var to_Outlet: UITextField!
    @IBOutlet weak var land_Outlet: UITextField!
    @IBOutlet weak var joker_Outlet: UITextField!
    @IBOutlet weak var bingo_Outlet: UITextField!
    @IBOutlet weak var event_Outlet: UITextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewBlur: UIVisualEffectView!
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var textFields: [UITextField]!
    @IBAction func callSign_1(_ sender: UITextField) {
        if let strValue = sender.text {
            callSign_1 = strValue
        }}
    @IBAction func callSign_2(_ sender: UITextField) {
        if let strValue = sender.text {
            callSign_2 = strValue
        }}
    @IBAction func callSign_3(_ sender: UITextField) {
        if let strValue = sender.text {
            callSign_3 = strValue
        }}
    @IBAction func callSign_4(_ sender: UITextField) {
        if let strValue = sender.text {
            callSign_4 = strValue
        }}
    @IBAction func callSignNum_1(_ sender: UITextField) {
        if let strValue = sender.text {
            callSignNum_1 = strValue
        }}
    @IBAction func callSignNum_2(_ sender: UITextField) {
        if let strValue = sender.text {
            callSignNum_2 = strValue
        }}
    @IBAction func callSignNum_3(_ sender: UITextField) {
        if let strValue = sender.text {
            callSignNum_3 = strValue
        }}
    @IBAction func callSignNum_4(_ sender: UITextField) {
        if let strValue = sender.text {
            callSignNum_4 = strValue
        }}
    @IBAction func front_1(_ sender: UITextField) {
        if let strValue = sender.text {
            front_1 = strValue
        }}
    @IBAction func front_2(_ sender: UITextField) {
        if let strValue = sender.text {
            front_2 = strValue
        }}
    @IBAction func front_3(_ sender: UITextField) {
        if let strValue = sender.text {
            front_3 = strValue
        }}
    @IBAction func front_4(_ sender: UITextField) {
        if let strValue = sender.text {
            front_4 = strValue
        }}
    @IBAction func back_1(_ sender: UITextField) {
        if let strValue = sender.text {
            back_1 = strValue
        }}
    @IBAction func back_2(_ sender: UITextField) {
        if let strValue = sender.text {
            back_2 = strValue
        }}
    @IBAction func back_3(_ sender: UITextField) {
        if let strValue = sender.text {
            back_3 = strValue
        }}
    @IBAction func back_4(_ sender: UITextField) {
        if let strValue = sender.text {
            back_4 = strValue
        }}
    @IBAction func aa_01(_ sender: UITextField) {
        if let strValue = sender.text {
            aa_01 = strValue
        }}
    @IBAction func aa_02(_ sender: UITextField) {
        if let strValue = sender.text {
            aa_02 = strValue
        }}
    @IBAction func aa_03(_ sender: UITextField) {
        if let strValue = sender.text {
            aa_03 = strValue
        }}
    @IBAction func aa_04(_ sender: UITextField) {
        if let strValue = sender.text {
            aa_04 = strValue
        }}
    @IBAction func line_01(_ sender: UITextField) {
        if let strValue = sender.text {
            line_01 = strValue
        }}
    @IBAction func line_02(_ sender: UITextField) {
        if let strValue = sender.text {
            line_02 = strValue
        }}
    @IBAction func line_03(_ sender: UITextField) {
        if let strValue = sender.text {
            line_03 = strValue
        }}
    @IBAction func line_04(_ sender: UITextField) {
        if let strValue = sender.text {
            line_04 = strValue
        }}
    @IBAction func event(_ sender: UITextField) {
        if let strValue = sender.text {
            event = strValue
        }}
    @IBAction func tail_1(_ sender: UITextField) {
        if let strValue = sender.text {
            tail_1 = strValue
        }}
    @IBAction func tail_2(_ sender: UITextField) {
        if let strValue = sender.text {
            tail_2 = strValue
        }}
    @IBAction func tail_3(_ sender: UITextField) {
        if let strValue = sender.text {
            tail_3 = strValue
        }}
    @IBAction func tail_4(_ sender: UITextField) {
        if let strValue = sender.text {
            tail_4 = strValue
        }}
    @IBAction func show(_ sender: UITextField) {
        if let strValue = sender.text {
            show = strValue
        }}
    @IBAction func brief(_ sender: UITextField) {
        if let strValue = sender.text {
            brief = strValue
        }}
    @IBAction func step(_ sender: UITextField) {
        if let strValue = sender.text {
            step = strValue
        }}
    @IBAction func to(_ sender: UITextField) {
        if let strValue = sender.text {
            to = strValue
        }}
    @IBAction func land(_ sender: UITextField) {
        if let strValue = sender.text {
            land = strValue
        }}
    @IBAction func joker(_ sender: UITextField) {
        if let strValue = sender.text {
            joker = strValue
        }}
    @IBAction func bingo(_ sender: UITextField) {
        if let strValue = sender.text {
            bingo = strValue
        }}
    
    
    @IBOutlet weak var numberOfAircraftSegOutlet: UISegmentedControl!
    @IBAction func numberOfAircraftSeg(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            hideAcft2(true)
            hideAcft3(true)
            hideAcft4(true)
        case 1:
            hideAcft2(false)
            hideAcft3(true)
            hideAcft4(true)
        case 2:
            hideAcft2(false)
            hideAcft3(false)
            hideAcft4(true)
        case 3:
            hideAcft2(false)
            hideAcft3(false)
            hideAcft4(false)
        default:
            print("what the hell is going on here??")
        }}
    
    func hideAcft2(_ hide: Bool) {
        let enable = !hide
        if hide {
            callSign_2 		= ""
            callSignNum_2	= ""
            front_2 		= ""
            back_2 			= ""
            aa_02 			= ""
            line_02 		= ""
            tail_2 			= ""
        } else {callSign_2 = callSign_1}
        callSign_2_Outlet.isHidden = hide
        callSign_2_Outlet.isEnabled = enable
        callSignNum_2_Outlet.isHidden = hide
        callSignNum_2_Outlet.isEnabled = enable
        front_2_Outlet.isHidden = hide
        front_2_Outlet.isEnabled = enable
        back_2_Outlet.isHidden = hide
        back_2_Outlet.isEnabled = enable
        aa_2_Outlet.isHidden = hide
        aa_2_Outlet.isEnabled = enable
        line_2_Outlet.isHidden = hide
        line_2_Outlet.isEnabled = enable
        tail_2_Outlet.isHidden = hide
        tail_2_Outlet.isEnabled = enable
    }
    
    func hideAcft3(_ hide: Bool) {
        let enable = !hide
        if hide {
            callSign_3		= ""
            callSignNum_3 	= ""
            front_3     	= ""
            back_3      	= ""
            aa_03       	= ""
            line_03     	= ""
            tail_3      	= ""
        } else {callSign_3 = callSign_1}
        callSign_3_Outlet.isHidden = hide
        callSign_3_Outlet.isEnabled = enable
        callSignNum_3_Outlet.isHidden = hide
        callSignNum_3_Outlet.isEnabled = enable
        front_3_Outlet.isHidden = hide
        front_3_Outlet.isEnabled = enable
        back_3_Outlet.isHidden = hide
        back_3_Outlet.isEnabled = enable
        aa_3_Outlet.isHidden = hide
        aa_3_Outlet.isEnabled = enable
        line_3_Outlet.isHidden = hide
        line_3_Outlet.isEnabled = enable
        tail_3_Outlet.isHidden = hide
        tail_3_Outlet.isEnabled = enable
    }
    
    @IBOutlet weak var topSpacerStackView: UIStackView!
    @IBOutlet weak var buttonSpacerStackView: UIStackView!
    func hideAcft4(_ hide: Bool) {
        let enable = !hide
        if hide {
            callSign_4		= ""
            callSignNum_4 	= ""
            front_4     	= ""
            back_4      	= ""
            aa_04       	= ""
            line_04     	= ""
            tail_4      	= ""
        } else {callSign_4 = callSign_1}
        buttonSpacerStackView.isHidden = !hide
        callSign_4_Outlet.isHidden = hide
        callSign_4_Outlet.isEnabled = enable
        callSignNum_4_Outlet.isHidden = hide
        callSignNum_4_Outlet.isEnabled = enable
        front_4_Outlet.isHidden = hide
        front_4_Outlet.isEnabled = enable
        back_4_Outlet.isHidden = hide
        back_4_Outlet.isEnabled = enable
        aa_4_Outlet.isHidden = hide
        aa_4_Outlet.isEnabled = enable
        line_4_Outlet.isHidden = hide
        line_4_Outlet.isEnabled = enable
        tail_4_Outlet.isHidden = hide
        tail_4_Outlet.isEnabled = enable
    }
    
    
    @IBOutlet weak var clearAllButtonOutlet: UIButton!
    @IBAction func clearAllButton(_ sender: UIButton) {
        clearAllButtonOutlet.showPressed()
        numberOfAircraftSegOutlet.selectedSegmentIndex = 0
        leadTail = ""
        hideAcft2(true)
        hideAcft3(true)
        hideAcft4(true)
        for tf in textFields {
            tf.text = ""
            tf.insertText(" ")
        }
    }
    
    @IBOutlet weak var dismissButtonOutlet: UIButton!
    @IBAction func dismiss(_ sender: UIButton) {
        dismissButtonOutlet.showPressed()
        
    }
    @IBAction func dismissBarButton(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var lineUpCardButtonOutlet: UIButton!
    
    fileprivate func generateHtml() -> String {
        var result = ""
        var setosp10: String = ""
        if let setos = results.setos {
            guard var setosp10D = Double(setos) else { return ""}
            setosp10D = setosp10D + 10.0
            setosp10 = setosp10D.toStringWithZeroDecimal()
        }
        if let metar = metar {
            let htmlH = HTMLHandler()
            if let _ = htmlH.putCalculatedValuesInLineUpCard(callSign_1: callSign_1,
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
                                                               airToAirTac_01: aa_01,
                                                               airToAirTac_02: aa_02,
                                                               airToAirTac_03: aa_03,
                                                               airToAirTac_04: aa_04,
                                                               line_01: line_01,
                                                               line_02: line_02,
                                                               line_03: line_03,
                                                               line_04: line_04,
                                                               event: event,
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
                land: land) {
                result = htmlH.htmlContent ?? ""
            }}
        return result
    }
    
    @IBAction func exportLineUpCard(_ sender: UIButton) {
        lineUpCardButtonOutlet.showPressed()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "printPreview":
            let dvc = segue.destination as! LineUpCardPreview
            dvc.lineUpCardHtml = generateHtml()
        default:
            print("What the?!?!?")
        }
    }
    
    func addMin(min: Int, toHr: Int, toMin: Int) -> String {
        var hour = toHr
        var minute = toMin
        var strMinute = ""
        if (toMin + min) >= 120 {
            hour += 2
            minute = (toMin + min) - 120
        } else if (toMin + min) >= 60 {
            hour += 1
            minute = (toMin + min) - 60
        } else {
            hour = toHr
            minute = toMin + min
        }
        if minute < 10 {
            strMinute = "0\(minute)"
        } else {
            strMinute = "\(minute)"
        }
        return "\(hour):\(strMinute)"
    }
    
    func get38Times(showHour: Int, showMin: Int) -> (brief: String,
        step: String, to: String, land: String) {
            let briefTime = addMin(min: 15, toHr: showHour, toMin: showMin)
            let stepTime = addMin(min: 30, toHr: showHour, toMin: showMin)
            let toTime = addMin(min: 45, toHr: showHour, toMin: showMin)
            let landTime = addMin(min: 80, toHr: showHour, toMin: showMin)
            return (brief: briefTime,
                    step: stepTime,
                    to: toTime,
                    land: landTime)
    }
    
    @IBOutlet weak var iconBottom: UIImageView!
    func setFormatting() {
        numberOfAircraftSegOutlet.selectedSegmentIndex = 0
        hideAcft2(true)
        hideAcft3(true)
        hideAcft4(true)
        clearAllButtonOutlet.standardButtonFormatting2()
        dismissButtonOutlet.standardButtonFormatting2()
        lineUpCardButtonOutlet.standardButtonFormatting2()
        let cornerRadius: CGFloat = 10
        iconBottom.layer.cornerRadius = cornerRadius
        mainView.layer.cornerRadius = cornerRadius
        mainViewBlur.layer.cornerRadius = cornerRadius
        for label in labelCollection {
            label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
}
