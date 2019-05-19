//
//  JSONHandler.swift
//  T38
//
//  Created by elmo on 5/8/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class JSONHandler  {
    let cdu = CoreDataUtilies()
    static var allStatesDownloaded = false
    
    private let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! //as URL?)!
    
    // MARK: DAFIF
    func downloadAllStates() {
        for state in StateCode.allValues {
            downloadData("\(cdu.getUserDefaults().baseDafifUrl_UD)\(state.rawValue)", fileNamewithExtension: "\(state.rawValue).json")
        }}
    
    //////////////////////////////////////////////// INITIAL VERIFICATION FUNCTION ////////////////////////////////////////////////
    /*I HATE MULTI THREADING!!!! but this one finally effing works...
     it checks to make sure all the states have been downloaded, if they haven't it downloads them. When that is complete
     it checks to make sure all of the states have been loaded into the CD... if the haven't it loads them into CoreData. Thank you and good night. I quit!
     */
    func initialVerification(pc: NSPersistentContainer, moc: NSManagedObjectContext) {
        let cdu = CoreDataUtilies()
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var allStates: [String] = []
        var missingStates: [String] = []
        for state in StateCode.allValues {
            allStates.append(state.rawValue)
            let fileName = "\(state.rawValue).json"
            let fileAndPath = documentsUrl.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: fileAndPath.path) {
            } else {
                missingStates.append(state.rawValue)
            }
        }
        print("*****************************************************************************")
        print("Total Number of States: \(allStates.count)")
        print("*****************************************************************************")
        print("Number of States Missing: \(missingStates.count)")
        print("*****************************************************************************")
        if missingStates.count > 0 {
            print("Missing States Being Downloaded: \(missingStates)")
            print("*****************************************************************************")
            var counter = 0
            for state in missingStates {
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig)
                let request = URLRequest(url: URL(string: "\(cdu.getUserDefaults().baseDafifUrl_UD)\(state)")!)
                let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                    let destinationFileUrl = documentsUrl.appendingPathComponent("\(state).json")
                    if let tempLocalUrl = tempLocalUrl, error == nil {
                        // Success
                        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                            print("Successfully downloaded. Status code: \(statusCode)")
                        }
                        do {
                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                            counter += 1
                            print(missingStates.count)
                            print(counter)
                            if counter == missingStates.count {
                                cdu.verifyCoreDataMatchesJSON(pc: pc, moc: moc)
                            }
                        } catch (let writeError) {
                            print("Error creating a file \(destinationFileUrl) : \(writeError)")
                        }
                    } else {
                        print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
                    }
                }
                
                task.resume()
            }
        }
    }
    
    
    func initialVerification(pc: NSPersistentContainer, moc: NSManagedObjectContext) -> Bool {
        var allStatesHere = true
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var allStates: [String] = []
        var missingStates: [String] = []
        for state in StateCode.allValues {
            allStates.append(state.rawValue)
            let fileName = "\(state.rawValue).json"
            let fileAndPath = documentsUrl.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: fileAndPath.path) {
            } else {
                missingStates.append(state.rawValue)
            }
        }
        print("*****************************************************************************")
        print("Total Number of States: \(allStates.count)")
        print("*****************************************************************************")
        print("Number of States Missing: \(missingStates.count)")
        print("*****************************************************************************")
        if missingStates.count > 0 {
            print("Missing States Being Downloaded: \(missingStates)")
            print("*****************************************************************************")
            allStatesHere = false
        }
        print(allStatesHere)
        return allStatesHere
    }
    
    
    
    func initialVerificationWithTabBarMuting(pc: NSPersistentContainer, moc: NSManagedObjectContext, tabBarItem: UITabBarItem) {
        let cdu = CoreDataUtilies()
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var allStates: [String] = []
        var missingStates: [String] = []
        for state in StateCode.allValues {
            allStates.append(state.rawValue)
            let fileName = "\(state.rawValue).json"
            let fileAndPath = documentsUrl.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: fileAndPath.path) {
            } else {
                missingStates.append(state.rawValue)
            }
        }
        print("*****************************************************************************")
        print("Total Number of States: \(allStates.count)")
        print("*****************************************************************************")
        print("Number of States Missing: \(missingStates.count)")
        print("*****************************************************************************")
        if missingStates.count > 0 {
            tabBarItem.isEnabled = false
            print("Missing States Being Downloaded: \(missingStates)")
            print("*****************************************************************************")
            var counter = 0
            for state in missingStates {
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig)
                let request = URLRequest(url: URL(string: "\(cdu.getUserDefaults().baseDafifUrl_UD)\(state)")!)
                let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                    let destinationFileUrl = documentsUrl.appendingPathComponent("\(state).json")
                    if let tempLocalUrl = tempLocalUrl, error == nil {
                        // Success
                        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                            print("Successfully downloaded. Status code: \(statusCode)")
                        }
                        do {
                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                            counter += 1
                            print(missingStates.count)
                            print(counter)
                            if counter == missingStates.count {
                                cdu.verifyCoreDataMatchesJSONwithMutedTabBarItem(pc: pc, moc: moc, tabBarItem: tabBarItem)
                            }
                        } catch (let writeError) {
                            print("Error creating a file \(destinationFileUrl) : \(writeError)")
                        }
                    } else {
                        print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
                    }
                }
                
                task.resume()
            }
        }
    }
    
    //////////////////////////////////////////////// INITIAL VERIFICATION FUNCTION ////////////////////////////////////////////////
    func initialVerificationWithTabBarMutingAndProgressBar(pc: NSPersistentContainer, moc: NSManagedObjectContext, tabBarItem: UITabBarItem, progress: @escaping () -> Void ) {
        let cdu = CoreDataUtilies()
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var allStates: [String] = []
        var missingStates: [String] = []
        for state in StateCode.allValues {
            allStates.append(state.rawValue)
            let fileName = "\(state.rawValue).json"
            let fileAndPath = documentsUrl.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: fileAndPath.path) {
            } else {
                missingStates.append(state.rawValue)
            }
        }
        print("*****************************************************************************")
        print("Total Number of States: \(allStates.count)")
        print("*****************************************************************************")
        print("Number of States Missing: \(missingStates.count)")
        print("*****************************************************************************")
        if missingStates.count > 0 {
            tabBarItem.isEnabled = false
            print("Missing States Being Downloaded: \(missingStates)")
            print("*****************************************************************************")
            var counter = 0
            for state in missingStates {
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig)
                let request = URLRequest(url: URL(string: "\(cdu.getUserDefaults().baseDafifUrl_UD)\(state)")!)
                let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                    let destinationFileUrl = documentsUrl.appendingPathComponent("\(state).json")
                    if let tempLocalUrl = tempLocalUrl, error == nil {
                        // Success
                        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                            print("Successfully downloaded. Status code: \(statusCode)")
                        }
                        do {
                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                            counter += 1
                            print(missingStates.count)
                            print(counter)
                            if counter == missingStates.count {
                                cdu.verifyCoreDataMatchesJSONwithMutedTabBarItemAndProgressBar(pc: pc, moc: moc, tabBarItem: tabBarItem, progress: progress)
                                
                            }
                        } catch (let writeError) {
                            print("Error creating a file \(destinationFileUrl) : \(writeError)")
                        }
                    } else {
                        print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
                    }
                    DispatchQueue.main.async {
                        progress()
                    }
                }
                
                
                task.resume()
            }
        }
    }
    //////////////////////////////////////////////// INITIAL VERIFICATION FUNCTION END ////////////////////////////////////////////////
    
    func initialVerificationWithProgressBar(pc: NSPersistentContainer, moc: NSManagedObjectContext, progress: @escaping () -> Void ) {
        let cdu = CoreDataUtilies()
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var allStates: [String] = []
        var missingStates: [String] = []
        for state in StateCode.allValues {
            allStates.append(state.rawValue)
            let fileName = "\(state.rawValue).json"
            let fileAndPath = documentsUrl.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: fileAndPath.path) {
            } else {
                missingStates.append(state.rawValue)
            }
        }
        print("*****************************************************************************")
        print("Total Number of States: \(allStates.count)")
        print("*****************************************************************************")
        print("Number of States Missing: \(missingStates.count)")
        print("*****************************************************************************")
        if missingStates.count > 0 {
            print("Missing States Being Downloaded: \(missingStates)")
            print("*****************************************************************************")
            var counter = 0
            for state in missingStates {
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig)
                let request = URLRequest(url: URL(string: "\(cdu.getUserDefaults().baseDafifUrl_UD)\(state)")!)
                let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                    let destinationFileUrl = documentsUrl.appendingPathComponent("\(state).json")
                    if let tempLocalUrl = tempLocalUrl, error == nil {
                        // Success
                        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                            print("Successfully downloaded. Status code: \(statusCode)")
                        }
                        do {
                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                            counter += 1
                            print(missingStates.count)
                            print(counter)
                            if counter == missingStates.count {
                                cdu.verifyCoreDataMatchesJSONwithProgressBar(pc: pc, moc: moc, progress: progress)
                                
                            }
                        } catch (let writeError) {
                            print("Error creating a file \(destinationFileUrl) : \(writeError)")
                        }
                    } else {
                        print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
                    }
                    DispatchQueue.main.async {
                        progress()
                    }
                }
                
                
                task.resume()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    //////////////////////////////////////////////// INITIAL VERIFICATION FUNCTION  ////////////////////////////////////////////////
    /* This one works... but it only checks for and then downloads the missing states.... it doesn't load them into CoreData
     Why Keep them both you ask... becuse FU thats why.
    */
    func verifyIfStatesDownloadedfrom() -> [String] {
        var allStates: [String] = []
        var missingStates: [String] = []
        for state in StateCode.allValues {
            allStates.append(state.rawValue)
            let fileName = "\(state.rawValue).json"
            let fileAndPath = self.documentsUrl.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: fileAndPath.path) {
            } else {
                missingStates.append(state.rawValue)
            }
        }
        
        if missingStates.count > 0 {
            downloadMissingStates(missingStates, from: cdu.getUserDefaults().baseDafifUrl_UD)
        }
        print("*****************************************************************************")
        print("Total Number of States: \(allStates.count)")
        print("*****************************************************************************")
        print("Number of States Missing: \(missingStates.count)")
        print("*****************************************************************************")
        if missingStates.count > 0 {
            print("Missing States Being Downloaded: \(missingStates)")
            print("*****************************************************************************")
        }
        return missingStates
    }
    
    func downloadMissingStates(_ ms: [String], from url: String){
        for state in ms {
            downloadData("\(url)\(state)", fileNamewithExtension: "\(state).json")
        }
    }
    
    
    // MARK: General FileHandling
    func downloadData(_ sourceFile: String, fileNamewithExtension fileName: String) {
        // Create destination URL
        let destinationFileUrl = self.documentsUrl.appendingPathComponent(fileName)
        //Create URL to the source file you want to download
        let fileURL = URL(string: sourceFile)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                    
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
            }}; task.resume() }
    
    func removeFile(fileNamewithExtension fileName: String) {
        let fileToRemove = self.documentsUrl.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileToRemove)
        } catch {
            print(error)
        }}
    
    func removeAllFiles() {
        do {
            let folderContents = try FileManager.default.contentsOfDirectory(at: self.documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for file in folderContents {
                try FileManager.default.removeItem(at: file)
            }
        } catch {
            print(error)
        }}
    
    func printAvailableDownloads(){
        do {
            try print(FileManager.default.contentsOfDirectory(at: self.documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles))
        } catch {
            print(error)
        }}
    
    
    //////////////////////////////////////////////// NOTHING TO SEE HERE - JUST THE WEATHER DOWNLOADER ////////////////////////////////////////////////
    // MARK: Weather
    func downloadWeather(baseUrl: String, icao: String) {
        let fileName = "\(icao).json"
        let fileAndPath = self.documentsUrl.appendingPathComponent(fileName)
        print(fileAndPath)
        let fullUrl = "\(baseUrl)\(icao)"
        if FileManager.default.fileExists(atPath: fileAndPath.path) {
            removeFile(fileNamewithExtension: fileName)
            downloadData(fullUrl, fileNamewithExtension: fileName)
            print("\(icao) weather downlaoded")
        } else {
            downloadData(fullUrl, fileNamewithExtension: fileName)
            print("\(icao) weather downlaoded")
        }
    }
    
//    func currentWeather(icao: String) -> Weather? {
//        var currentWeather: Weather?
//        let weatherUrl = self.documentsUrl.appendingPathComponent("\(icao).json")
//        let decoder = JSONDecoder()
//        do {
//            currentWeather = try decoder.decode(Weather.self, from: Data(contentsOf: weatherUrl))
//        } catch {
//            print(error)
//        }
//        return currentWeather
//    }
    
    func downloadWeatherWithEscaping(baseUrl: String, icao: String, processWeather: @escaping (String) -> Void) {
        let fileName = "\(icao).json"
        let fileAndPath = self.documentsUrl.appendingPathComponent(fileName)
        let fullUrl = "\(baseUrl)\(icao)"
        if FileManager.default.fileExists(atPath: fileAndPath.path) {
            removeFile(fileNamewithExtension: fileName)
            downloadDataWithEscaping(fullUrl, fileNamewithExtension: fileName, icao: icao, processWeather: processWeather)
            print("\(icao) weather downlaoded")
        } else {
            downloadDataWithEscaping(fullUrl, fileNamewithExtension: fileName, icao: icao, processWeather: processWeather)
            print("\(icao) weather downlaoded")
        }
    }
    
//    func downloadWeatherWithEscapeAndATISCheatCode(baseUrl: String, icao: String, button: UIButton, processWeather: @escaping (String) -> Void) {
//        let fileName = "\(icao).json"
//        let fileAndPath = self.documentsUrl.appendingPathComponent(fileName)
//        let fullUrl = "\(baseUrl)\(icao)"
//        if FileManager.default.fileExists(atPath: fileAndPath.path) {
//            removeFile(fileNamewithExtension: fileName)
//            downloadDataWithEscapeAndATISCheatCode(fullUrl, fileNamewithExtension: fileName, icao: icao, button: button, processWeather: processWeather)
//            print("\(icao) weather downlaoded")
//        } else {
//            downloadDataWithEscapeAndATISCheatCode(fullUrl, fileNamewithExtension: fileName, icao: icao, button: button, processWeather: processWeather)
//            print("\(icao) weather downlaoded")
//        }
//    }
//
//    func downloadDataWithEscapeAndATISCheatCode(_ sourceFile: String, fileNamewithExtension fileName: String, icao: String, button: UIButton, processWeather: @escaping (String) -> Void) {
//        // Create destination URL
//        let destinationFileUrl = self.documentsUrl.appendingPathComponent(fileName)
//        //Create URL to the source file you want to download
//        let fileURL = URL(string: sourceFile)
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//        let request = URLRequest(url:fileURL!)
//        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//            if let tempLocalUrl = tempLocalUrl, error == nil {
//                // Success
//                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                    print("Successfully downloaded. Status code: \(statusCode)")
//                    OperationQueue.main.addOperation {
//                        button.isHidden = false
//                    }
//                }
//
//                do {
//                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//
//                    DispatchQueue.main.async {
//                        processWeather(icao)
//                    }
//                } catch (let writeError) {
//                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                }
//            } else {
//                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
//            }}; task.resume() }
    
    func downloadWeatherWithEscapeAndATISCheatCode(baseUrl: String, icao: String, processWeather: @escaping (String) -> Void, performSequePopUp: @escaping () -> Void) {
        let fileName = "\(icao).json"
        let fileAndPath = self.documentsUrl.appendingPathComponent(fileName)
        let fullUrl = "\(baseUrl)\(icao)"
        if FileManager.default.fileExists(atPath: fileAndPath.path) {
            removeFile(fileNamewithExtension: fileName)
            downloadDataWithEscapeAndATISCheatCode(fullUrl, fileNamewithExtension: fileName, icao: icao, processWeather: processWeather, performSequePopUp: performSequePopUp)
            print("\(icao) weather downlaoded")
        } else {
            downloadDataWithEscapeAndATISCheatCode(fullUrl, fileNamewithExtension: fileName, icao: icao, processWeather: processWeather, performSequePopUp: performSequePopUp)
            print("\(icao) weather downlaoded")
        }
    }
    
    func downloadDataWithEscapeAndATISCheatCode(_ sourceFile: String, fileNamewithExtension fileName: String, icao: String, processWeather: @escaping (String) -> Void, performSequePopUp: @escaping () -> Void) {
        // Create destination URL
        let destinationFileUrl = self.documentsUrl.appendingPathComponent(fileName)
        //Create URL to the source file you want to download
        let fileURL = URL(string: sourceFile)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                    OperationQueue.main.addOperation {
                    }
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    
                    DispatchQueue.main.async {
                        processWeather(icao)
                        performSequePopUp()
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
            }}; task.resume() }
    
    
    
    
    
    
    
    
    func downloadDataWithEscaping(_ sourceFile: String, fileNamewithExtension fileName: String, icao: String, processWeather: @escaping (String) -> Void) {
        // Create destination URL
        let destinationFileUrl = self.documentsUrl.appendingPathComponent(fileName)
        //Create URL to the source file you want to download
        let fileURL = URL(string: sourceFile)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                    
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    
                    DispatchQueue.main.async {
                        processWeather(icao)   
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
            }}; task.resume() }

    
    


    
    
