//
//  MetarDownLoader.swift
//  T38
//
//  Created by Matthew Elmore on 4/7/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit


protocol MetarDelegate {
    func getCurrentMetar(_ metar: [Metar]?, metarLoc: MetarLoc, refreshUI: Bool)
}

struct MetarDownLoader {
    var delagate: MetarDelegate?
    var metarLoc: MetarLoc!
    var refreshUI: Bool!

    init(icao: String,
         delagate: UIViewController,
         metarLoc: MetarLoc,
         refreshUI: Bool) {
        self.delagate = delagate as? MetarDelegate
        self.metarLoc = metarLoc
        self.refreshUI = refreshUI
        getMetarFor(icao: icao)
    }
    
    init(icao: String,
         delegate: UITableViewController,
         metarLoc: MetarLoc,
         refreshUI: Bool){
        self.delagate = delegate as? MetarDelegate
        self.metarLoc = metarLoc
        self.refreshUI = refreshUI
        getMetarFor(icao: icao)
    }
    
    private let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    private func getMetarFor(icao: String) {
        let url = AddsWeatherAPI.weatherURL(type: .metar, icao: "\(icao)", parameters: nil)
        let request = URLRequest(url: url)
        let task = self.session.dataTask(with: request) { (data, response, error) -> Void in
            if let XMLData = data {
                let cm = MetarParser(data: XMLData).metars
                DispatchQueue.main.async {
                    self.delagate?.getCurrentMetar(cm, metarLoc: self.metarLoc, refreshUI: self.refreshUI)
                }
            } else if let requestError = error {
                print("Error fetching metar: \(requestError)")
            } else {
                print("Unexpected error with request")
            }
        }
        task.resume()
    }
}

//Add the following to the ViewController calling this:
//Make ViewController Conform to MetarDelegate
//  In viewDidLoad():
//      -- metarStore.delagate = self


//    Instantiating MetarDownLoader will call the getCurrentMetar
//    var metarStore = MetarDownLoader(icao: "KSFO", delagate: self)
//Declare this:
//func getCurrentMetar(_ metar: [Metar]?) {
//    if let metar_ = metar {
//        guard let altSetting = metar_[0].altimeterInHg else {return}
//    }
//}
