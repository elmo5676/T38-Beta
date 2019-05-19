//
//  RunwayChoicesTableViewController.swift
//  T38
//
//  Created by elmo on 5/10/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit
import CoreData

struct ChosenRunway {
    var airfieldName: String
    var runwayName: String
    var icao: String
    var runwayLength: Double
    var runwayHeading: Double
    var runwaySlope: Double
    
    init(airfieldName: String,
         runwayName: String,
         icao: String,
         runwayLength: Double,
         runwayHeading: Double,
         runwaySlope: Double) {
        self.airfieldName = airfieldName
        self.runwayName = runwayName
        self.icao = icao
        self.runwayLength = runwayLength
        self.runwayHeading = runwayHeading
        self.runwaySlope = runwaySlope
    }
    
}

class RunwayChoicesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialSetupOfVariables(currentFieldDict)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        }
    
    @IBAction func dismissButton(_ sender: UIButton!) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.preferredContentSize = tableView.contentSize
    }
    var isModal: Bool {
        return presentingViewController != nil ||
            navigationController?.presentingViewController?.presentedViewController === navigationController ||
            tabBarController?.presentingViewController is UITabBarController
    }
    override func viewWillDisappear(_ animated: Bool) {
        tableView.removeObserver(self, forKeyPath: "contentSize")
        print("RunwayChoicesTableViewController.viewWillDisapear")
    }
    
    var cdu = CoreDataUtilies()
    var chosenRunwayDelegate: RunwayChoicesDelegate?
    
    var rwyID = ""
    var xWind = 0.0
    var hWind = 0.0
    var length = 0.0
    var heading = 0.0
    
    //Passed in:
    var currentFieldDict = [AirfieldCD:[RunwayCD]]()
    var metar: Metar?
    //Created from passed in:
    var icao: String = ""
    var currentICAO = ""
    var airfieldName: String = ""
    var runways: [RunwayCD] = []
    

    func initialSetupOfVariables(_ dic: [AirfieldCD:[RunwayCD]]?) {
        if dic != nil {
            self.runways = currentFieldDict.values.first!
            self.airfieldName = currentFieldDict.keys.first!.name_CD!
            self.currentICAO = currentFieldDict.keys.first!.icao_CD!
    }}
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = #colorLiteral(red: 0.1927910447, green: 0.210706085, blue: 0.2634028196, alpha: 1)
        vw.frame.size.width = tableView.frame.width - 5
        let labelSize = CGRect(x: 10, y: 0, width: vw.frame.width - 10, height: 30)
        let icaoLabel = UILabel(frame: labelSize)
        icaoLabel.textColor = .white
        icaoLabel.textAlignment = .center
        icaoLabel.text = "\(currentICAO)"
        vw.addSubview(icaoLabel)
        return vw
    }
    
    // MARK: Runway Variables Here
    var currentRunwayDict = [String: [Any]]()
    var chosenRwy = [Any]()
    func setSelectedRWY(indexPath: Int) {
        currentRunwayDict["H"] = [runways[indexPath].highID_CD!,
                                  runways[indexPath].length_CD,
                                  runways[indexPath].magHdgHi_CD,
                                  runways[indexPath].slopeHi_CD,
                                  runways[indexPath].elevHi_CD
        ]
        currentRunwayDict["L"] = [runways[indexPath].lowID_CD!,
                                  runways[indexPath].length_CD,
                                  runways[indexPath].magHdgLow_CD,
                                  runways[indexPath].slopeLow_CD,
                                  runways[indexPath].elevLow_CD
        ]
    }

    @IBAction func hiRwySelectedButton_(_ sender: UIButton) {
        if let indexPath = self.tableView.indexPathForView(sender) {
            print("indexPath: \(indexPath)")
            setSelectedRWY(indexPath: indexPath[1])
            chosenRwy = currentRunwayDict["H"]!
            let chosenRunway = ChosenRunway(airfieldName: airfieldName,
                                         runwayName: (chosenRwy[0] as! String),
                                         icao: currentICAO,
                                         runwayLength: (chosenRwy[1] as! Double),
                                         runwayHeading: (chosenRwy[2] as! Double),
                                         runwaySlope: (chosenRwy[3] as! Double))
            chosenRunwayDelegate?.getRunwayInfo(chosenRwy: chosenRunway)
        } else {
            print("Button indexPath not found")
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func lowRwySelectedButton_(_ sender: UIButton) {
        if let indexPath = self.tableView.indexPathForView(sender) {
            setSelectedRWY(indexPath: indexPath[1])
            chosenRwy = currentRunwayDict["L"]!
            let chosenRunway = ChosenRunway(airfieldName: airfieldName,
                                            runwayName: (chosenRwy[0] as! String),
                                            icao: currentICAO,
                                            runwayLength: (chosenRwy[1] as! Double),
                                            runwayHeading: (chosenRwy[2] as! Double),
                                            runwaySlope: (chosenRwy[3] as! Double))
            chosenRunwayDelegate?.getRunwayInfo(chosenRwy: chosenRunway)
        } else {
            print("Button indexPath not found")
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runways.count
    }

    func xwindColorifyLimits(wind: Double) -> UIColor {
        var color = UIColor.white
        if wind >= 30 {
            color = #colorLiteral(red: 1, green: 0.1505109668, blue: 0, alpha: 1)
        }
        if wind >= 20 && wind < 30{
            color = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }
        if wind >= 15 && wind < 20{
            color = #colorLiteral(red: 1, green: 0.5275554657, blue: 0, alpha: 1)
        }
        if wind >= 10 && wind < 15 {
            color = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
        }
        if wind < 10{
            color = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        }
        return color
    }
    
    func headWindColorifyLimits(wind: Double) -> UIColor {
        var color = UIColor.white
        if wind < -10 {
            color = #colorLiteral(red: 1, green: 0.1505109668, blue: 0, alpha: 1)
        }
        if wind >= -10 && wind < 0 {
            color = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }
        if wind >= 0 {
            color = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        }
        return color
    }
    
    func runwayIdColorifyFromWind(xWindColor: UIColor, hWindColor: UIColor) -> UIColor {
        var color = UIColor.white
        if xWindColor == #colorLiteral(red: 1, green: 0.1505109668, blue: 0, alpha: 1) || hWindColor == #colorLiteral(red: 1, green: 0.1505109668, blue: 0, alpha: 1) {
            color = #colorLiteral(red: 1, green: 0.1505109668, blue: 0, alpha: 1)
        }
        return color
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "runwayCell", for: indexPath) as! RunwayCell
        let hiRunwayHeading = Heading(Int(runways[indexPath.row].magHdgHi_CD))
        let lowRunwayHeading = Heading(Int(runways[indexPath.row].magHdgLow_CD))
        cell.lengthLabel.text = String(format: "%.0f", runways[indexPath.row].length_CD) + " Ft"
        cell.hi_RwyButtonOutlet.setTitle(runways[indexPath.row].highID_CD, for: .normal)
        cell.low_RwyButtonOutlet.setTitle(runways[indexPath.row].lowID_CD, for: .normal)
        if let currentWeather = self.metar {
            if currentWeather.isNil {
                cell.hi_RwyHwind.text = "HW: ---"
                cell.hi_RwyXwind.text = "XW: ---"
                cell.low_RwyXwind.text = "XW: ---"
                cell.low_RwyHwind.text = "HW: ---"
            } else {
                let windHeading = Heading(Int((currentWeather.windDirDegrees ?? "99"))!)
                let hiRWYwind = Wind(windHeading: windHeading, windSpeed: Double(currentWeather.windSpeedKts ?? "99")!, runwayHeading: hiRunwayHeading)
                let hi_xWind = hiRWYwind.crossWind
                let hi_hWind = hiRWYwind.headWind
                let lowRWYwind = Wind(windHeading: windHeading, windSpeed: Double(currentWeather.windSpeedKts ?? "99")!, runwayHeading: lowRunwayHeading)
                let low_xWind = lowRWYwind.crossWind
                let low_hWind = lowRWYwind.headWind
                cell.hi_RwyHwind.textColor = headWindColorifyLimits(wind: hi_hWind)
                cell.hi_RwyXwind.textColor = xwindColorifyLimits(wind: hi_xWind)
                cell.hi_RwyButtonOutlet.setTitleColor(runwayIdColorifyFromWind(xWindColor: xwindColorifyLimits(wind: hi_xWind),
                                                                               hWindColor: headWindColorifyLimits(wind: hi_hWind)),
                                                      for: .normal)
                
                cell.low_RwyHwind.textColor = headWindColorifyLimits(wind: low_hWind)
                cell.low_RwyXwind.textColor = xwindColorifyLimits(wind: low_xWind)
                cell.low_RwyButtonOutlet.setTitleColor(runwayIdColorifyFromWind(xWindColor: xwindColorifyLimits(wind: low_xWind),
                                                                                hWindColor: headWindColorifyLimits(wind: low_hWind)),
                                                       for: .normal)
                
                cell.hi_RwyHwind.text = "HW: \(String(format: "%.0f", hi_hWind))"
                cell.hi_RwyXwind.text = "XW: \(String(format: "%.0f", hi_xWind))"
                cell.low_RwyXwind.text = "XW: \(String(format: "%.0f", low_xWind))"
                cell.low_RwyHwind.text = "HW: \(String(format: "%.0f", low_hWind))"
            }
            
        }
        return cell
    }
    

}
