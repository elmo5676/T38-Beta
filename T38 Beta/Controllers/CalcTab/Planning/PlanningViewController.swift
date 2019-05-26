//
//  PlanningViewController.swift
//  T38
//
//  Created by Matthew Elmore on 5/1/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class PlanningViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExportToForeFlightDelegate, UITextFieldDelegate {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        foreFlightDelegate = self
        setFormatting()
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let model = moc.persistentStoreCoordinator?.managedObjectModel,
        let fetchAllAirports = model.fetchRequestTemplate(forName: "FetchAllAirports") as? NSFetchRequest<AirfieldCD> else {return}
        self.fetchAllAirports = fetchAllAirports
        if let alert = UserDefaults.standard.object(forKey: "alertPopUp") {
            self.alert = alert as! Bool
        }
        icaoTextFieldOutlet.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.airfieldsInRangeTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.hideKeyboardWhenTappedAround()
        fetchAndSortByDistanceDeviceLocation()
        loadNearest()
        startingFuel = 3962
        cruiseAlt = 41
        updateMainDisplay()
        startAltLabel.text = "\((departureAlt/1000).toStringWithZeroDecimal()) K"
        airfieldsInRangeTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        airfieldsInRangeTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: - Initial SetUp
    // MARK: CoreData Variables
    var moc: NSManagedObjectContext!
    var airfields: [AirfieldCD] = [] {didSet { airfieldsInRangeTableView.reloadData(); updateMainDisplay()}}
    var airFieldDic: [AirfieldCD: [RunwayCD]] = [:]
    var airportsSorted = [AirfieldCD:Double]()
    var fetchAllAirports: NSFetchRequest<AirfieldCD>?
    var cdu = CoreDataUtilies()
    var defaults = UserDefaults()
    
    // MARK: Location Variables
    let locManager = CLLocationManager()
    var icaoSearched: String = ""
    var depIcaoLat = 0.0 {didSet { airfieldsInRangeTableView.reloadData(); updateMainDisplay()}}
    var depIcaoLong = 0.0 {didSet { airfieldsInRangeTableView.reloadData(); updateMainDisplay()}}
    var deviceLat = 0.0
    var deviceLong = 0.0
    var departureAlt: Double = 0.0
    var startingFuel: Double = 0.0 {didSet { airfieldsInRangeTableView.reloadData(); updateMainDisplay()}}
    var cruiseAlt: Double = 0.0 {didSet { airfieldsInRangeTableView.reloadData(); updateMainDisplay()}}
    var mrcRange: Double = 0.0
    var p9mRange: Double = 0.0
    var foreFlightDelegate: ExportToForeFlightDelegate?
    

    // MARK: - Outlets
    //ICAO
    @IBOutlet weak var ICAOLabel: UILabel!
    @IBOutlet weak var airfieldNameLabel: UILabel!
    @IBOutlet weak var icaoView: UIView!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var icaoTextFieldOutlet: UITextField!
    
    @IBOutlet weak var searchButtonOutlet: UIButton!
    @IBOutlet weak var icaoDepartureLabel: UILabel!
    @IBOutlet weak var airfieldDepartureOutlet: UILabel!
    
    @IBOutlet weak var icaoTitle: UIView!
    @IBOutlet weak var icaoSearch: UIView!
    @IBOutlet weak var sliderViews: UIView!
    
    //Fuel
    @IBOutlet weak var fuelView: UIView!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var fuelSliderOutlet: UISlider!
    @IBOutlet weak var fuelAmountLabel: UILabel!
    @IBOutlet weak var startAltLabel: UILabel!
    @IBOutlet weak var cruiseAltLabel: UILabel!
    //Max Range Cruise
    @IBOutlet weak var mrcView: UIView!
    @IBOutlet weak var maxRangeCruiseTitleLabel: UILabel!
    @IBOutlet weak var mrcMachTitleLabel: UILabel!
    @IBOutlet weak var mrcKIASTitleLabel: UILabel!
    @IBOutlet weak var mrcKTASTitleLabel: UILabel!
    @IBOutlet weak var mrcFFpHrTitleLabel: UILabel!
    @IBOutlet weak var mrcFFpMinTitleLabel: UILabel!
    //
    @IBOutlet weak var mrcMachValueLabel: UILabel!
    @IBOutlet weak var mrcKIASValueLabel: UILabel!
    @IBOutlet weak var mrcKTASValueLabel: UILabel!
    @IBOutlet weak var mrcFFpHrValueLabel: UILabel!
    @IBOutlet weak var mrcFFpMinValueLabel: UILabel!
    
    //0.9 Mach Cruise
    @IBOutlet weak var p9MachView: UIView!
    @IBOutlet weak var ptNineMachTitleLabel: UILabel!
    @IBOutlet weak var p9MMachTitleLabel: UILabel!
    @IBOutlet weak var p9MKIASTitleLabel: UILabel!
    @IBOutlet weak var p9MKTASTitleLabel: UILabel!
    @IBOutlet weak var p9MFFpHrTitleLabel: UILabel!
    @IBOutlet weak var p9MFFpMinTitleLabel: UILabel!
    //
    @IBOutlet weak var p9MMachValueLabel: UILabel!
    @IBOutlet weak var p9MKIASValueLabel: UILabel!
    @IBOutlet weak var p9MKTASValueLabel: UILabel!
    @IBOutlet weak var p9MFFpHrValueLabel: UILabel!
    @IBOutlet weak var p9MFFpMinValueLabel: UILabel!
    
    //Restricted Climb
    @IBOutlet weak var restrictedClimbView: UIView!
    @IBOutlet weak var restrictedClimbTitleLabel: UILabel!
    @IBOutlet weak var rcMachTitleLabel: UILabel!
    @IBOutlet weak var rcKIASTitleLabel: UILabel!
    @IBOutlet weak var rcTimeTitleLabel: UILabel!
    @IBOutlet weak var rcDistanceTitleLabel: UILabel!
    @IBOutlet weak var rcFuelUsedTitleLabel: UILabel!
    //
    @IBOutlet weak var rcMachValueLabel: UILabel!
    @IBOutlet weak var rcKIASValueLabel: UILabel!
    @IBOutlet weak var rcTimeValueLabel: UILabel!
    @IBOutlet weak var rcDistanceValueLabel: UILabel!
    @IBOutlet weak var rcFuelUsedValueLabel: UILabel!
    
    //Export To ForeFlight
    @IBOutlet weak var exportToFFView: UIView!
    @IBOutlet weak var mrcExportToForeFlightButtonOutlet: UIButton!
    @IBOutlet weak var p9MExportToForeFlightButtonOutlet: UIButton!
    
    //TableView
    @IBOutlet weak var airfieldsInRangeTableView: UITableView!
    
    
    // MARK: - IBActions
    @IBAction func icaoTextFieldSearch(_ sender: Any) {
        if let icao = icaoTextFieldOutlet.text  {
            if icao != "" && verifyIcao(icao) {
                let caf = cdu.getAirfieldByICAOOnly(icao, moc: moc)[0]
                icaoSearched = caf.icao_CD!
                fetchAndSortByDistanceIcaoLocation()
                loadNearest()
                updateMainDisplay()
            } else {
                alert(title: "Unknown ICAO", message: "You sure you're a pilot?", buttonTitle: "I'm Sure")
    }}}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.icaoTextFieldSearch(icaoTextFieldOutlet)
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func altSliderEnd(_ sender: UISlider) {
        cruiseAltLabel.text = "\(String(format: "%.0f",sender.value)) K"
        cruiseAlt = Double(sender.value)
    }
    @IBAction func fuelSliderEnd(_ sender: UISlider) {
        fuelAmountLabel.text = "\(String(format: "%.0f",sender.value)) Lbs"
        startingFuel = Double(sender.value)
    }
    
    var alert = true
    @IBAction func mrcExportFF(_ sender: UIButton) {
        if alert {
            let alertController = UIAlertController(title: "This might take a minute", message:
                "This assumes zero wind, direct, no descent profile and out of gas at the end of the range. Back the gas slider up by personal preference to reflect STTO and desired pad. Depending on your life choices, this might take up to a minute to generate the overlay for ForeFlight. If you made it to the end of this popup, I'm proud of you", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(.init(title: "OK", style: .default, handler: { _ in
                self.genAndExportKml_(mrcRange: self.mrcRange, p9mRange: self.p9mRange, mrcColor: .darkBlue, p9mColor: .darkGreen, fileName: "XCPlanning")
            }))
            alertController.addAction(.init(title: "No Thanks", style: .cancel, handler: nil))
            alertController.addAction(.init(title: "Don't show this again", style: .destructive, handler: { _ in
                self.genAndExportKml_(mrcRange: self.mrcRange, p9mRange: self.p9mRange, mrcColor: .darkBlue, p9mColor: .darkGreen, fileName: "XCPlanning")
                self.alert = false
                self.defaults.set(self.alert, forKey: "alertPopUp")
            }))
            self.present(alertController, animated: true)
        } else {
            self.genAndExportKml_(mrcRange: self.mrcRange, p9mRange: self.p9mRange, mrcColor: .darkBlue, p9mColor: .darkGreen, fileName: "XCPlanning")

        }
    }
    
    @IBAction func p9MExportToFF(_ sender: UIButton) {
    }
    @IBAction func dismissViewButton(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func updateMainDisplay() {
        let charted = PlanningGonk(depAlt: departureAlt, alt: cruiseAlt, fuel: startingFuel, distAway: nil)
        mrcRange = charted.mrcRange
        p9mRange = charted.p9mRange
        rcMachValueLabel.text = charted.rcMach.toStringWithNumberOfDecimal(2)
        rcKIASValueLabel.text = charted.rcKIAS.toStringWithNumberOfDecimal(0)
        rcTimeValueLabel.text = charted.rcTime.toStringWithNumberOfDecimal(0)
        rcDistanceValueLabel.text = charted.rcDistance.toStringWithNumberOfDecimal(0)
        rcFuelUsedValueLabel.text = charted.rcFuelUsed.toStringWithNumberOfDecimal(0)
        mrcMachValueLabel.text = charted.mrcMach.toStringWithNumberOfDecimal(2)
        mrcKIASValueLabel.text = charted.mrcKIAS.toStringWithNumberOfDecimal(0)
        mrcKTASValueLabel.text = charted.mrcKTAS.toStringWithNumberOfDecimal(0)
        mrcFFpHrValueLabel.text = charted.mrcFFpHr.toStringWithNumberOfDecimal(0)
        mrcFFpMinValueLabel.text = charted.mrcFFpMin.toStringWithNumberOfDecimal(0)
        p9MMachValueLabel.text = charted.p9mMach.toStringWithNumberOfDecimal(2)
        p9MKIASValueLabel.text = charted.p9mKIAS.toStringWithNumberOfDecimal(0)
        p9MKTASValueLabel.text = charted.p9mKTAS.toStringWithNumberOfDecimal(0)
        p9MFFpHrValueLabel.text = charted.p9mFFpHr.toStringWithNumberOfDecimal(0)
        p9MFFpMinValueLabel.text = charted.p9mFFpMin.toStringWithNumberOfDecimal(0)
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
    
    //KML Functions
    func genAndExportKml(range: Double, color: ColorKML, fileName: String) {
        let maxRange = range
        var afKML = ""
        afKML += CircleKML(radius: range, centerPoint: [depIcaoLong, depIcaoLat], centerpointLabelTitle: "", lineColor: color, iconType: .none, iconIncluded: false, centerpointLabelIncluded: false, width: 2).circleWithOutCenterLabel()
        for airfield in airfields {
            let range = cdu.distanceAway(deviceLat: depIcaoLat, deviceLong: depIcaoLong, airport: airfield).distanceAway
            if range < maxRange {
                let coords = [airfield.longitude_CD, airfield.latitude_CD]
                let icao = airfield.icao_CD
                //                let time = "PH"
                let fuelUsed = "PH"
                afKML += CircleKML(radius: 10.0,
                                   centerPoint: coords,
                                   centerpointLabelTitle: "\(icao ?? "nICAO") \(fuelUsed)#",
                                   lineColor: color,
                                   iconType: .none,
                                   iconIncluded: false,
                                   centerpointLabelIncluded: false,
                                   width: 10).circleWithCenterLabel()
            }
        }
        let kml = OpenCloseKML(kmlItems: afKML).KMLGenerator()
        passToShareSheet(fileName: fileName, ext: "kml", stringToWriteToFile: kml)
        
    }
    
    func genAndExportKml_(mrcRange: Double, p9mRange: Double, mrcColor: ColorKML, p9mColor: ColorKML, fileName: String) {
        var mrcKML = ""
        
        func rangeCircleLabelLabelCoords(cp: [Double], range: Double, angle: Double) -> [Double] {
            let radiusCalculated = range * (1/60)
            let j = angle
            let x = ((radiusCalculated/cos(cp[1] * Double.pi / 180)) * cos(j * Double.pi / 180)) + cp[0]
            let y = (radiusCalculated * sin(j * Double.pi / 180)) + cp[1]
            return [x, y]
        }
        
        let angle = 90.0
        let mrcLabelCoords = rangeCircleLabelLabelCoords(cp: [depIcaoLong, depIcaoLat], range: mrcRange, angle: angle)
        let p9mLabelCoords = rangeCircleLabelLabelCoords(cp: [depIcaoLong, depIcaoLat], range: p9mRange, angle: angle)
        let mrcLabelKML = PlacemarkKML(placeMarkTitle: "Max Range: \(mrcRange.toStringWithZeroDecimal())NM", placeMarkDescription: "Max Range", placeMarkCoords: mrcLabelCoords, iconType: .none, withLabel: true, withIcon: false).iconGenerator()
        let p9mLabelKML = PlacemarkKML(placeMarkTitle: "0.9 Mach: \(p9mRange.toStringWithZeroDecimal())NM", placeMarkDescription: "0.9 Mach", placeMarkCoords: p9mLabelCoords, iconType: .none, withLabel: true, withIcon: false).iconGenerator()
        
        mrcKML += CircleKML(radius: mrcRange, styleName: "mrc",centerPoint: [depIcaoLong, depIcaoLat], centerpointLabelTitle: "mrc", lineColor: mrcColor, iconType: .none, iconIncluded: false, centerpointLabelIncluded: false, width: 5).circleWithOutCenterLabel()
        var p9mKML = ""
        p9mKML += CircleKML(radius: p9mRange, styleName: "p9m",centerPoint: [depIcaoLong, depIcaoLat], centerpointLabelTitle: "p9m", lineColor: p9mColor, iconType: .none, iconIncluded: false, centerpointLabelIncluded: false, width: 5).circleWithOutCenterLabel()
        
        for airfield in airfields {
            let range = cdu.distanceAway(deviceLat: depIcaoLat, deviceLong: depIcaoLong, airport: airfield).distanceAway
            if range < mrcRange && range >= p9mRange {
                let coords = [airfield.longitude_CD, airfield.latitude_CD]
                let icao = airfield.icao_CD
                let fuelUsed = "PH"
                mrcKML += CircleKML(radius: 10.0,
                                   centerPoint: coords,
                                   centerpointLabelTitle: "\(icao ?? "nICAO") \(fuelUsed)#",
                    lineColor: mrcColor,
                    iconType: .none,
                    iconIncluded: false,
                    centerpointLabelIncluded: false,
                    width: 10).circleWithCenterLabel()
            }
            if range < p9mRange {
                let coords = [airfield.longitude_CD, airfield.latitude_CD]
                let icao = airfield.icao_CD
                let fuelUsed = "PH"
                p9mKML += CircleKML(radius: 10.0,
                                    centerPoint: coords,
                                    centerpointLabelTitle: "\(icao ?? "nICAO") \(fuelUsed)#",
                    lineColor: p9mColor,
                    iconType: .none,
                    iconIncluded: false,
                    centerpointLabelIncluded: false,
                    width: 10).circleWithCenterLabel()
            }
        }
        let kml = OpenCloseKML(kmlItems: "\(mrcKML) \(p9mKML)\(mrcLabelKML)\(p9mLabelKML)").KMLGenerator()
        passToShareSheet(fileName: fileName, ext: "kml", stringToWriteToFile: kml)
        
    }
    
    // MARK: - Location Functions:
    func getLocationInformation() {
        if let loc = locManager.location {
            locManager.requestAlwaysAuthorization()
            locManager.requestWhenInUseAuthorization()
            self.deviceLat = loc.coordinate.latitude
            self.deviceLong = loc.coordinate.longitude
        }}
    
    // MARK: CoreData Functions:
    func fetchAndSortByDistanceDeviceLocation() {
        getLocationInformation()
        do {
            airfields = cdu.getAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(moc: moc)
            var preSorted = [AirfieldCD:Double]()
//            var filteredForDistance: [AirfieldCD:Double] = [:]
            for airport in airfields {
                let dictKey = cdu.distanceAway(deviceLat: deviceLat, deviceLong: deviceLong, airport: airport).airport
                let dictValue = cdu.distanceAway(deviceLat: deviceLat, deviceLong: deviceLong, airport: airport).distanceAway
                preSorted.updateValue(dictValue, forKey: dictKey)
//                filteredForDistance = preSorted.filter {key, value in value < 1000.0 }
            }
            let airportICAO = preSorted.keys.sorted{preSorted[$0]! < preSorted[$1]!}
            airfields = airportICAO.filter({$0.icao_CD != "" })
            print("\(deviceLat) : \(deviceLong)")
        }
        
    }
    
    func fetchAndSortByDistanceIcaoLocation() {
        let caf = cdu.getAirfieldByICAOOnly(icaoSearched, moc: moc)[0]
        do {
            airfields = cdu.getAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(moc: moc)
            var preSorted = [AirfieldCD:Double]()
            for airport in airfields {
                let airPortAndDist = cdu.distanceAway(deviceLat: caf.latitude_CD, deviceLong: caf.longitude_CD, airport: airport)
                let dictKey = airPortAndDist.airport
                let dictValue = airPortAndDist.distanceAway
                preSorted.updateValue(dictValue, forKey: dictKey)
            }
            let airportICAO = preSorted.keys.sorted{preSorted[$0]! < preSorted[$1]!}
            airfields = airportICAO.filter({$0.icao_CD != "" })
            print("\(depIcaoLat) : \(depIcaoLong)")
        }

    }
    
    func loadNearest() {
        let caf = airfields[0]
        ICAOLabel.text = "\(caf.icao_CD!)"
        airfieldNameLabel.text = "\(caf.name_CD!)"
        deviceLat = caf.latitude_CD
        deviceLong = caf.longitude_CD
        depIcaoLong = caf.longitude_CD
        depIcaoLat = caf.latitude_CD
        departureAlt = caf.elevation_CD
        startAltLabel.text = "\((departureAlt/1000).toStringWithZeroDecimal()) K"
        print("DEPARTURE ALT: \(departureAlt)")
    }
 
    //Formatting Functions:
    func setFormatting() {
        startAltLabel.adjustsFontSizeToFitWidth = true
        airfieldNameLabel.adjustsFontSizeToFitWidth = true
        searchButtonOutlet.standardButtonFormatting()
        let resultsTitles = [maxRangeCruiseTitleLabel, ptNineMachTitleLabel, restrictedClimbTitleLabel]
        let resultsHeaders = [mrcMachTitleLabel, mrcKIASTitleLabel, mrcKTASTitleLabel, mrcFFpHrTitleLabel, mrcFFpMinTitleLabel,p9MMachTitleLabel,p9MKIASTitleLabel,p9MKTASTitleLabel,p9MFFpHrTitleLabel,p9MFFpMinTitleLabel,rcMachTitleLabel,rcKIASTitleLabel,rcTimeTitleLabel,rcDistanceTitleLabel,rcFuelUsedTitleLabel]
        let resultsValues = [mrcMachValueLabel, mrcKIASValueLabel, mrcKTASValueLabel, mrcFFpHrValueLabel, mrcFFpMinValueLabel,p9MMachValueLabel,p9MKIASValueLabel,p9MKTASValueLabel,p9MFFpHrValueLabel,p9MFFpMinValueLabel,rcMachValueLabel,rcKIASValueLabel,rcTimeValueLabel,rcDistanceValueLabel,rcFuelUsedValueLabel]
        let exportToFFButtons = [mrcExportToForeFlightButtonOutlet, p9MExportToForeFlightButtonOutlet]
        
        for label in resultsTitles {
            labelFormatting(label: label!, type: .title)
        }
        for label in resultsHeaders {
            labelFormatting(label: label!, type: .header)
        }
        for label in resultsValues {
            labelFormatting(label: label!, type: .value)
        }
        for button in exportToFFButtons {
            button?.standardButtonFormatting()
        }
        let alpha: CGFloat = 0.4
        mrcView.backgroundColor = #colorLiteral(red: 0.08203542978, green: 0.2459336519, blue: 0.5528892875, alpha: 1)
        p9MachView.backgroundColor = #colorLiteral(red: 0.0406710282, green: 0.3308458924, blue: 0.006443564314, alpha: 1)
        restrictedClimbView.backgroundColor = #colorLiteral(red: 0.4710243344, green: 0.4638072252, blue: 0.06606198847, alpha: 1)
        let views = [icaoTitle, icaoSearch, sliderViews, mrcView, p9MachView, restrictedClimbView]
        for view in views {
            view!.alpha = alpha
            view?.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view?.layer.borderWidth = 0.5
        }
    }
    
    enum LabelType {
        case title
        case header
        case value
    }
    
    func labelFormatting(label: UILabel, type: LabelType) {
        var fontSize: CGFloat = 0.0
        switch type {
        case .title:
            fontSize = 17.0
        case .header:
            fontSize = 10.0
        case .value:
            fontSize = 15.0
        }
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.preferredContentSize = airfieldsInRangeTableView.contentSize
    }
    
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return airfields.count
        default:
            return 0
    }}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Filtered by RWY Length of \(cdu.getUserSettings().minRwyLength_UD)"
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "placeHolderCell")!
            airfieldsInRangeTableView.rowHeight = 530
            return cell
        case 1:
            airfieldsInRangeTableView.rowHeight = 200
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "planningCell", for: indexPath) as! PlanningCellTableViewCell
            cell.mrcDelegate = self
            cell.p9MDelegate = self
            let i = indexPath.row
            let range = cdu.distanceAway(deviceLat: depIcaoLat, deviceLong: depIcaoLong, airport: airfields[i]).distanceAway
            let info = PlanningGonk(depAlt: departureAlt, alt: cruiseAlt, fuel: startingFuel, distAway: range)
            let unable = "---"
            if range > mrcRange {
                cell.mrcTimeValueLabel.text = unable
                cell.mrcFuelUsedValueLabel.text = unable
                cell.mrcFuelRemainingValueLabel.text = unable
            } else {
                cell.mrcTimeValueLabel.text = info.afMrcTime.toStringWithNumberOfDecimal(0)
                cell.mrcFuelUsedValueLabel.text = info.afMrcFuelUsed.toStringWithNumberOfDecimal(0)
                cell.mrcFuelRemainingValueLabel.text = info.afMrcFuelRemain.toStringWithNumberOfDecimal(0)
            }
            if range > p9mRange {
                cell.p9MTimeValueLabel.text = unable
                cell.p9MFuelUsedValueLabel.text = unable
                cell.p9MFuelRemainingValueLabel.text = unable
            } else {
                cell.p9MTimeValueLabel.text = info.afP9mTime.toStringWithNumberOfDecimal(0)
                cell.p9MFuelUsedValueLabel.text = info.afP9mFuelUsed.toStringWithNumberOfDecimal(0)
                cell.p9MFuelRemainingValueLabel.text = info.afP9mFuelRemain.toStringWithNumberOfDecimal(0)
            }
            
            cell.airfield = airfields[i]
            cell.icaoLabel.text = airfields[i].icao_CD
            cell.distanceAwayLabel.text = "\(range.toStringWithNumberOfDecimal(0))NM"
            cell.airfieldNameLabel.text = airfields[i].name_CD
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "planningCell", for: indexPath) as! PlanningCellTableViewCell
            return cell
        }
        
        
    }
    
    

}
