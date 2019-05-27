//
//  TOLDReconfiguredViewController.swift
//  T38
//
//  Created by Matthew Elmore on 3/22/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import CoreMotion
import MessageUI


protocol TOLDReconfiguredDelegate {
    func getChosenTail(tailTitle: String, basicWeight: Double)
}

protocol RunwayChoicesDelegate {
    func getRunwayInfo(chosenRwy: ChosenRunway)
}

class TOLDReconfiguredViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, MetarDelegate, RunwayChoicesDelegate, TOLDReconfiguredDelegate {
    
    //Temp  :   C: -20 - 50, F: -4 - 122
    //Alt   :   0 - 6000
    //Rwy L :   7000 - 15000
    //Rwy S :   -6 - 6 ????
    //Weight:   11000 - 14000

    // MARK: -
    // MARK: -
    // MARK: LIFE CYCLE
    // MARK: -
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW DID LOAD")
        moc = cdu.moc!
        getCurrentWeather(icao: nil, metarLoc: .home, refreshUI: false)
        getCurrentWeather(icao: nil, metarLoc: .nrst, refreshUI: false)
        clearWeatherFields()
        resetTempToC()
        clearAllFields()
        setHeightOfScroll()
        refreshWeatherOutlet.setTitle("Click to Refresh Weather", for: .normal)//("Refresh Weather: \(currentICAO)", for: .normal)
        aircraftConfigSection = getSetTail(.resetAll)
        setFormatting()
        initialSetup()
        self.hideKeyboardWhenTappedAround()
        for tf in textFields {
            tf.delegate = self
        }
        if let disclaimerPopUp_ = UserDefaults.standard.object(forKey: "disclaimerPopUp") {
            self.disclaimerPopUp = disclaimerPopUp_ as! Bool
        }
        alertPopUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("VIEW WILL APPEAR")
        setHeightOfScroll()
        getCurrentWeather(icao: nil, metarLoc: .home, refreshUI: false)
        getCurrentWeather(icao: nil, metarLoc: .nrst, refreshUI: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("VIEW DID APPEAR")
        setHeightOfScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("VIEW WILL DISAPEAR")
        setHeightOfScroll()
        // TODO: Save current state into Defaults
    }
    
    // MARK: -
    // MARK: -
    // MARK: SetUp Variables
    // MARK: -
    // MARK: -
    var cdu = CoreDataUtilies()
    var jsonD = JSONHandler()
    let locManager = CLLocationManager()
    let reachable = Reachability()
    var moc: NSManagedObjectContext?
    var airportsSorted = [AirfieldCD:Double]()
    var fetchAllAirports: NSFetchRequest<AirfieldCD>?
    let defaults = UserDefaults.standard
    var deviceLat = 0.0
    var deviceLong = 0.0
    var deviceAlt = 0.0
    var airfieldFieldDict = [AirfieldCD:[RunwayCD]]()
    var currentAltSetting = 0.0
    var currentICAO = ""
    var currentMetar = Metar() {didSet {
        print(self.currentMetar)
        fullMetarLabel.text = self.currentMetar.rawText ?? "No Metar Selected"
        }}
    var homeMetar: Metar?
    var nrstMetar: Metar?
    var icaoMetar: Metar?
    var aircraftConfigSection: [Any] = []
    var userInputs: [String] = []
    var calcInputs: [String] = []

    // MARK: Inputs to Told
    //var inputBoolArray: [Bool]    = [rwyL:0, rwyH:1, rwyS:2, temp:3, PA:4, windDir:5, windSp:6, weight:7]
    var inputBoolArray: [Bool]      = [false,false,false,false,false,false,false,false] {didSet {print(self.inputBoolArray)}}
    //Airfield:
    var icao:           String      = "KBAB"    {didSet{calculateTold()}}
    var runwayLength:   Double      = 0         {didSet{calculateTold()}}
    var runwayHeading:  Double      = 0         {didSet{calculateTold()}}
    var runwaySlope:    Double      = 0         {didSet{calculateTold()}}
    //Environmental Conditions:
    var temperature:    Double      = 0         {didSet{calculateTold()}}
    var tempScale:      TempScale   = .C        {didSet{calculateTold()}}
    var pressureAlt:    Double      = 0         {didSet{calculateTold()}}
    var windDir:        Double      = 0         {didSet{calculateTold()}}
    var windSpeed:      Double      = 0         {didSet{calculateTold()}}
    var rcr:            Double      = 23        {didSet{calculateTold()}}
    var aeroBraking:    Bool        = false     {didSet{calculateTold()}}
    var givenEngFailAt: Double      = 0.0       {didSet{calculateTold()}}
    var errorMessages: [String]     = []
    //Aircraft Config:
    var basicWeight:    Double      = 0.0       {didSet{calculateTold()}}
    var podMounted: Bool = false {
        didSet {
            podSectionExpanded = podMounted
            if podMounted == true { podMountedSwitchOutlet.isOn = true}
            if podMounted == false { podMountedSwitchOutlet.isOn = false}
            calculateTold()
        }}
    var podType: PodType                = .wssp {didSet{
        calculateTold()}}
    var podCargoWeight: Double          = 0     {didSet{
        calculateTold()}}
    var crewCompliment: CrewCompliment  = .dual {
        didSet {
            switch crewCompliment {
            case .dual:
                crewComplimentSectionExpanded = false
                calculateTold()
            case .solo:
                crewComplimentSectionExpanded = false
                calculateTold()
            case .dogHouse:
                crewComplimentSectionExpanded = true
                calculateTold()
                
            }}}
    var dogHouseCargoWeight: Double     = 0     {didSet{calculateTold()}}
    var gasWeight: Double               = 3962  {didSet{calculateTold()}}
    var taxiTime: Double                = 10     {didSet{calculateTold()}}
    
    // TODO: Create Display for Error Messages
    // TODO: Make sure weights are correct (DogHouse)
    // TODO: Create [Re-Authorize Location] Button for SMRTY pilots
    // TODO: ICOA Text Go button -> Get Airfield options

    // MARK: -
    // MARK: -
    // MARK: USER INTERFACE
    // MARK: -
    // MARK: - IBOutlets
    //Main View
    @IBOutlet weak var scrollViewMainHeight: NSLayoutConstraint!
    
    @IBAction func printLineUpCard(_ sender: UIButton) {
        print("sadfasdfasdfgasdhae")
        let htmlH = HTMLHandler()
        do {
            if let luc = htmlH.putCalculatedValuesInLineUpCard(callSign_1: "ROPER", callSign_2: "", callSign_3: "", callSign_4: "", callSignNum_1: "22", callSignNum_2: "", callSignNum_3: "", callSignNum_4: "", frontPilot_1: "ELMO", frontPilot_2: "", frontPilot_3: "", frontPilot_4: "", backPilot_1: "ATIS", backPilot_2: "", backPilot_3: "", backPilot_4: "", aircraft_1: "4923", aircraft_2: "", aircraft_3: "", aircraft_4: "", joker: "1.6", bingo: "1.3", macsSpeed: "90", macsDist: "1", ds: "0", rsEf: "128", setos: "172", setosp10: "182", cfl: "7666", eor: ">200", rsBeo: "114", grDnSecg: "178", grUpSecg: "123", pa: "6000", temp: "32°C", winds: "150/10", cieling: "2K", icing: "NONE", show: "11:00", brief: "11:15", step: "11:30", to: "12:00", land: "13:15", missionOb1: "Sight Seeing", missionOb2: "", trainingObj1: "", trainingObj2: "", trainingObj3: "", trainingObj4: "", trainingObj5: "") {
                htmlH.exportHTMLContentToPDF(HTMLContent: luc, view: self)
            }
        } catch {
            print(error)
        }
        
    }
    //Collection Outlets
    @IBOutlet var inputNames: [UILabel]!
    @IBOutlet var subViews: [UIView]!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet var buttonOutlets: [UIButton]!
    @IBOutlet var sliderOutlets: [UISlider]!
    @IBOutlet var rightSideLabels: [UILabel]!
    @IBOutlet var segmentedControls: [UISegmentedControl]!
    // MARK: Title Section:
    @IBOutlet weak var icaoTitleLabel: UILabel!
    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var colorCodingInfoButtonOutlet: UIButton!
    @IBOutlet weak var homeButtonOutlet: UIButton!
    @IBOutlet weak var nrstButtonOutlet: UIButton!
    @IBOutlet weak var clearButtonOutlet: UIButton!
    // MARK: Airfield Section:
    @IBOutlet weak var icaoTextField: UITextField!
    @IBOutlet weak var rwyLengthTextField: UITextField!
    @IBOutlet weak var rwyHeadingTextField: UITextField!
    @IBOutlet weak var rwySlopeTextField: UITextField!
    // MARK: Environmental Section:
    @IBOutlet weak var environmentalControlVertDistance: NSLayoutConstraint!
    @IBOutlet weak var environmentalMainView: UIView!
    @IBOutlet weak var refreshWeatherOutlet: UIButton!
    @IBOutlet weak var tempTextField: UITextField!
    @IBOutlet weak var temperatureSwitchOutlet: UISwitch!
    @IBOutlet weak var tempTitleLabel: UILabel!
    @IBOutlet weak var pressureAltTextField: UITextField!
    @IBOutlet weak var windDirTextField: UITextField!
    @IBOutlet weak var windSpeedTextField: UITextField!
    @IBOutlet weak var rcrSegmentedOutlet: UISegmentedControl!
    @IBOutlet weak var aeroBrakingSwitchOutlet: UISwitch!
    @IBOutlet weak var aeroBrakingTitleLabel: UILabel!
    @IBOutlet weak var fullMetarLabel: UILabel!
    // MARK: Aircraft Configuration Section:
    @IBOutlet weak var aircraftConfigHeightOutlet: NSLayoutConstraint!
    @IBOutlet weak var aircraftConfigSubHeight: NSLayoutConstraint!
    @IBOutlet weak var tailBasicWtTextField: UITextField!
    @IBOutlet weak var tailButtonOutlet: UIButton!
    //Pod
    @IBOutlet weak var podView: UIView!
    @IBOutlet weak var podViewHeight: NSLayoutConstraint!
    @IBOutlet weak var podTypeStackView: UIStackView!
    @IBOutlet weak var podCargoWeightStackView: UIStackView!
    @IBOutlet weak var podStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var podTypeHeight: NSLayoutConstraint!
    @IBOutlet weak var podCargoWeightHeight: NSLayoutConstraint!
    @IBOutlet weak var podMountedSwitchOutlet: UISwitch!
    @IBOutlet weak var podMountedTitleLabel: UILabel!
    @IBOutlet weak var podTypeSegmentedOutlet: UISegmentedControl!
    @IBOutlet weak var podCargoWeightSliderOutlet: UISlider!
    @IBOutlet weak var podCargoWeightLabel: UILabel!
    //crew composition
    @IBOutlet weak var crewComplimentView: UIView!
    @IBOutlet weak var crewComplimentHeight: NSLayoutConstraint!
    @IBOutlet weak var crewComplimentStackHeight: NSLayoutConstraint!
    @IBOutlet weak var dogHouseStackView: UIStackView!
    @IBOutlet weak var crewComplimentSegmentedOutlet: UISegmentedControl!
    @IBOutlet weak var dogHouseCargoWeightSliderOutlet: UISlider!
    @IBOutlet weak var dogHouseLabel: UILabel!
    //fuel - gas
    @IBOutlet weak var gasSliderOutlet: UISlider!
    @IBOutlet weak var gasWeightLabel: UILabel!
    @IBOutlet weak var taxiSliderOutlet: UISlider!
    @IBOutlet weak var taxiTimeLabel: UILabel!
    //total weights
    @IBOutlet weak var rampWeightTitleLabel: UILabel!
    @IBOutlet weak var takeOffWeightTitleLabel: UILabel!
    @IBOutlet weak var weightInfoButtonOutlet: UIButton!
    // MARK: Inputs Section:

