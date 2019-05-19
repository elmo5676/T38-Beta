//
//  NearestReconfiguredViewController.swift
//  T38
//
//  Created by Matthew Elmore on 4/26/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class NearestReconfiguredViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        airfieldTableView.rowHeight = 100
        setFormat()
        podMounted = true
        numOfEngines = 2
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let model = moc.persistentStoreCoordinator?.managedObjectModel,
            let fetchAllAirports = model.fetchRequestTemplate(forName: "FetchAllAirports") as? NSFetchRequest<AirfieldCD> else {
                return
        }
        self.fetchAllAirports = fetchAllAirports

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.airfieldTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        fetchAndSortByDistance()
        airfieldTableView.reloadData()
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        airfieldTableView.removeObserver(self, forKeyPath: "contentSize")
        print("viewWillDisappear")
    }
    
    
    // MARK: - Initial SetUp
    // MARK: CoreData Variables
    var moc: NSManagedObjectContext!
    var airfields: [AirfieldCD] = []
    var airFieldDic: [AirfieldCD: [RunwayCD]] = [:]
    var airportsSorted = [AirfieldCD:Double]()
    var fetchAllAirports: NSFetchRequest<AirfieldCD>?
    var cdu = CoreDataUtilies()
    var defaults = UserDefaults()
    
    // MARK: Location Variables
    let locManager = CLLocationManager()
    var deviceLat = 0.0
    var deviceLong = 0.0
    var deviceAlt = 0.0
    var range = 0.0
    var bearing = 0.0
    
    var runways: [RunwayCD] = []
    var comms: [CommunicationCD] = []
    var freqs: [FreqCD] = []
    
    // MARK: - Diversion Variables
    let dGonk = DivertGonkulator()
    var greenRange = 0.0 {
        didSet {
            airfieldTableView.reloadData()
        }}
    var yellowRange = 0.0 {
        didSet {
            airfieldTableView.reloadData()
        }}
    var numOfEngines = 2 {
        didSet {
            switch self.numOfEngines {
            case 1:
                if podMounted { config = .singleEnginePod } else { config = .singleEngineNoPod }
            case 2:
                if podMounted { config = .bothEnginesPod } else { config = .bothEnginesNoPod }
            default:
                print("Configuration is really wierd man... prolly need to go fishing")
    }}}
    
    var podMounted   = false {
        didSet {
            switch self.podMounted {
            case true:
                if numOfEngines == 2 { config = .bothEnginesPod } else { config = .singleEnginePod }
            case false:
                if numOfEngines == 2 { config = .bothEnginesNoPod } else { config = .singleEngineNoPod }
    }}}
    
    var config: NearestConfig = .bothEnginesNoPod {
        didSet {
            print("Aircraft Configuration:  \(self.config)")
            _ = updateDivertDisplay(gas: self.gas)
            
        }
    }
    
    var gas: Double = 1400 {
        didSet {
            _ = updateDivertDisplay(gas: self.gas)
        }
    }
    
    func getDivertData(alt: Double, gas: Double, config: NearestConfig) -> (stayAtRange: (value: Double, valid: Bool), stayAtMach: (value: Double, valid: Bool), stayAtFuelFlow: (value: Double, valid: Bool), climbToRange: (value: Double, valid: Bool), climbToAlt: (value: Double, valid: Bool), climbToMach: (value: Double, valid: Bool), climbToFuelFlow: (value: Double, valid: Bool), descendDist: (value: Double, valid: Bool), descendFuelRemaing: (value: Double, valid: Bool)) {
        let stayAtRange = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .stayAtRange)
        let stayAtMach = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .stayAtMach)
        let stayAtFuelFlow = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .stayAtFuelFlow)
        let climbToRange = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .climbToRange)
        let climbToAlt = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .climbToAlt)
        let climbToMach = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .climbToMach)
        let climbToFuelFlow = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .climbToFuelFlow)
        let descendDist = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .descendDist)
        let descendFuelRemaing = dGonk.nearestInterpolator(alt: alt, gas: gas, config: config, diversionValue: .descendFuelRem)
        return (stayAtRange: stayAtRange, stayAtMach: stayAtMach, stayAtFuelFlow: stayAtFuelFlow, climbToRange: climbToRange, climbToAlt: climbToAlt, climbToMach: climbToMach, climbToFuelFlow: climbToFuelFlow, descendDist: descendDist, descendFuelRemaing: descendFuelRemaing)
    }
    
    func updateDivertDisplay(gas: Double) -> (greenRange: Double, yellowRange: Double) {
        let alt = getGPSAltitudeInFeet()/1000
        let data = getDivertData(alt: alt, gas: gas, config: self.config)
        if alt < 1000 { stayAtAlt.text = "SL" } else { stayAtAlt.text = "\(String(format: "%.0f",alt))K" }
        if data.stayAtRange.valid {
            stayAtRange.text = "\(String(format: "%.0f",data.stayAtRange.value))NM"
        } else {stayAtRange.text = "---"}
        if data.stayAtMach.valid {
            stayAtMach.text = "\(String(format: "%.2f",data.stayAtMach.value))"
        } else {stayAtMach.text = "---"}
        if data.stayAtFuelFlow.valid {
            stayAtFuelFlow.text = "\(String(format: "%.0f",data.stayAtFuelFlow.value))lbs"
        } else { stayAtFuelFlow.text = "---"}
        if data.climbToAlt.valid {
            climbToAlt.text = "\(String(format: "%.0f",(data.climbToAlt.value/1000)))K"
        } else { climbToAlt.text = "---"}
        if data.climbToRange.valid {
            climbToRange.text = "\(String(format: "%.0f",data.climbToRange.value))NM"
        } else { climbToRange.text = "---"}
        if data.climbToMach.valid {
            climbToMach.text = "\(String(format: "%.2f",data.climbToMach.value))"
        } else { climbToMach.text = "---"}
        if data.climbToFuelFlow.valid {
            climbToFuelFlow.text = "\(String(format: "%.0f",data.climbToFuelFlow.value))lbs"
        } else { climbToFuelFlow.text = "---"}
        if data.descendDist.valid {
            descendDistance.text = "\(String(format: "%.0f",data.descendDist.value))NM"
        } else { descendDistance.text = "---"}
        if data.descendFuelRemaing.valid {
            descendFuelRemaining.text = "\(String(format: "%.0f",data.descendFuelRemaing.value))lbs"
        } else { descendFuelRemaining.text = "---"}
        let greenRange = data.stayAtRange.value
        let yellowRange = data.climbToRange.value
        self.greenRange = greenRange
        self.yellowRange = yellowRange
        return (greenRange: greenRange, yellowRange: yellowRange)
    }
    
    @IBOutlet weak var airfieldTableView: UITableView!
    @IBOutlet weak var numOfEnginesOutlet: UIButton!
    @IBOutlet weak var podButtonOutlet: UIButton!
    @IBOutlet weak var numOfEngines2Outlet: UIButton!
    @IBOutlet weak var pod2ButtonOutlet: UIButton!
    @IBOutlet weak var gas600Outlet: UIButton!
    @IBOutlet weak var gas800Outlet: UIButton!
    @IBOutlet weak var gas1000Outlet: UIButton!
    @IBOutlet weak var gas1400Outlet: UIButton!
    @IBOutlet var gasButtonOutletCollection: [UIButton]!
    @IBOutlet var allButtonOutletCollection: [UIButton]!
    
    @IBOutlet weak var gasTitleLabel: UILabel!
    @IBOutlet weak var gasAmountLabel: UILabel!
    @IBOutlet weak var gasSliderOutlet: UISlider!
    @IBAction func gasSlider(_ sender: UISlider) {
        gasAmountLabel.text = "\(String(format: "%.0f",sender.value))lbs"
        gasAmountLabel.adjustsFontSizeToFitWidth = true
        gas = Double(sender.value)
    }
    
    
    //Stay At:
    @IBOutlet var stayAtMainLabelOutletCollection: [UILabel]!
    @IBOutlet var stayAtTitleLabelOutletCollection: [UILabel]!
    @IBOutlet var stayAtBackgroundView: UIView!
    @IBOutlet var stayAtAlt: UILabel!
    @IBOutlet var stayAtRange: UILabel!
    @IBOutlet var stayAtMach: UILabel!
    @IBOutlet var stayAtFuelFlow: UILabel!
    
    //Climb To:
    @IBOutlet var climbToMainLabelOutletCollection: [UILabel]!
    @IBOutlet var climbToTitleLabelOutletCollection: [UILabel]!
    @IBOutlet var climbToBackgroundView: UIView!
    @IBOutlet var climbToAlt: UILabel!
    @IBOutlet var climbToRange: UILabel!
    @IBOutlet var climbToMach: UILabel!
    @IBOutlet var climbToFuelFlow: UILabel!
    //Descend:
    @IBOutlet var descendMainLabelOutletCollection: [UILabel]!
    @IBOutlet var descendTitleLabelOutletCollection: [UILabel]!
    @IBOutlet var descendBackgroundView: UIView!
    @IBOutlet var descendDistance: UILabel!
    @IBOutlet var descendFuelRemaining: UILabel!
    //Combining Outlets
    func combineAllLabelOutlets() -> [UILabel] {
        var result: [UILabel] = []
        let allLabelArrays = [stayAtMainLabelOutletCollection, stayAtTitleLabelOutletCollection, climbToMainLabelOutletCollection, climbToTitleLabelOutletCollection, descendMainLabelOutletCollection, descendTitleLabelOutletCollection]
        for arrayL in allLabelArrays{
            for label in arrayL! {
                result.append(label)
            }
        }
        return result
    }
    
    
    // MARK: - IBActions:
    //ENGINES:
    @IBAction func numOfEngines_1_Button(_ sender: UIButton) {
        sender.showPressed()
        unselectedButton(numOfEngines2Outlet)
        selectedButton(numOfEnginesOutlet, selected: false)
        numOfEngines = 1
    }
    @IBAction func numOfEngines_2_Button(_ sender: UIButton) {
        sender.showPressed()
        unselectedButton(numOfEnginesOutlet)
        selectedButton(numOfEngines2Outlet, selected: false)
        numOfEngines = 2
    }
    //PODS:
    @IBAction func podButton(_ sender: UIButton) {
        sender.showPressed()
        unselectedButton(pod2ButtonOutlet)
        selectedButton(podButtonOutlet, selected: false)
        podMounted = true
    }
    @IBAction func noPodButton(_ sender: UIButton) {
        sender.showPressed()
        unselectedButton(podButtonOutlet)
        selectedButton(pod2ButtonOutlet, selected: false)
        podMounted = false
    }
    //GAS:
    @IBAction func gas_600_Button(_ sender: UIButton) {
        sender.showPressed()
        gasSegmentedControl(sender)
    }
    @IBAction func gas_800_Button(_ sender: UIButton) {
        sender.showPressed()
        gasSegmentedControl(sender)
    }
    @IBAction func gas_1000_Button(_ sender: UIButton) {
        sender.showPressed()
        gasSegmentedControl(sender)
    }
    @IBAction func gas_1400_Button(_ sender: UIButton) {
        sender.showPressed()
        gasSegmentedControl(sender)
    }
    //Bottom:
    @IBAction func dismissBarButton(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airfields.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        let airFieldId = airfields[i].id_CD
        print(airfields[i])
        print(cdu.getRunwaysAtAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(airfieldId: airFieldId, moc: moc))
        
        if let icao = airfields[i].icao_CD {
            self.directToInForeFlight(icao: icao)
        } else {
            print("No ICAO")
        }
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Filtered by RWY Length of \(cdu.getUserSettings().minRwyLength_UD)"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let alt = "\(String(format: "%.0f",deviceAlt/1000))K Ft"
        var footer = ""
        switch self.config {
        case .bothEnginesNoPod:
            footer = "Alt: \(alt) || 2 Engines || No Pod"
        case .bothEnginesPod:
            footer = "Alt: \(alt) || 2 Engines || Pod"
        case .singleEngineNoPod:
            footer = "Alt: \(alt) || 1 Engine || No Pod"
        case .singleEnginePod:
            footer = "Alt: \(alt) || 1 Engine || Pod"
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let footer = view as! UITableViewHeaderFooterView
        footer.textLabel?.textColor = UIColor.red
        footer.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nearestCellReconfigured", for: indexPath) as! NearestCellReconfiguredTableViewCell
        
        let rb = cdu.rangeAndBearing(latitude_01: deviceLat,
                                     longitude_01: deviceLong,
                                     latitude_02: airfields[indexPath.row].latitude_CD,
                                     longitude_02: airfields[indexPath.row].longitude_CD)
        let range = rb.range
        let bearing = rb.bearing
        
        print(yellowRange)
        print(greenRange)
        
        
        if greenRange == 99999.0 {
            if range > yellowRange {
                colorCodingfor(cell, divertAlt: .unable)
            } else if range <= yellowRange {
                colorCodingfor(cell, divertAlt: .climbTo)
            }
        } else {
            if range > yellowRange {
                colorCodingfor(cell, divertAlt: .unable)
            } else if range > greenRange && range <= yellowRange {
                colorCodingfor(cell, divertAlt: .climbTo)
            } else if range <= greenRange && greenRange != 99999.0 {
                colorCodingfor(cell, divertAlt: .stayAt)
            }
        }
        
        cell.airfieldName.text = airfields[indexPath.row].name_CD
        cell.airfieldName.adjustsFontSizeToFitWidth = true
        cell.icaoLabel.text = airfields[indexPath.row].icao_CD
        cell.rangeLabel.text = String(format: "%.0f",range) + " NM"
        cell.bearingLabel.text = String(format: "%.0f",bearing) + "°"
        
        
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.3239265084, green: 0.3239864409, blue: 0.3239186406, alpha: 1)
        cell.selectedBackgroundView? = backgroundView
        

        return cell
    }
    
    // MARK: - Formatting Functions:
    func setFormat() {
        for button in allButtonOutletCollection {
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            unselectedButton(button)
        }
        selectedButton(numOfEngines2Outlet, selected: true)
        selectedButton(pod2ButtonOutlet, selected: true)
        selectedButton(gas1400Outlet, selected: true)
    }
    
    func gasSegmentedControl(_ segment: UIButton){
        for button in gasButtonOutletCollection {
            unselectedButton(button)
        }
        selectedButton(segment, selected: false)
    }
    
    func selectedButton(_ b: UIButton, selected: Bool){
        b.backgroundColor = #colorLiteral(red: 0.224550575, green: 0.2557333112, blue: 0.3091958761, alpha: 1)
        let currentFont = b.titleLabel?.font.pointSize
        b.titleLabel!.font = UIFont.systemFont(ofSize: currentFont!, weight: .semibold)
        b.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        if selected == true {
            b.sendActions(for: .touchUpInside)
        }
    }
    
    func unselectedButton(_ b: UIButton) {
        b.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        let currentFont = b.titleLabel?.font.pointSize
        b.titleLabel!.font = UIFont.systemFont(ofSize: currentFont!, weight: .semibold)
        b.setTitleColor(#colorLiteral(red: 0.6794947982, green: 0.6796110272, blue: 0.6794795394, alpha: 1), for: .normal)
    }
    
    enum DivertAlt {
        case stayAt
        case climbTo
        case unable
    }
    
    func colorCodingfor(_ cell: NearestCellReconfiguredTableViewCell, divertAlt: DivertAlt) {
        for label in cell.allLabels {
            let currentFont = label.font.pointSize
            label.font = UIFont.systemFont(ofSize: currentFont, weight: .semibold)
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        for label in combineAllLabelOutlets() {
            let currentFont = label.font.pointSize
            label.font = UIFont.systemFont(ofSize: currentFont, weight: .semibold)
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        let mainLabels = [stayAtMainLabelOutletCollection, climbToMainLabelOutletCollection, descendMainLabelOutletCollection]
        for labelArray in mainLabels {
            for label in labelArray! {
                let currentFont = label.font.pointSize
                print("*********************** \(currentFont) *********************")
                label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
                label.adjustsFontSizeToFitWidth = true
            }
        }
        
        switch divertAlt {
        case .stayAt:
            cell.backgroundCellView.backgroundColor = #colorLiteral(red: 0.02010489069, green: 0.2401324809, blue: 0.01709630527, alpha: 1)
        case .climbTo:
            cell.backgroundCellView.backgroundColor = #colorLiteral(red: 0.3204649687, green: 0.3188325167, blue: 0.05567290634, alpha: 1)
        case .unable:
            cell.backgroundCellView.backgroundColor = #colorLiteral(red: 0.3188294172, green: 0.014315865, blue: 0.01002992969, alpha: 1)
        }
        cell.backgroundCellView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.backgroundCellView.layer.borderWidth = 1
    }
    
    
    // MARK: - Location Functions:
    func getLocationInformation() {
        if let loc = locManager.location {
            locManager.requestAlwaysAuthorization()
            locManager.requestWhenInUseAuthorization()
            self.deviceLat = loc.coordinate.latitude
            self.deviceLong = loc.coordinate.longitude
            self.deviceAlt = loc.altitude
        }}
    
    func getGPSAltitudeInFeet() -> Double {
        if let GPSAltDouble = locManager.location?.altitude {
            deviceAlt = GPSAltDouble.metersToFeet
            print(deviceAlt)
            return deviceAlt
        } else {
            print(deviceAlt)
            return deviceAlt
        }}
    
    func printResults(){
        for airport in airfields {
            deviceLat = (locManager.location?.coordinate.latitude)!
            deviceLong = (locManager.location?.coordinate.longitude)!
            print("\(String(describing: airport.icao_CD)) : \(cdu.distanceAway(deviceLat: deviceLat, deviceLong: deviceLong, airport: airport).distanceAway)")
        }}
    
    // MARK: CoreData Functions:
    func fetchAndSortByDistance() {
        getLocationInformation()
        runways = cdu.getRunwaysGreaterThanOrEqualToUserSettingsMinRWYLength(moc: moc)
        do {
            airfields = cdu.getAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(moc: moc)
            var preSorted = [AirfieldCD:Double]()
            for airport in airfields {
                let dictKey = cdu.distanceAway(deviceLat: deviceLat, deviceLong: deviceLong, airport: airport).airport
                let dictValue = cdu.distanceAway(deviceLat: deviceLat, deviceLong: deviceLong, airport: airport).distanceAway
                preSorted.updateValue(dictValue, forKey: dictKey)
            }
            let airportICAO = preSorted.keys.sorted{preSorted[$0]! < preSorted[$1]!}
            airfields = airportICAO.filter({$0.icao_CD != "" })
            print("\(deviceLat) : \(deviceLong)")
        }
        
    }
    
//    enum GetSet {
//        case get
//        case set
//    }
//
//    func getSetEnteredConfig(getSet: GetSet, numOfEngines: Int?, podMounted: Bool?, gas: Double?) -> (numOfEngines: Int?, podMounted: Bool?, gas: Double?){
//        var numOfEngines: Int?  = nil
//        var podMounted: Bool?   = nil
//        var gas: Double?        = nil
//        switch getSet {
//        case .get:
//            numOfEngines    = defaults.integer(forKey: "numOfEngines")
//            podMounted      = defaults.bool(forKey: "podMounted")
//            gas             = defaults.double(forKey: "gas")
//            return (numOfEngines: numOfEngines, podMounted: podMounted, gas: gas)
//        case .set:
//            defaults.set(numOfEngines, forKey: "numOfEngines")
//            defaults.set(podMounted, forKey: "podMounted")
//            defaults.set(gas, forKey: "gas")
//        }
//        return (numOfEngines: numOfEngines, podMounted: podMounted, gas: gas)
//    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.preferredContentSize = airfieldTableView.contentSize
    }
    


}
