//
//  PlanningCellTableViewCell.swift
//  T38
//
//  Created by Matthew Elmore on 5/1/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

protocol ExportToForeFlightDelegate {
    func passToShareSheet(fileName: String, ext: String, stringToWriteToFile: String)
}


class PlanningCellTableViewCell: UITableViewCell {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setFormatting()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    var airfield: AirfieldCD?
    var mrcDelegate: ExportToForeFlightDelegate?
    var p9MDelegate: ExportToForeFlightDelegate?
    
    enum LabelType {
        case mainTitle
        case title
        case header
        case value
    }
    
    func labelFormatting(label: UILabel, type: LabelType) {
        var fontSize: CGFloat = 0.0
        switch type {
        case .mainTitle:
            fontSize = 20.0
        case .title:
            fontSize = 15.0
        case .header:
            fontSize = 9.0
        case .value:
            fontSize = 15.0
        }
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
    }
    
    func setFormatting() {
        mrcExportToForeFlightButtonOutlet.standardButtonFormatting()
        p9MExportToForeFlightButtonOutlet.standardButtonFormatting()
        let mainTitles = [icaoLabel,distanceAwayLabel]
        let titles = [maxRangeCruiseTitleLabel,ptNineMachTitleLabel]
        let headers = [mrcTimeTitleLabel,mrcFuelUsedTitleLabel,mrcFuelRemainingTitleLabel,p9MTimeTitleLabel,p9MFuelUsedTitleLabel,p9MFuelRemainingTitleLabel, airfieldNameLabel]
        let values = [mrcTimeValueLabel,mrcFuelUsedValueLabel,mrcFuelRemainingValueLabel,p9MTimeValueLabel,p9MFuelUsedValueLabel,p9MFuelRemainingValueLabel]
        for label in mainTitles {
            labelFormatting(label: label!, type: .mainTitle)
        }
        for label in titles {
            labelFormatting(label: label!, type: .title)
        }
        for label in headers {
            labelFormatting(label: label!, type: .header)
        }
        for label in values {
            labelFormatting(label: label!, type: .value)
        }
        
    }
    
    //Cell Header Labels
    @IBOutlet weak var icaoLabel: UILabel!
    @IBOutlet weak var airfieldNameLabel: UILabel!
    @IBOutlet weak var distanceAwayLabel: UILabel!
    //Max Range Cruise
    @IBOutlet weak var mrcView: UIView!
    @IBOutlet weak var maxRangeCruiseTitleLabel: UILabel!
    @IBOutlet weak var mrcTimeTitleLabel: UILabel!
    @IBOutlet weak var mrcFuelUsedTitleLabel: UILabel!
    @IBOutlet weak var mrcFuelRemainingTitleLabel: UILabel!
    //
    @IBOutlet weak var mrcTimeValueLabel: UILabel!
    @IBOutlet weak var mrcFuelUsedValueLabel: UILabel!
    @IBOutlet weak var mrcFuelRemainingValueLabel: UILabel!
    
    //0.9 Mach Cruise
    @IBOutlet weak var p9MachView: UIView!
    @IBOutlet weak var ptNineMachTitleLabel: UILabel!
    @IBOutlet weak var p9MTimeTitleLabel: UILabel!
    @IBOutlet weak var p9MFuelUsedTitleLabel: UILabel!
    @IBOutlet weak var p9MFuelRemainingTitleLabel: UILabel!
    
    //
    @IBOutlet weak var p9MTimeValueLabel: UILabel!
    @IBOutlet weak var p9MFuelUsedValueLabel: UILabel!
    @IBOutlet weak var p9MFuelRemainingValueLabel: UILabel!
    
    @IBOutlet weak var mrcExportToForeFlightButtonOutlet: UIButton!
    @IBOutlet weak var p9MExportToForeFlightButtonOutlet: UIButton!
    
    @IBAction func mrcExportFF(_ sender: UIButton) {
        let coords = [airfield!.longitude_CD, airfield!.latitude_CD]
        let icao = icaoLabel.text ?? "No ICAO"
//        let time = mrcTimeTitleLabel.text ?? "No Time"
        let fuelUsed = mrcFuelUsedTitleLabel.text ?? "No FU"
        let airfieldKML = CircleKML(radius: 10.0,
                                    centerPoint: coords,
                                    centerpointLabelTitle: "\(icao) | \(fuelUsed)#",
                                    lineColor: .darkBlue,
                                    iconType: .none,
                                    iconIncluded: false,
                                    centerpointLabelIncluded: true,
                                    width: 20).circleFilledInWithCenterLabel()
        let kml = OpenCloseKML(kmlItems: airfieldKML).KMLGenerator()
        if let mrcDelegate = self.mrcDelegate {
            mrcDelegate.passToShareSheet(fileName: icao, ext: "kml", stringToWriteToFile: kml)
        }
        
    }
    @IBAction func p9MExportToFF(_ sender: UIButton) {
        let coords = [airfield!.longitude_CD, airfield!.latitude_CD]
        let icao = icaoLabel.text ?? "No ICAO"
//        let time = mrcTimeTitleLabel.text ?? "No Time"
        let fuelUsed = mrcFuelUsedTitleLabel.text ?? "No FU"
        let airfieldKML = CircleKML(radius: 10.0,
                                    centerPoint: coords,
                                    centerpointLabelTitle: "\(icao) | \(fuelUsed)#",
                                    lineColor: .darkGreen,
                                    iconType: .none,
                                    iconIncluded: false,
                                    centerpointLabelIncluded: true,
                                    width: 20).circleFilledInWithCenterLabel()
        let kml = OpenCloseKML(kmlItems: airfieldKML).KMLGenerator()
        if let p9MDelegate = self.p9MDelegate {
            p9MDelegate.passToShareSheet(fileName: icao, ext: "kml", stringToWriteToFile: kml)
        }
    }

}