    @IBOutlet var resultInputRightSideLabels: [UILabel]!
    @IBOutlet weak var inputsViewMain: UIView!
    // MARK: Results Section:
    @IBOutlet var resultsLeftSideLabels: [UILabel]!
    @IBOutlet var resultsRightSideLabels: [UILabel]!

    @IBOutlet weak var resultsAlertBarView: UIView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var flasherButtonAlertView: FlasherButtonView!
    @IBOutlet weak var alertButtonErrorMessagesOutlet: UIButton!
    @IBOutlet weak var alertButtonLabel1: UILabel!
    @IBOutlet weak var alertButtonLabel2: UILabel!
    @IBOutlet weak var inputFlasherButtonAlertView: FlasherButtonView!
    @IBOutlet weak var inputAlertButtonErrorMessagesOutlet: UIButton!
    @IBOutlet weak var inputAlertButtonLabel1: UILabel!
    @IBOutlet weak var inputAlertButtonLabel2: UILabel!
    @IBOutlet weak var headWindLabel: UILabel!
    @IBOutlet weak var crossWindLabel: UILabel!
    @IBOutlet weak var macsLabel: UILabel!
    @IBOutlet weak var macsDistanceLabel: UILabel!
    @IBOutlet weak var dsLabel: UILabel!
    @IBOutlet weak var rs_efLabel: UILabel!
    @IBOutlet weak var setosLabel: UILabel!
    @IBOutlet weak var speedAtEOR_EF_Label: UILabel!
    @IBOutlet weak var grDnSECGLabel: UILabel!
    @IBOutlet weak var grUpSECGLabel: UILabel!
    @IBOutlet weak var cflLabel: UILabel!
    @IBOutlet weak var nacsLabel: UILabel!
    @IBOutlet weak var rsBeoLabel: UILabel!
    @IBOutlet weak var rotationSpeedLabel: UILabel!
    @IBOutlet weak var takeOffSpeedLabel: UILabel!
    @IBOutlet weak var takeOffDistanceLabel: UILabel!
    @IBOutlet weak var cefsLabel: UILabel!
    @IBOutlet weak var speedAtEOR_GEF_Label: UILabel!
    @IBOutlet weak var drDnSECG_GEF_Label: UILabel!
    @IBOutlet weak var grUpSECG_GEF_Label: UILabel!
    
    @IBOutlet weak var header_headWindLabel: UILabel!
    @IBOutlet weak var header_crossWindLabel: UILabel!
    @IBOutlet weak var header_macsLabel: UILabel!
    @IBOutlet weak var header_macsDistanceLabel: UILabel!
    @IBOutlet weak var header_dsLabel: UILabel!
    @IBOutlet weak var header_rs_efLabel: UILabel!
    @IBOutlet weak var header_setosLabel: UILabel!
    @IBOutlet weak var header_speedAtEOR_EF_Label: UILabel!
    @IBOutlet weak var header_grDnSECGLabel: UILabel!
    @IBOutlet weak var header_grUpSECGLabel: UILabel!
    @IBOutlet weak var header_cflLabel: UILabel!
    @IBOutlet weak var header_nacsLabel: UILabel!
    @IBOutlet weak var header_rsBeoLabel: UILabel!
    @IBOutlet weak var header_rotationSpeedLabel: UILabel!
    @IBOutlet weak var header_takeOffSpeedLabel: UILabel!
    @IBOutlet weak var header_takeOffDistanceLabel: UILabel!
    @IBOutlet weak var header_cefsLabel: UILabel!
    @IBOutlet weak var header_speedAtEOR_GEF_Label: UILabel!
    @IBOutlet weak var header_drDnSECG_GEF_Label: UILabel!
    @IBOutlet weak var header_grUpSECG_GEF_Label: UILabel!
    
    
    @IBOutlet weak var takeOffDistanceStackViewOutlet: UIStackView!
    //GEF
    @IBOutlet weak var givenEngineFailureSliderOutlet: UISlider!
    @IBOutlet weak var givenEngineFailureLabel: UILabel!
    //Results SubViews
    @IBOutlet weak var windLabelSubView: UIView!
    @IBOutlet weak var headWindSubView: UIView!
    @IBOutlet weak var crossWindSubview: UIView!
    @IBOutlet weak var toDataLabelSubView: UIView!
    @IBOutlet weak var macsSubView: UIView!
    @IBOutlet weak var macsDistanceSubView: UIView!
    @IBOutlet weak var dsSubView: UIView!
    @IBOutlet weak var rs_efSubView: UIView!
    @IBOutlet weak var setosSubView: UIView!
    @IBOutlet weak var gefAtRS_EFSubView: UIView!
    @IBOutlet weak var speedAtEORSubView: UIView!
    @IBOutlet weak var gdsecgSubView: UIView!
    @IBOutlet weak var gusecgSubView: UIView!
    @IBOutlet weak var cflSubView: UIView!
    @IBOutlet weak var nacsSubView: UIView!
    @IBOutlet weak var refusalSpeedSubView: UIView!
    @IBOutlet weak var rotationSpeedSubView: UIView!
    @IBOutlet weak var toSubView: UIView!
    @IBOutlet weak var toDistSubView: UIView!
    @IBOutlet weak var cefsSubView: UIView!
    @IBOutlet weak var gefsSubView: UIView!
    @IBOutlet weak var gefSliderSubView: UIView!
    @IBOutlet weak var speedAtEorSubView: UIView!
    @IBOutlet weak var grDownEFSubView: UIView!
    @IBOutlet weak var grUpEFSubView: UIView!
    @IBOutlet var resultsSubviewCollection: [UIView]!
    @IBOutlet weak var iconOutlet: UIImageView!
    @IBOutlet weak var widthCompressedResultDistance: NSLayoutConstraint!
    
    
    // MARK: - IBActions
    // MARK: Title Section:
    @IBAction func colorCodingInfoButton(_ sender: UIButton) {
    }
    
    @IBAction func homeButton(_ sender: UIButton) {
        homeButtonOutlet.showPressed()
        aircraftConfigSection = getSetTail(.getConfig)
        let homeIcao = autoFillWithICAO(icao: .home, icaoFreeText: nil)
        clearWeather()
        getCurrentWeather(icao: homeIcao, metarLoc: .home, refreshUI: false)
        _ = getSetTail(.getConfig)
        }
    
    @IBAction func nearestButton(_ sender: UIButton) {
        nrstButtonOutlet.showPressed()
        aircraftConfigSection = getSetTail(.getConfig)
        let nrstIcao = autoFillWithICAO(icao: .nearest, icaoFreeText: nil)
        clearWeather()
        getCurrentWeather(icao: nrstIcao, metarLoc: .nrst, refreshUI: false)
        _ = getSetTail(.getConfig)
        }
    
