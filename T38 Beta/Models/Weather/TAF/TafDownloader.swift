//
//  TafDownloader.swift
//  T38
//
//  Created by Matthew Elmore on 4/7/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

protocol TafDelegate {
    func getTafs(_ taf: [Taf]?)
}

class TafDownloader {
    var delegate: TafDelegate?
    
    init(icao: String,
         delegate: UIViewController) {
        self.delegate = delegate as? TafDelegate
        getTafFor(icao: icao)
    }
    
    private let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    func getTafFor(icao: String) {
        let url = AddsWeatherAPI.weatherURL(type: .taf, icao: "\(icao)", parameters: nil)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            if let XMLData = data {
                let ct = TafParser(data: XMLData).tafs
                self.delegate?.getTafs(ct)
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
//Make ViewController Conform to TafDelegate
//  In viewDidLoad():
//      -- tafStore.delagate = self


//    Instantiating TafDownLoader will call the getTafFor(icao:)
//    var tafStore = TafDownLoader(icao: "KSFO", delagate: self)
//Declare this:
//func getTafFor(_ taf: [Taf]?) {
//    do something with your shit here
//}