//    func downloadWeatherWithIndicator(baseUrl: String, icao: String, button: UIButton) {
//        let fileName = "\(icao).json"
//        let fileAndPath = self.documentsUrl.appendingPathComponent(fileName)
//        let fullUrl = "\(baseUrl)\(icao)"
//        if FileManager.default.fileExists(atPath: fileAndPath.path) {
//            removeFile(fileNamewithExtension: fileName)
//            downloadDataWithIndicator(fullUrl, fileNamewithExtension: fileName, button: button)
//            print("\(icao) weather downlaoded")
//        } else {
//            downloadDataWithIndicator(fullUrl, fileNamewithExtension: fileName, button: button)
//            print("\(icao) weather downlaoded")
//        }
//    }

    
//    func downloadDataWithIndicator(_ sourceFile: String, fileNamewithExtension fileName: String, button: UIButton) {
//        // Create destination URL
//        let destinationFileUrl = self.documentsUrl.appendingPathComponent(fileName)
//        //Create URL to the source file you want to download
//        let fileURL = URL(string: sourceFile)
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//        let request = URLRequest(url:fileURL!)
//        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//            if let tempLocalUrl = tempLocalUrl, error == nil {
//                // Success
//                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                    print("Successfully downloaded. Status code: \(statusCode)")
//                    OperationQueue.main.addOperation {
//                        button.isHidden = false
//                    }
//                }
//
//                do {
//                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//                } catch (let writeError) {
//                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                }
//            } else {
//                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
//            }}; task.resume() }
    
    
    
    
    
    
    
    
    
    
}

