    @IBAction func clearButton(_ sender: UIButton) {
        clearButtonOutlet.showPressed()
        clearAllFields()
        clearAlertButton()
        resetTempToC()
        self.currentMetar = Metar()
        refreshWeatherOutlet.setTitle("Click to Refresh Weather", for: .normal)//: \(currentICAO)", for: .normal)
    }
    
    // MARK: Airfield Section:
    @IBAction func icaoVerified(_ sender: UITextField) {
        if let icao = sender.text {
            if sender.text != "" {
                switch verifyIcao(icao) {
                case true:
                    icaoTitleLabel.text = sender.text
                    verifiedTextField(veified: true, sender: sender)
                    _ = autoFillWithICAO(icao: .freeText, icaoFreeText: icao)
                    getCurrentWeather(icao: self.currentICAO, metarLoc: .icao, refreshUI: true)
                case false:
                    icaoTitleLabel.text = " "
                    airportNameLabel.text = " "
                    verifiedTextField(veified: false, sender: sender)
    }}
            else { clearAllFields() }
        }}
    
    //7000 - 15000
    @IBAction func runwayLengthVerification(_ sender: UITextField) {
        let rwyLength = textFieldColorizedVerification(sender: sender, lower: 7000.0, upper: 15000.0)
        inputBoolArray[0] = rwyLength.valid
        runwayLength = rwyLength.value
    }
    
    //0 - 360
    @IBAction func runwayHeadingVerification(_ sender: UITextField) {
        let rwyHeading = textFieldColorizedVerification(sender: sender, lower: 0.0, upper: 360.0)
        inputBoolArray[1] = rwyHeading.valid
        runwayHeading = rwyHeading.value
    }
    
    //-6 - 6
    @IBAction func runwaySlopeVerification(_ sender: UITextField) {
        let rwySlope = textFieldColorizedVerification(sender: sender, lower: -6.0, upper: 6.0)
        inputBoolArray[2] = rwySlope.valid
        runwaySlope = rwySlope.value
    }
    
    // MARK: Environmental Section:
    @IBAction func refreshWeatherButton(_ sender: UIButton) {
        refreshWeatherOutlet.showPressed()
        resetTempToC()
        getCurrentWeather(icao: self.currentICAO, metarLoc: .icao, refreshUI: true)
        setRefreshWxTitleForCurrentIcao(metar: currentMetar)
    }
    //temp
    //-20 - 50 C°
    //-4 - 122 F°
    @IBAction func temperatureVerification(_ sender: UITextField) {
        // TODO: Adjust this so it runs only when the user types
        switch self.tempScale {
        case .C:
            let temp = textFieldColorizedVerification(sender: sender, lower: -20.0, upper: 50.0)
            inputBoolArray[3] = temp.valid
            temperature = temp.value.numberOfDecimalPlaces(0)
        case .F:
            let temp = textFieldColorizedVerification(sender: sender, lower: -4.0, upper: 122.0)
            inputBoolArray[3] = temp.valid
            temperature = temp.value.numberOfDecimalPlaces(0)
        }
    }
    
    @IBAction func temperatureSwitch(_ sender: UISwitch) {
        let temp = Double(tempTextField.text ?? "")
        // TODO: Adjust temperature in textfield based on temp switch
        if sender.isOn {
            tempScale = .C
            tempTitleLabel.text = "C°"
            if temp != nil {
                self.temperature = (temp! - 32)/1.8
                tempTextField.text = ""
                tempTextField.insertText("\(String(format: "%.0f",self.temperature))")
            }
        } else {
            tempScale = .F
            tempTitleLabel.text = "F°"
            if temp != nil {
                self.temperature = (temp! * 1.8) + 32
                tempTextField.text = ""
                tempTextField.insertText("\(String(format: "%.0f",self.temperature))")
            }
        }}
    
    //0 - 6000
    @IBAction func pressureAltVerification(_ sender: UITextField) {
        let pa = textFieldColorizedVerification(sender: sender, lower: 0.0, upper: 6000.0)
        inputBoolArray[4] = pa.valid
        pressureAlt = pa.value
    }
    
    //0 - 360
    @IBAction func windDirectionVerification(_ sender: UITextField) {
        let windDirection = textFieldColorizedVerification(sender: sender, lower: 0.0, upper: 360.0)
        inputBoolArray[5] = windDirection.valid
        windDir = windDirection.value
    }
    
    //0 - 40
    @IBAction func windSpeedVerification(_ sender: UITextField) {
        let windSd = textFieldColorizedVerification(sender: sender, lower: 0.0, upper: 40.0)
        inputBoolArray[6] = windSd.valid
        windSpeed = windSd.value
    }
    
    @IBAction func rcrypeSegment(_ sender: UISegmentedControl) {
        switch rcrSegmentedOutlet.selectedSegmentIndex {
        case 0:
            rcr = 23
        case 1:
            rcr = 12
        case 2:
            rcr = 6
        default:
            print("NO VALID RCR")
        }}
    
    //aerobraking
    @IBAction func aeroBrakingSwitch(_ sender: UISwitch) {
        if sender.isOn {
            aeroBraking = true
            aeroBrakingTitleLabel.text = "Yes"
        } else {
            aeroBraking = false
            aeroBrakingTitleLabel.text = "No"
        }}
    // MARK: Aircraft Configuration Section:
    @IBAction func tailBasicWeightVerification(_ sender: UITextField) {
        calculateTold()
        tailButtonOutlet.setTitle("MANUAL", for: .normal)
        let bw = textFieldColorizedVerification(sender: sender, lower: 0, upper: 9000)
        basicWeight = bw.value
    }
    //Pod
    @IBAction func podMountedSwitch(_ sender: UISwitch) {
        if sender.isOn {
            podSectionExpanded = true
            podMountedTitleLabel.text = "Yes"
            podMounted = true
            resetPodCargoSlider()
        } else {
            podSectionExpanded = false
            podMountedTitleLabel.text = "No"
            podMounted = false
            resetPodCargoSlider()
        }}
    @IBAction func podTypeSegment(_ sender: UISegmentedControl) {
        switch podTypeSegmentedOutlet.selectedSegmentIndex {
        case 0:
            podType = .wssp
            podCargoWeightSliderOutlet.isEnabled = true
            resetPodCargoSlider()
            podCargoWeightSliderOutlet.maximumValue = 140.0
        case 1:
            podType = .MXU_648
            podCargoWeightSliderOutlet.isEnabled = true
            resetPodCargoSlider()
            podCargoWeightSliderOutlet.maximumValue = 300.0
        case 2:
            podType = .AN_ALQ_188
            podCargoWeightSliderOutlet.isEnabled = false
            resetPodCargoSlider()
            podCargoWeightSliderOutlet.maximumValue = 0.0
        default:
            print("NO VALID POD")
        }}
    @IBAction func podCargoWeightSlider(_ sender: UISlider) {
        if podCargoWeightSliderOutlet.isTracking != true {
            podCargoWeight = Double(sender.value)
        }
        let stringValue = "\(String(format: "%.0f",sender.value)) Lbs"
        podCargoWeightLabel.text = stringValue
    }
    //crew composition
    @IBAction func crewComplimentSegment(_ sender: UISegmentedControl) {
        switch crewComplimentSegmentedOutlet.selectedSegmentIndex {
        case 0:
            crewCompliment = .dual
            crewComplimentSectionExpanded = false
        case 1:
            crewCompliment = .solo
            crewComplimentSectionExpanded = false
        case 2:
            crewCompliment = .dogHouse
            crewComplimentSectionExpanded = true
        default:
            print("NO VALID CREW COMPLIMENT")
        }}
    @IBAction func dogHouseSlider(_ sender: UISlider) {
        if dogHouseCargoWeightSliderOutlet.isTracking != true {
            dogHouseCargoWeight = Double(sender.value)
        }
        let stringValue = "\(String(format: "%.0f",sender.value)) Lbs"
        dogHouseLabel.text = stringValue
    }
    //fuel - gas
    @IBAction func gasWeightSlider(_ sender: UISlider) {
        if gasSliderOutlet.isTracking != true {
            gasWeight = Double(sender.value)
        }
        let stringValue = "\(String(format: "%.0f",sender.value)) Lbs"
        gasWeightLabel.text = stringValue
    }
    @IBAction func taxiTimeSlider(_ sender: UISlider) {
        if taxiSliderOutlet.isTracking != true {
            taxiTime = Double(sender.value)
        }
        let stringValue = "\(String(format: "%.0f",sender.value)) min"
        taxiTimeLabel.text = stringValue
    }
    //total weights
    // MARK: Inputs Section:
    // MARK: Results Section:
    @IBAction func alertButtonErrorMessages(_ sender: UIButton) {
    }
    //GEF
    @IBAction func givenEngineFailureSlider(_ sender: UISlider) {
        if givenEngineFailureSliderOutlet.isTracking != true {
            givenEngFailAt = Double(sender.value)
        }
        let stringValue = "\(String(format: "%.0f",sender.value)) kts"
        givenEngineFailureLabel.text = stringValue
    }
    
    var inputsMatch: Bool = true {
        didSet {
            switch inputsMatch {
            case true:
                inputFlasherButtonAlertView.flash(false, initTitle: "MISMATCH", tranTitle: "CLICK HERE", initColor: #colorLiteral(red: 0.8389757276, green: 0.02272814885, blue: 0.01101813931, alpha: 1), tranColor: #colorLiteral(red: 0.999735415, green: 0.1608618796, blue: 0, alpha: 1), mainButtonOutlet: inputAlertButtonErrorMessagesOutlet, firstTitleLabel: inputAlertButtonLabel1, secondTitleLabel: inputAlertButtonLabel2)
            case false:
                inputFlasherButtonAlertView.setInitFormatting(cornerRadius: 5, borderWidth: 1, borderColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), mainButtonOutlet: inputAlertButtonErrorMessagesOutlet, firstTitleLabel: inputAlertButtonLabel1, secondTitleLabel: inputAlertButtonLabel2)
                inputFlasherButtonAlertView.flash(true, initTitle: "MISMATCH", tranTitle: "CLICK HERE", initColor: #colorLiteral(red: 0.8389757276, green: 0.02272814885, blue: 0.01101813931, alpha: 1), tranColor: #colorLiteral(red: 0.999735415, green: 0.1608618796, blue: 0, alpha: 1), mainButtonOutlet: inputAlertButtonErrorMessagesOutlet, firstTitleLabel: inputAlertButtonLabel1, secondTitleLabel: inputAlertButtonLabel2)
            }
        }
    }
    
    // MARK: -
    // MARK: -
    // MARK: Functionality
    // MARK: -
    // MARK: -
    // MARK: Display & General
    func verifiedTextField(veified: Bool, sender: UITextField) {
        sender.layer.borderWidth = 1
        switch veified {
        case true:
            sender.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        case false:
            sender.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }}
    
    func getLocationInformation() {
        if let loc = locManager.location {
            locManager.requestAlwaysAuthorization()
            locManager.requestWhenInUseAuthorization()
            self.deviceLat = loc.coordinate.latitude
            self.deviceLong = loc.coordinate.longitude
            self.deviceAlt = loc.altitude
        }}
    
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
    
    func setRefreshWxTitleForCurrentIcao(metar: Metar) {
        refreshWeatherOutlet.setTitle("Click to Refresh Weather", for: .normal)//("\(metar.stationId ?? "None Available") : \(metar.observationTime ?? "")", for: .normal)
    }
    
    func validInputs() -> Bool {
        var result = false
        if inputBoolArray.contains(false) {
            result = false
        } else {
            result = true
        }
        return result
    }
    
    enum Alert {
        case warning
        case caution
        case note
        case none
    }
    func toldErrorCheckerColorCoder(view: UIView,
                                    subLabels: [UILabel],
                                    level: Alert) {
        //font-family: ".SFUIText"; font-weight: normal; font-style: normal; font-size: 15.00pt)
        var normFont = subLabels[0].font
        let fontName = normFont?.fontName.components(separatedBy: "-").first
        let alertFont = UIFont(name: "\(fontName!)-Semibold", size: normFont!.pointSize)
        normFont = UIFont(name: "\(fontName!)-normal", size: normFont!.pointSize)
        
        switch level {
        case .warning:
            view.backgroundColor = #colorLiteral(red: 0.7468752265, green: 0.1114121601, blue: 0.01761963218, alpha: 1)
            for label in subLabels {
                label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                label.font = alertFont
            }
        case .caution:
            view.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            for label in subLabels {
                label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                label.font = alertFont
            }
        case .note:
            view.backgroundColor = .clear
            for label in subLabels {
                label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                label.font = normFont
            }
        case .none:
            view.backgroundColor = .clear
            for label in subLabels {
                label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                label.font = normFont
            }
        }
    }
    
    func toldErrorCheckerColorCoderWithAttText(view: UIView,
                                               subLabels: [UILabel],
                                               level: Alert) {
        //font-family: ".SFUIText"; font-weight: normal; font-style: normal; font-size: 15.00pt)
        var normFont = subLabels[0].font
        let fontName = normFont?.fontName.components(separatedBy: "-").first
        let alertFont = UIFont(name: "\(fontName!)-Semibold", size: normFont!.pointSize)
        normFont = UIFont(name: "\(fontName!)-normal", size: normFont!.pointSize)
        
        switch level {
        case .warning:
            view.backgroundColor = #colorLiteral(red: 0.7468752265, green: 0.1114121601, blue: 0.01761963218, alpha: 1)
            for label in subLabels {
                label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                label.font = alertFont
            }
        case .caution:
            view.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            for label in subLabels {
                label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                label.font = alertFont
            }
        case .note:
            view.backgroundColor = .clear
            for label in subLabels {
                label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                label.font = normFont
            }
        case .none:
            view.backgroundColor = .clear
            for label in subLabels {
                label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                label.font = normFont
            }
        }
    }
    
    func setResultAttText(result: String, unit: ResultUnit) -> NSMutableAttributedString {
        let resultAtt = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)]
        let unitAtt = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .thin)]
        let resultAttStr = NSAttributedString(string: result, attributes: resultAtt)
        let unitAttStr = NSAttributedString(string: unit.rawValue, attributes: unitAtt)
        let title = NSMutableAttributedString()
        title.append(resultAttStr)
        title.append(unitAttStr)
        return title
    }
  
    func updateResultsDisplayed(validInputs: Bool, inputs: TOLDInputs) {
        switch validInputs {
        case true:
            clearResults()
            let results = inputs.getResults()
            
//            headWindLabel.attributedText = setResultAttText(result: results.headWind!, unit: .kias)      //setResultAttText(result: results.headWind!, unit: " KIAS")
//            crossWindLabel.attributedText = setResultAttText(result: results.crossWind!, unit: .kias)  // + " KIAS"
//            macsLabel.attributedText = setResultAttText(result: results.macs!, unit: .kias)  // + " KIAS"
//            macsDistanceLabel.attributedText = setResultAttText(result: results.macsDistance!, unit: .ft)  // + " FT"
//            dsLabel.attributedText = setResultAttText(result: results.decisionSpeed!, unit: .kias)  // + " KIAS"
//            rs_efLabel.attributedText = setResultAttText(result: results.refusalSpeed_EF!, unit: .kias)  // + " KIAS"
//            setosLabel.attributedText = setResultAttText(result: results.setos!, unit: .kias)  // + " KIAS"
//            speedAtEOR_EF_Label.attributedText = setResultAttText(result: results.speedAtEndOfRunway!, unit: .kias)  // + " KIAS"
//            grDnSECGLabel.attributedText = setResultAttText(result: results.gearDnSECG!, unit: .ftpmn)  // + " FT/NM"
//            grUpSECGLabel.attributedText = setResultAttText(result: results.gearUpSECG!, unit: .ftpmn)  // + " FT/NM"
//            cflLabel.attributedText = setResultAttText(result: results.criticalFieldLength!, unit: .ft)  // + " FT"
//            nacsLabel.attributedText = setResultAttText(result: results.nacs!, unit: .kias)  // + " KIAS"
//            rsBeoLabel.attributedText = setResultAttText(result: results.refusalSpeedBEO!, unit: .kias)  // + " KIAS"
//            rotationSpeedLabel.attributedText = setResultAttText(result: results.rotationSpeed!, unit: .kias)  // + " KIAS"
//            takeOffSpeedLabel.attributedText = setResultAttText(result: results.takeoffSpeed!, unit: .kias)  // + " KIAS"
//            takeOffDistanceLabel.attributedText = setResultAttText(result: results.takeoffDistance!, unit: .ft)  // + " FT"
//            cefsLabel.attributedText = setResultAttText(result: results.criticalEngineFailureSpeed!, unit: .kias)  // + " KIAS"
//            speedAtEOR_GEF_Label.attributedText = setResultAttText(result: results.SpeedAtEndOfRunway_EF!, unit: .kias)
//            drDnSECG_GEF_Label.attributedText = setResultAttText(result: results.gearDnSECG_EF!, unit: .ftpmn)
//            grUpSECG_GEF_Label.attributedText = setResultAttText(result: results.gearUpSECG_EF!, unit: .ftpmn)
            
            headWindLabel.text = results.headWind ?? "" + " KIAS"
            crossWindLabel.text = results.crossWind ?? "" + " KIAS"
            macsLabel.text = results.macs ?? "" + " KIAS"
            macsDistanceLabel.text = results.macsDistance ?? "" + " FT"
            dsLabel.text = results.decisionSpeed ?? "" + " KIAS"
            rs_efLabel.text = results.refusalSpeed_EF ?? "" + " KIAS"
            setosLabel.text = results.setos ?? "" + " KIAS"
            speedAtEOR_EF_Label.text = results.speedAtEndOfRunway ?? "" + " KIAS"
            grDnSECGLabel.text = results.gearDnSECG ?? "" + " FT/NM"
            grUpSECGLabel.text = results.gearUpSECG ?? "" + " FT/NM"
            cflLabel.text = results.criticalFieldLength ?? "" + " FT"
            nacsLabel.text = results.nacs ?? "" + " KIAS"
            rsBeoLabel.text = results.refusalSpeedBEO ?? "" + " KIAS"
            rotationSpeedLabel.text = results.rotationSpeed ?? "" + " KIAS"
            takeOffSpeedLabel.text = results.takeoffSpeed ?? "" + " KIAS"
            takeOffDistanceLabel.text = results.takeoffDistance ?? "" + " FT"
            cefsLabel.text = results.criticalEngineFailureSpeed ?? "" + " KIAS"
            speedAtEOR_GEF_Label.text = results.SpeedAtEndOfRunway_EF ?? "" + " KIAS"
            drDnSECG_GEF_Label.text = results.gearDnSECG_EF ?? "" + " FT/NM"
            grUpSECG_GEF_Label.text = results.gearUpSECG_EF ?? "" + " FT/NM"
            if let toDistance = results.takeoffDistance {
                let toDistRatio = (Double(toDistance) ?? 0)/self.runwayLength
                switch toDistRatio {
                case _ where toDistRatio >= 0.8:
                    toldErrorCheckerColorCoder(view: toDistSubView, subLabels: [takeOffDistanceLabel, header_takeOffDistanceLabel], level: .warning)
                case _ where toDistRatio >= 0.7:
                    toldErrorCheckerColorCoder(view: toDistSubView, subLabels: [takeOffDistanceLabel, header_takeOffDistanceLabel], level: .caution)
                default:
                    toldErrorCheckerColorCoder(view: toDistSubView, subLabels: [takeOffDistanceLabel, header_takeOffDistanceLabel], level: .none)
                }
            }
            var errorArray: [String] = []
            if let errorMessages = results.ErrorMessages {
                if errorMessages.isEmpty != true {
                    for error in errorMessages {
                        var temp: [String] = []
                        if let er = error {
                            temp = (String(describing: er).components(separatedBy: ","))
                        }
                        for i in temp {
                            errorArray.append(i)
                        }}}
                self.errorMessages = errorArray
                for i in self.errorMessages {
                    let replaceStr = self.errorMessages.firstIndex(of: i)
                    self.errorMessages[replaceStr!] = i.removingLeadingSpaces()
                }
                self.errorMessages = self.errorMessages.filter({$0 != "CEFS > SETOS"})
                print(self.errorMessages)
                if self.errorMessages.count > 0 {
                    flasherButtonAlertView.setInitFormatting(cornerRadius: 5, borderWidth: 1, borderColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), mainButtonOutlet: alertButtonErrorMessagesOutlet, firstTitleLabel: alertButtonLabel1, secondTitleLabel: alertButtonLabel2)
                    
                    widthCompressedResultDistance.constant = 50
                    
                    flasherButtonAlertView.flash(true, initTitle: "WARNING", tranTitle: "CLICK HERE", initColor: #colorLiteral(red: 0.7495667338, green: 0.1121872589, blue: 0.01655624434, alpha: 1), tranColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), mainButtonOutlet: alertButtonErrorMessagesOutlet, firstTitleLabel: alertButtonLabel1, secondTitleLabel: alertButtonLabel2)
                    
                } else {
                    clearAlertButton()
                }
                
                if self.errorMessages.contains("CEFS may be Invalid") {
                    toldErrorCheckerColorCoder(view: cefsSubView, subLabels: [cefsLabel, header_cefsLabel],
                                               level: .caution)
                } else {
                    toldErrorCheckerColorCoder(view: cefsSubView, subLabels: [cefsLabel, header_cefsLabel],
                                               level: .none)
                }
                
                if self.errorMessages.contains("DS > RS-EF") && self.errorMessages.contains("DS > TOS") {
                    toldErrorCheckerColorCoder(view: dsSubView, subLabels: [dsLabel, header_dsLabel],
                                               level: .warning)
                    toldErrorCheckerColorCoder(view: rs_efSubView, subLabels: [rs_efLabel, header_rs_efLabel],
                                               level: .warning)
                    toldErrorCheckerColorCoder(view: toSubView, subLabels: [takeOffSpeedLabel, header_takeOffSpeedLabel],
                                               level: .warning)
                } else if self.errorMessages.contains("DS > RS-EF") {
                    toldErrorCheckerColorCoder(view: dsSubView, subLabels: [dsLabel, header_dsLabel],
                                               level: .warning)
                    toldErrorCheckerColorCoder(view: rs_efSubView, subLabels: [rs_efLabel, header_rs_efLabel],
                                               level: .warning)
                } else if self.errorMessages.contains("DS > TOS") {
                    toldErrorCheckerColorCoder(view: dsSubView, subLabels: [dsLabel, header_dsLabel],
                                               level: .warning)
                    toldErrorCheckerColorCoder(view: toSubView, subLabels: [takeOffSpeedLabel, header_takeOffSpeedLabel],
                                               level: .warning)
                } else {
                    toldErrorCheckerColorCoder(view: dsSubView, subLabels: [dsLabel, header_dsLabel],
                                               level: .none)
                    toldErrorCheckerColorCoder(view: rs_efSubView, subLabels: [rs_efLabel, header_rs_efLabel],
                                               level: .none)
                    toldErrorCheckerColorCoder(view: toSubView, subLabels: [takeOffSpeedLabel, header_takeOffSpeedLabel],
                                               level: .none)
                }
                
                if self.errorMessages.contains("Speed at EOR < SETOS + 10") {
                    toldErrorCheckerColorCoder(view: speedAtEORSubView, subLabels: [speedAtEOR_EF_Label, header_speedAtEOR_EF_Label],
                                               level: .warning)
                    toldErrorCheckerColorCoder(view: setosSubView, subLabels: [setosLabel, header_setosLabel],
                                               level: .warning)
                } else {
                    toldErrorCheckerColorCoder(view: speedAtEORSubView, subLabels: [speedAtEOR_EF_Label, header_speedAtEOR_EF_Label],
                                               level: .none)
                    toldErrorCheckerColorCoder(view: setosSubView, subLabels: [setosLabel, header_setosLabel],
                                               level: .none)
                }
                
                
                
                
                
                
            }
            
        case false:
            for i in 0...resultsRightSideLabels.count - 1 {
                resultsRightSideLabels[i].text = "---"
            }}}
    
    // MARK: Clearings
    func clearAllFields() {
        for view in resultsSubviewCollection {
            view.backgroundColor = .clear
        }
        rcrSegmentedOutlet.selectedSegmentIndex = 0
        crewComplimentSegmentedOutlet.selectedSegmentIndex = 0
        aircraftConfigSection = getSetTail(.resetAll)
        for textField in textFields {
            textField.text = nil
            setFormatting()
            icaoTitleLabel.text = " "
            airportNameLabel.text = " "
        }
        for i in 0...resultsRightSideLabels.count - 1 {
            resultsRightSideLabels[i].text = "--"
            resultsLeftSideLabels[i].adjustsFontSizeToFitWidth = true
            resultsRightSideLabels[i].adjustsFontSizeToFitWidth = true
        }
        self.basicWeight = 0
        tailButtonOutlet.setTitle("TAIL", for: .normal)
        clearResults()
        setFormatting()
        calculateTold()
    }
    
    func clearRunwayFields() {
        icaoTextField.text = ""
        rwyLengthTextField.text = ""
        rwyHeadingTextField.text = ""
        rwySlopeTextField.text = ""
    }

    func clearWeather() {
        fullMetarLabelFormatting(available: false)
        let wxTextFields = [tempTextField,pressureAltTextField,windDirTextField,windSpeedTextField]
        for textField in wxTextFields {
            textField?.text = nil
            textField?.layer.borderColor = #colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1)
        }}
    
    func clearWeatherFields() {
        tempTextField.text = ""
        pressureAltTextField.text = ""
        windDirTextField.text = ""
        windSpeedTextField.text = ""
    }
    
    func clearAlertButton() {
        alertButtonErrorMessagesOutlet.isHidden = true
        alertButtonErrorMessagesOutlet.isEnabled = false
        alertButtonErrorMessagesOutlet.backgroundColor = .clear
        alertButtonErrorMessagesOutlet.setTitle("", for: .normal)
        widthCompressedResultDistance.constant = 10
        flasherButtonAlertView.flash(false, initTitle: "WARNING", tranTitle: "CLICK HERE", initColor: #colorLiteral(red: 0.8389757276, green: 0.02272814885, blue: 0.01101813931, alpha: 1), tranColor: #colorLiteral(red: 0.999735415, green: 0.1608618796, blue: 0, alpha: 1), mainButtonOutlet: alertButtonErrorMessagesOutlet, firstTitleLabel: alertButtonLabel1, secondTitleLabel: alertButtonLabel2)
    }
    
    func clearResults() {
        clearAlertButton()
        for view in resultsSubviewCollection {
            view.backgroundColor = .clear
            toldErrorCheckerColorCoder(view: view, subLabels: resultsLeftSideLabels, level: .none)
            toldErrorCheckerColorCoder(view: view, subLabels: resultsRightSideLabels, level: .none)
        }
    }
    
    // MARK: Airfield Database Handling
    enum HomeNearest {
        case home
        case nearest
        case freeText
    }
    
    func autoFillWithICAO(icao: HomeNearest, icaoFreeText: String?) -> String {
        aircraftConfigSection = getSetTail(.resetAll)
        var result = ""
        switch icao {
        case .home:
            let homeIcao = cdu.getUserSettings().homeAirfieldICAO_UD
            if verifyIcao(homeIcao) {
                self.airfieldFieldDict = cdu.getAirfieldByICAO(homeIcao, moc: moc!)
                if let metar = self.homeMetar { self.currentMetar = metar }
                runwayPopUp()
                self.currentICAO = homeIcao
            } else {
                alert(title: "HOME ICAO not in Database",
                      message: "Please set \"Home Station ICAO\" field in Settings > User Defaults",
                      buttonTitle: "OK")
            }
            result = homeIcao
        case .nearest:
            let nrstIcao = fetchAndSortByDistance()[0].icao_CD ?? "KDXR"
            self.airfieldFieldDict = cdu.getAirfieldByICAO(nrstIcao, moc: moc!)
            if let metar = self.nrstMetar { self.currentMetar = metar }
            runwayPopUp()
            self.currentICAO = nrstIcao
            result = nrstIcao
        case .freeText:
            guard let icao_ = icaoFreeText else { break }
            self.airfieldFieldDict = cdu.getAirfieldByICAO(icao_, moc: moc!)
            if let metar = self.icaoMetar { self.currentMetar = metar }
            runwayPopUp()
            self.currentICAO = icao_
            result = icao_
        }
        return result
    }
    
    func fetchAndSortByDistance() -> [AirfieldCD] {
        var airfieldReturn: [AirfieldCD] = []
        var airfields: [AirfieldCD] = []
        getLocationInformation()
        do {
            airfields = cdu.getAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(moc: moc!)
            var preSorted = [AirfieldCD:Double]()
            for airport in airfields {
                let dictValue = cdu.distanceAway(deviceLat: deviceLat, deviceLong: deviceLong, airport: airport).airport
                let dictKey = cdu.distanceAway(deviceLat: deviceLat, deviceLong: deviceLong, airport: airport).distanceAway
                preSorted.updateValue(dictKey, forKey: dictValue)
            }
            let airportICAO = preSorted.keys.sorted{preSorted[$0]! < preSorted[$1]!}
            airfieldReturn = airportICAO.filter({$0.icao_CD != "" })
        }
        return airfieldReturn
    }
    
    func verifyIcao(_ icao: String) -> Bool {
        var result = false
        let afd = cdu.getAirfieldByICAO(icao, moc: moc!)
        if afd.count != 0 {
            result = true
        } else {
            result = false
        }
        return result
    }
    
    func setAndFillInRunwayInfo(chosenRwy: ChosenRunway) {
        clearRunwayFields()
        self.rcr = 23
        airportNameLabel.text = chosenRwy.airfieldName
        icaoTitleLabel.text = "\(chosenRwy.icao) \(chosenRwy.runwayName)"
//        icaoTextField.insertText(chosenRwy.icao)
        icaoTextField.text = "\(chosenRwy.icao)"
        rwyLengthTextField.insertText("\(String(format: "%.0f",chosenRwy.runwayLength))")
        rwyHeadingTextField.insertText("\(String(format: "%.0f",chosenRwy.runwayHeading))")
        rwySlopeTextField.insertText("\(String(format: "%.1f",chosenRwy.runwaySlope))")
    }
    
    func determinWhichMetarToUse() -> Metar {
        var result = Metar()
        if self.currentICAO == cdu.getUserSettings().homeAirfieldICAO_UD {
            result = homeMetar ?? Metar()
        } else if self.currentICAO == fetchAndSortByDistance()[0].icao_CD {
            result = nrstMetar ?? Metar()
        } else {
            result = icaoMetar ?? Metar()
        }
        return result
    }
    
    //Delegate Function
    func getRunwayInfo(chosenRwy: ChosenRunway) {
        rcrSegmentedOutlet.selectedSegmentIndex = 0
        setAndFillInRunwayInfo(chosenRwy: chosenRwy)
        setAndFillInWeatherInfo(determinWhichMetarToUse())
    }
    
    // MARK: Weather Handling
    //Step 1: Downloading current weather
    func getCurrentWeather(icao: String?, metarLoc: MetarLoc, refreshUI: Bool)  {
        if reachable.isConnectedToNetowrk() {
            switch metarLoc {
            case .home:
                let homeIcao = cdu.getUserSettings().homeAirfieldICAO_UD
                if verifyIcao(homeIcao) {
                    var ms = MetarDownLoader(icao: homeIcao, delagate: self, metarLoc: .home, refreshUI: refreshUI)
                    ms.delagate = self
                }
            case .nrst:
                getLocationInformation()
                let nrstAirField = fetchAndSortByDistance()
                if nrstAirField.count != 0 {
                    let nrstIcao = nrstAirField[0].icao_CD
                    var ms = MetarDownLoader(icao: nrstIcao!, delagate: self, metarLoc: .nrst, refreshUI: refreshUI)
                    ms.delagate = self
                }
            case .icao:
                if verifyIcao(icao ?? "x") {
                    var ms = MetarDownLoader(icao: icao!, delagate: self, metarLoc: .icao, refreshUI: refreshUI)
                    ms.delagate = self
    }}}}
    
    //Step 2: Delegate function done on main thread after download complete
    func getCurrentMetar(_ metar: [Metar]?, metarLoc: MetarLoc, refreshUI: Bool) {
        switch metarLoc {
        case .home:
            if let metar = metar { if metar.count > 0 { homeMetar = metar[0]}} else { homeMetar = Metar() }
            if homeMetar?.isNil == false && refreshUI {setAndFillInWeatherInfo(homeMetar!)}
        case .nrst:
            if let metar = metar { if metar.count > 0 { nrstMetar = metar[0] }} else { nrstMetar = Metar() }
            if nrstMetar?.isNil == false && refreshUI { setAndFillInWeatherInfo(nrstMetar!)}
        case .icao:
            if let metar = metar { if metar.count > 0 { icaoMetar = metar[0] }} else { icaoMetar = Metar() }
            if icaoMetar?.isNil == false && refreshUI { setAndFillInWeatherInfo(icaoMetar!)}
    }
    }
    
    func setAndFillInWeatherInfo(_ metar: Metar) {
        clearWeather()
        if metar.isNil != true {
            fullMetarLabelFormatting(available: true)
            self.currentMetar = metar
            let altSetting = Double(metar.altimeterInHg ?? "99999.5")
            let fieldElev = Double(metar.elevationM ?? "99999.5")?.metersToFeet
            var pressAlt = calcPressureAlt(altSetting: altSetting!, fieldElevation: fieldElev!)
            if pressAlt < 0 { pressAlt = 0 }
            resetTempToC()
            if let temp = metar.tempC {
                let tempA = Double(temp)?.numberOfDecimalPlaces(0)
                tempTextField.insertText("\(tempA ?? 99999.5)")
            }
            pressureAltTextField.insertText("\(String(format: "%.0f", pressAlt))")
            windDirTextField.insertText(metar.windDirDegrees ?? "99999.5")
            windSpeedTextField.insertText(metar.windSpeedKts ?? "99999.5")
            setRefreshWxTitleForCurrentIcao(metar: metar)
        } else {
            fullMetarLabelFormatting(available: false)
        }
    }
    
    func resetTempToC() {
        self.tempScale = .C
        temperatureSwitchOutlet.isOn = true
        tempTitleLabel.text = "C°"
    }
    
    // MARK: Aircraft Configuration Handling
    func getChosenTail(tailTitle: String, basicWeight: Double) {
        self.basicWeight = basicWeight
        tailBasicWtTextField.text = ""
        tailBasicWtTextField.insertText("\(String(format: "%.0f",basicWeight))")
        tailButtonOutlet.setTitle(tailTitle, for: .normal)
    }
    
    public enum GetSetConfig {
        case resetAll
        case getConfig
        case setConfig
    }
    
    func getSetTail(_ getSet: GetSetConfig) -> [Any] {
        var result: [Any] = []
        switch getSet {
        case .resetAll:
            adjustACConfigSectionHeight(podExpanded: false, crewComplExpanded: false)
            basicWeight = 0.0
            podMounted = false
            podType = .wssp
            podCargoWeight = 0.0
            crewCompliment = .dual
            dogHouseCargoWeight = 0.0
            gasWeight = 3962
            taxiTime = 10
            tailBasicWtTextField.layer.borderWidth = 0.8
            tailBasicWtTextField.layer.borderColor = #colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1)
            adjustACConfigSectionHeight(podExpanded: false, crewComplExpanded: false)
            tailBasicWtTextField.text = ""
            tailButtonOutlet.setTitle("TAIL", for: .normal)
            
            podMountedSwitchOutlet.isOn = false
            podMountedTitleLabel.text = "No"
            podTypeSegmentedOutlet.selectedSegmentIndex = 0
            podCargoWeightSliderOutlet.value = 0
            podCargoWeightLabel.text = "0 Lbs"
            crewComplimentSegmentedOutlet.selectedSegmentIndex = 0
            dogHouseCargoWeightSliderOutlet.value = 0
            dogHouseLabel.text = "0 Lbs"
            gasSliderOutlet.value = 3962
            gasWeightLabel.text = "3962 Lbs"
            taxiSliderOutlet.value = 10
            taxiTimeLabel.text = "10 mins"
            return result
        case .getConfig:
            let basicWeightInTextFieldState = tailBasicWtTextField.text
            let tailButtonTitleState = tailButtonOutlet.currentTitle
            let podSwitchState = podMountedSwitchOutlet.isOn
            let podMountedLabelState = podMountedTitleLabel.text
            let podTypeSegControlState = podTypeSegmentedOutlet.selectedSegmentIndex
            let podCargoWeightSliderState = podCargoWeightSliderOutlet.value
            let podCargoWeightLabelState = podCargoWeightLabel.text
            let crewComplimentSegControlState = crewComplimentSegmentedOutlet.selectedSegmentIndex
            let dogHousSliderState = dogHouseCargoWeightSliderOutlet.value
            let dogHouseCargorLabelState = dogHouseLabel.text
            let fuelWeightSliderState = gasSliderOutlet.value
            let fuelWeightLabelState = gasWeightLabel.text
            let taxiTimeSliderState = taxiSliderOutlet.value
            let taxiTimeLabelState = taxiTimeLabel.text
            result = [basicWeightInTextFieldState as Any,
                      tailButtonTitleState as Any,
                       podSwitchState,
                       podMountedLabelState as Any,
                       podTypeSegControlState,
                       podCargoWeightSliderState,
                       podCargoWeightLabelState as Any,
                       crewComplimentSegControlState,
                       dogHousSliderState,
                       dogHouseCargorLabelState as Any,
                       fuelWeightSliderState,
                       fuelWeightLabelState as Any,
                       taxiTimeSliderState,
                       taxiTimeLabelState as Any]
            return result
        case .setConfig:
            if self.aircraftConfigSection.count != 0 {
                tailBasicWtTextField.insertText(aircraftConfigSection[0] as? String ?? "")    ///text = aircraftConfigSection[0] as? String
                tailButtonOutlet.setTitle(aircraftConfigSection[1] as? String, for: .normal)
                podMountedSwitchOutlet.isOn = aircraftConfigSection[2] as! Bool
                podMountedTitleLabel.text = aircraftConfigSection[3] as? String
                podTypeSegmentedOutlet.selectedSegmentIndex = aircraftConfigSection[4] as! Int
                podCargoWeightSliderOutlet.value = aircraftConfigSection[5] as! Float
                podCargoWeightLabel.text = aircraftConfigSection[6] as? String
                crewComplimentSegmentedOutlet.selectedSegmentIndex = aircraftConfigSection[7] as! Int
                dogHouseCargoWeightSliderOutlet.value = aircraftConfigSection[8] as! Float
                dogHouseLabel.text = aircraftConfigSection[9] as? String
                gasSliderOutlet.value = aircraftConfigSection[10] as! Float
                gasWeightLabel.text = aircraftConfigSection[11] as? String
                taxiSliderOutlet.value = aircraftConfigSection[12] as! Float
                taxiTimeLabel.text = aircraftConfigSection[13] as? String
            }
            result = aircraftConfigSection
        }
        return result
    }
    
    func resetPodCargoSlider(){
        podCargoWeightSliderOutlet.value = 0.0
        podCargoWeightLabel.text = "\(String(format: "%.0f",podCargoWeightSliderOutlet.value)) lbs"
    }
    
    // MARK: CALCULATIONS
    func calculateTold() {
        // TODO: Set ChosenRwy Info Here
        print(basicWeight)
        let inputs = TOLDInputs(aerobrake: aeroBraking,
                                aircraftBasicWeight: basicWeight,
                                podMounted: podMounted,
                                podType: podType,
                                podCargoWeight: podCargoWeight,
                                crewCompliment: crewCompliment,
                                dogHouseCargoWeight: dogHouseCargoWeight,
                                gasWeight: gasWeight,
                                taxiTime: taxiTime,
                                temperature: temperature,
                                temperatureScale: tempScale,
                                pressureAlt: pressureAlt,
                                runwayLength: runwayLength,
                                runwayHeading: runwayHeading,
                                windDirection: windDir,
                                windVelocity: windSpeed,
                                runwaySlope: runwaySlope,
                                rcr: rcr,
                                givenEngFailAt: givenEngFailAt)
        
        //11000 - 14000
        if inputs.takeOffWeight < 11000 {
            takeOffWeightTitleLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            inputBoolArray[7] = false
        } else {
            takeOffWeightTitleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            inputBoolArray[7] = true
        }
        
        switch inputBoolArray[7] {
        case true:
            rampWeightTitleLabel.text = "\(String(format: "%.0f",inputs.rampWeight))"
            takeOffWeightTitleLabel.text = "\(String(format: "%.0f",inputs.takeOffWeight))"
        case false:
            rampWeightTitleLabel.text = "----"
            takeOffWeightTitleLabel.text = "Out Of Limits"
        }
        
        if validInputs() {
            let inputValidation = checkInputsUsedMatchUserInputs(inputs.jsInputs)
            inputsMatch = inputValidation.valid
            userInputs = inputValidation.userInputs
            calcInputs = inputValidation.calcInputs
            print("USER INPUTS:  \(inputValidation.userInputs)")
            print("CALC INPUTS:  \(inputValidation.calcInputs)")
            print("INPUTS VALID: \(inputValidation.valid)")
            setColorOfResultsLabelText(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            updateResultsDisplayed(validInputs: true, inputs: inputs)
        } else {
            inputsMatch = true
            setColorOfResultsLabelText(color: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
            updateResultsDisplayed(validInputs: false, inputs: inputs)
    }}
    
    func calcPressureAlt(altSetting: Double, fieldElevation: Double) -> Double {
        let pa = ((29.92 - altSetting) * 1000) + fieldElevation
        return pa
    }
    
    func runwayPopUp() {
        performSegue(withIdentifier: "runwayChoicesSequeReconf", sender: nil)
    }
    
    
    // MARK: -
    // MARK: -
    // MARK: Interface and Formatting
    // MARK: -
    // MARK: -
    
    // MARK: - Navigation:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        popOverFormat(segue, sender: sender)
        switch segue.identifier {
        case "inputAlert"?:
            let dvc = segue.destination as! InputAlertTableViewController
            dvc.calcInputs = calcInputs
            dvc.userInputs = userInputs
        case "runwayChoicesSequeReconf"?:
            let dvc = segue.destination as! RunwayChoicesTableViewController
            dvc.metar = currentMetar
            dvc.currentFieldDict = airfieldFieldDict
            dvc.chosenRunwayDelegate = self
        case "windSequeReconfig"?:
            if let popoverPresentationController = segue.destination.popoverPresentationController, let sourceView = sender as? UIView {
                popoverPresentationController.sourceRect = sourceView.bounds
            }
        case "getTailSegue":
            let dvc = segue.destination as! TailTableViewController
            dvc.chosenTailDelegate = self
        case "errorMessagesSegue":
            let dvc = segue.destination as! ErrorTableViewController
            dvc.errorMessages = self.errorMessages
        default:
            preconditionFailure("Unexpected segue identifier")
    }}
    
    // MARK: - Formatting:
    func setFormatting() {
        clearAlertButton()
        refreshWeatherOutlet.isHidden = true
        fullMetarLabelFormatting(available: false)
        icaoTitleLabel.adjustsFontSizeToFitWidth = true
        let borderColor: CGColor = #colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1)
        let cornerRadius: CGFloat = 5
        for view in subViews {
            view.layer.borderColor = borderColor
            view.layer.borderWidth = 1
            view.backgroundColor = #colorLiteral(red: 0.8653005958, green: 0.8654461503, blue: 0.8652814031, alpha: 1)
            view.layer.cornerRadius = cornerRadius
        }
        for textField in textFields {
            textField.layer.borderWidth = 0.8
            textField.layer.borderColor = borderColor
        }
        for sw in switches {
            sw.onTintColor = UIColor(cgColor: borderColor)
            sw.tintColor = UIColor(cgColor: borderColor)
        }
        for button in buttonOutlets {
            button.standardButtonFormatting()
            button.layer.cornerRadius = cornerRadius
            button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        }
        for slider in sliderOutlets {
            slider.tintColor = UIColor(cgColor: borderColor)
        }
        for label in rightSideLabels {
            label.adjustsFontSizeToFitWidth = true
        }
        for label in inputNames {
            label.adjustsFontSizeToFitWidth = true
        }
        for segCont in segmentedControls{
            segCont.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            segCont.layer.masksToBounds = true
            segCont.clipsToBounds = true
        }
        for label in resultsLeftSideLabels {
            label.font = UIFont.systemFont(ofSize: 15)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .left
        }
        for label in resultsRightSideLabels {
            label.font = UIFont.systemFont(ofSize: 15)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .right
        }
        
        let resultHeaders = [windLabelSubView, toDataLabelSubView, gefAtRS_EFSubView, gefsSubView]
        for view in resultHeaders {
            view?.backgroundColor = #colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1)
        }
        podView.layer.borderWidth = 0.5
        podView.layer.borderColor = borderColor
        crewComplimentView.layer.borderWidth = 0.5
        crewComplimentView.layer.borderColor = borderColor
        clearButtonOutlet.layer.cornerRadius = cornerRadius
        refreshWeatherOutlet.layer.cornerRadius = 3
        colorCodingInfoButtonOutlet.layer.cornerRadius = colorCodingInfoButtonOutlet.frame.width/2
    }
    
    public enum ResultUnit: String {
        case kias = " KIAS"
        case ftpmn = " FT/MN"
        case ft = " FT"
    }
    
    func fullMetarLabelFormatting(available: Bool) {
        switch available {
        case true:
            environmentalControlVertDistance.constant = 50
            fullMetarLabel.drawText(in: fullMetarLabel.frame.insetBy(dx: 5, dy: 5))
            fullMetarLabel.adjustsFontSizeToFitWidth = true
            fullMetarLabel.isHidden = false
            fullMetarLabel.layer.borderColor = #colorLiteral(red: 0.262745098, green: 0.2862745098, blue: 0.3529411765, alpha: 1)
            fullMetarLabel.layer.borderWidth = 1
            fullMetarLabel.layer.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            fullMetarLabel.layer.cornerRadius = 5
        case false:
            environmentalControlVertDistance.constant = 10
            fullMetarLabel.isHidden = true
        }}
    
    func setColorOfResultsLabelText(color: UIColor) {
        for i in 0...resultsRightSideLabels.count - 1 {
            resultsRightSideLabels[i].textColor = color
        }}
    
    func setHeightOfScroll() {
        switch self.view.traitCollection.horizontalSizeClass {
        case .compact:
            rcrSegmentedOutlet.setTitle("23", forSegmentAt: 0)
            rcrSegmentedOutlet.setTitle("12", forSegmentAt: 1)
            rcrSegmentedOutlet.setTitle("5", forSegmentAt: 2)
            crewComplimentSegmentedOutlet.setTitle("DH", forSegmentAt: 2)
            scrollViewMainHeight.constant = 1900
            
        default:
            rcrSegmentedOutlet.setTitle("Dry (23)", forSegmentAt: 0)
            rcrSegmentedOutlet.setTitle("Wet (12)", forSegmentAt: 1)
            rcrSegmentedOutlet.setTitle("Icy (6)", forSegmentAt: 2)
            crewComplimentSegmentedOutlet.setTitle("Dog House", forSegmentAt: 2)
            scrollViewMainHeight.constant = 1100
        }
    }
    
    func initialSetup() {
        temperatureSwitchOutlet.isOn = true
        aeroBrakingSwitchOutlet.isOn = false
        podMounted = false
        crewCompliment = .dual
        rcrSegmentedOutlet.selectedSegmentIndex = 0
        _ = getSetTail(.resetAll)
        givenEngineFailureSliderOutlet.value = 100
        givenEngineFailureLabel.text = "100 kts"
    }
    
    func stringOptToDoubleString(_ str: String?) -> String {
        var result = ""
        if let str = str {
            let d = Double(str)
            result = String(d ?? 99999.5)
        }
        return result
    }
    
    func strBackToStr(_ str: String) -> String {
        let d = Double(str)?.rounded(.down) ?? 99999.5
        let i = Double(Int(d))
        return String(i)
    }
    
    func checkInputsUsedMatchUserInputs(_ inputs: [String]) -> (valid: Bool,
        userInputs: [String],
        calcInputs: [String]){
            var inputsFromCalc = inputs
            inputsFromCalc[1] = strBackToStr(inputsFromCalc[1])
            inputsFromCalc[10] = strBackToStr((inputsFromCalc[10]))
            inputsFromCalc.removeLast()
            var result: [String: String] = [:]
            result["aeroBraking"] = {if aeroBrakingSwitchOutlet.isOn {return "1"} else { return "0" }}()
            result["temp"] = strBackToStr(tempTextField.text ?? "empty")
            result["tempScale"] = {if (tempTitleLabel.text?.contains("C"))! {
                return "C"
            } else if (tempTitleLabel.text?.contains("F"))! {
                return "F"
            } else { return "empty"}}()
            result["pressAlt"] = strBackToStr(stringOptToDoubleString(pressureAltTextField.text))
            result["rwyLength"] = stringOptToDoubleString(rwyLengthTextField.text)
            result["rwyHeading"] = stringOptToDoubleString(rwyHeadingTextField.text)
            result["windDir"] = stringOptToDoubleString(windDirTextField.text)
            result["windSpeed"] = stringOptToDoubleString(windSpeedTextField.text)
            result["rwySlope"] = stringOptToDoubleString(rwySlopeTextField.text)
            let rcrIndex = rcrSegmentedOutlet.selectedSegmentIndex
            result["rcr"] = {
                switch rcrIndex {
                case 0:
                    return "23.0"
                case 1:
                    return "12.0"
                case 2:
                    return "6.0"
                default:
                    return "empty"
                }
            }()
            result["takeOffWeight"] = strBackToStr(takeOffWeightTitleLabel.text!)
            result["podMounted"] = {if podMountedSwitchOutlet.isOn {return "1"} else { return "0" }}()
            var userInput: [String] = [
                result["aeroBraking"]!,
                result["temp"]!,
                result["tempScale"]!,
                result["pressAlt"]!,
                result["rwyLength"]!,
                result["rwyHeading"]!,
                result["windDir"]!,
                result["windSpeed"]!,
                result["rwySlope"]!,
                result["rcr"]!,
                result["takeOffWeight"]!,
                result["podMounted"]!
            ]
//            var userInput: [String] = ["1", "13.0", "C", "119.0", "8122.0", "144.0", "230.0", "4.0", "0.4", "23.0", "12614.0", "0"]//
            let i1 = Double(userInput[10]) ?? 99
            let i2 = Double(inputsFromCalc[10]) ?? 10
            let absDiff = abs(i1 - i2)
            if absDiff <= 1 {
                userInput[10] = inputsFromCalc[10]
                
            }
            return (valid: userInput == inputsFromCalc,
                    userInputs: userInput,
                    calcInputs: inputsFromCalc)
    }
    
    func fillInTextBoxes() {
        icaoTextField.text = icao
        rwyLengthTextField.text = "\(runwayLength)"
        rwyHeadingTextField.text = "\(runwayHeading)"
        rwySlopeTextField.text = "\(runwaySlope)"
        tempTextField.text = "\(temperature)"
        pressureAltTextField.text = "\(pressureAlt)"
        windDirTextField.text = "\(windDir)"
        windSpeedTextField.text = "\(windSpeed)"
        tailBasicWtTextField.text = "\(basicWeight)"
    }
    
    var podSectionExpanded: Bool = false {
        didSet {
            adjustACConfigSectionHeight(podExpanded: podSectionExpanded, crewComplExpanded: crewComplimentSectionExpanded)
        }}
    
    var crewComplimentSectionExpanded: Bool = false {
        didSet {
            adjustACConfigSectionHeight(podExpanded: podSectionExpanded, crewComplExpanded: crewComplimentSectionExpanded)
        }}
    
    func adjustACConfigSectionHeight(podExpanded: Bool, crewComplExpanded: Bool) {
        if podExpanded && crewComplExpanded {
            aircraftConfigHeightOutlet.constant     = 400
            aircraftConfigSubHeight.constant        = 384
            podViewHeight.constant                  = 123
            podStackViewHeight.constant             = 107
            podTypeHeight.constant                  = 30
            podCargoWeightHeight.constant           = 30
            podTypeStackView.isHidden               = false
            podCargoWeightStackView.isHidden        = false
            podMountedTitleLabel.text               = "Yes"
            crewComplimentHeight.constant           = 84
            crewComplimentStackHeight.constant      = 68
            dogHouseStackView.isHidden              = false
        }
        if podExpanded == false && crewComplExpanded == false {
            aircraftConfigHeightOutlet.constant     = 286
            aircraftConfigSubHeight.constant        = 270
            podViewHeight.constant                  = 47
            podStackViewHeight.constant             = 31
            podTypeHeight.constant                  = 0
            podCargoWeightHeight.constant           = 0
            podTypeStackView.isHidden               = true
            podCargoWeightStackView.isHidden        = true
            podMountedTitleLabel.text               = "No"
            crewComplimentHeight.constant           = 46
            crewComplimentStackHeight.constant      = 30
            dogHouseStackView.isHidden              = true
        }
        if podExpanded == true && crewComplExpanded == false {
            aircraftConfigHeightOutlet.constant     = 362
            aircraftConfigSubHeight.constant        = 346
            podViewHeight.constant                  = 123
            podStackViewHeight.constant             = 107
            podTypeHeight.constant                  = 30
            podCargoWeightHeight.constant           = 30
            podTypeStackView.isHidden               = false
            podCargoWeightStackView.isHidden        = false
            podMountedTitleLabel.text               = "Yes"
            crewComplimentHeight.constant           = 46
            crewComplimentStackHeight.constant      = 30
            dogHouseStackView.isHidden              = true
        }
        if podExpanded == false && crewComplExpanded == true {
            aircraftConfigHeightOutlet.constant     = 324
            aircraftConfigSubHeight.constant        = 308
            podViewHeight.constant                  = 47
            podStackViewHeight.constant             = 31
            podTypeHeight.constant                  = 0
            podCargoWeightHeight.constant           = 0
            podTypeStackView.isHidden               = true
            podCargoWeightStackView.isHidden        = true
            podMountedTitleLabel.text               = "No"
            crewComplimentHeight.constant           = 84
            crewComplimentStackHeight.constant      = 68
            dogHouseStackView.isHidden              = false
        }}
    
    func textFieldColorizedVerification(sender: UITextField, lower: Double, upper: Double) -> (value: Double, valid: Bool) {
        var value = 99999.5
        var valid = false
        clearResults()
        if let textValue = sender.text {
            sender.layer.borderWidth = 1
            if textValue != "" {
                let senderValue = Double(textValue) ?? 99999.5
                if senderValue <= upper && senderValue >= lower {
                    sender.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                    value = senderValue
                    valid = true
                    calculateTold()
                } else {
                    sender.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    value = 99999.5
                    valid = false
                }
            } else {
                sender.layer.borderWidth = 0.8
                sender.layer.borderColor = #colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1)
                value = 99999.5
                valid = false
            }}
        return (value, valid)
    }
    
    var disclaimerPopUp = true
    func alertPopUp(){
        if disclaimerPopUp {
            let alertController = UIAlertController(title: "RESTRICTIONS", message:
                disclaimerBodyContent, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(.init(title: "ACKNOWLEDGE", style: .default, handler: { _ in
                print("Acknowledged")
            }))
            alertController.addAction(.init(title: "DON'T SHOW AGAIN", style: .destructive, handler: { _ in
                self.disclaimerPopUp = false
                self.defaults.set(self.disclaimerPopUp, forKey: "disclaimerPopUp")
            }))
            self.present(alertController, animated: true)
        } else {
            print("Previously Acknowledged")
        }
    }
    var disclaimerBodyContent = InfoStrings().restrictions


}
