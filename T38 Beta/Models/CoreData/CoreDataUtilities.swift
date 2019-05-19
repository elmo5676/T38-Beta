//
//  CoreDataUtilies.swift
//  T38
//
//  Created by elmo on 5/3/18.
//  Copyright © 2018 elmo. All rights reserved.
//

//import Foundation
import UIKit
import CoreData
import CoreLocation

class CoreDataUtilies {
    // MARK: UserDefaults List
    let defaults = UserDefaults.standard
    var dafifUrlJSONBase = "http://getatis.com/DAFIF/GetAirfieldsByState?state="
    var weatherUrlJSONBase = "https://www.getatis.com/services/GetMETAR?stations="
    var moc: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    

    func setProgressBarStatus(progressBarCurentStatus: Float) -> Float {
        var currentProgress: Float = 0.0
        defaults.set(progressBarCurentStatus, forKey: "progressBarStatus")
        currentProgress = defaults.float(forKey: "progressBarStatus")
        return currentProgress
    }
    
    func initialLoadPopupCounter(popUpCounter: Int) -> Int {
        var popUpCounter: Int = popUpCounter
        defaults.set(popUpCounter, forKey: "popUpCounter")
        popUpCounter = defaults.integer(forKey: "popUpCounter")
        return popUpCounter
    }

    
    // MARK: - TOLD Settings
    func setUserSettings(useHomeField: Bool,
                                homeAirfieldICAO: String,
                                minRwyLength: String
        ) {
        defaults.set(useHomeField, forKey: "useHomeField_UD")
        defaults.set(homeAirfieldICAO.uppercased(), forKey: "homeAirfieldICAO_UD")
        defaults.set(minRwyLength, forKey: "minRwyLength_UD")
    }
    func getUserSettings() -> (useHomeField_UD: Bool,
        homeAirfieldICAO_UD: String,
        minRwyLength_UD: String){
            let useHomeField = defaults.bool(forKey: "useHomeField_UD")
            let homeAirfieldICAO = defaults.string(forKey: "homeAirfieldICAO_UD") ?? ""
            let minRwyLength = defaults.string(forKey: "minRwyLength_UD") ?? ""
            return (useHomeField_UD: useHomeField,
                    homeAirfieldICAO_UD: homeAirfieldICAO,
                    minRwyLength_UD: minRwyLength)
    }
    
    // MARK: - TOLD Defaults
    func setUserDefaults(runwayLength: String,
                         aeroBraking: String,
                         tempScaleCorF: String,
                         aircraftGrossWeight: String,
                         aircraftBasicWeight: String,
                         fuelWeight: String,
                         pilotAndGearWeight: String,
                         podInstalled: String,
                         weightOfCargoInPOD: String,
                         weightUsedForTOLD: String,
                         givenEngineFailure: String,
                         temperature: String,
                         pressureAlt: String,
                         runwayHeading: String,
                         windDirection: String,
                         windVelocity: String,
                         runwaySlope: String,
                         rcr: String
                         ){
        
        defaults.set(runwayLength, forKey: "runwayLength_UD")
        defaults.set(self.weatherUrlJSONBase, forKey: "baseWeatherUrl_UD")
        defaults.set(self.dafifUrlJSONBase, forKey: "baseDafifUrl_UD")
        defaults.set(aeroBraking, forKey: "aeroBraking_UD")
        defaults.set(tempScaleCorF, forKey: "tempScaleCorF_UD")
        defaults.set(aircraftGrossWeight, forKey: "aircraftGrossWeight_UD")
        defaults.set(aircraftBasicWeight, forKey: "aircraftBasicWeight_UD")
        defaults.set(fuelWeight, forKey: "fuelWeight_UD")
        defaults.set(pilotAndGearWeight, forKey: "pilotAndGearWeight_UD")
        defaults.set(podInstalled, forKey: "podInstalled_UD")
        defaults.set(weightOfCargoInPOD, forKey: "weightOfCargoInPOD_UD")
        defaults.set(weightUsedForTOLD, forKey: "weightUsedForTOLD_UD")
        defaults.set(givenEngineFailure, forKey: "givenEngineFailure_UD")
        defaults.set(temperature, forKey: "temperature_UD")
        defaults.set(pressureAlt, forKey: "pressureAlt_UD")
        defaults.set(runwayHeading, forKey: "runwayHeading_UD")
        defaults.set(windDirection, forKey: "windDirection_UD")
        defaults.set(windVelocity, forKey: "windVelocity_UD")
        defaults.set(runwaySlope, forKey: "runwaySlope_UD")
        defaults.set(rcr, forKey: "rcr_UD")
    }
    
    func getUserDefaults() -> (runwayLength_UD: String,
        baseWeatherUrl_UD: String,
        baseDafifUrl_UD: String,
        aeroBraking_UD: String,
        tempScaleCorF_UD: String,
        aircraftGrossWeight_UD: String,
        aircraftBasicWeight_UD: String,
        fuelWeight_UD: String,
        pilotAndGearWeight_UD: String,
        podInstalled_UD: String,
        weightOfCargoInPOD_UD: String,
        weightUsedForTOLD_UD: String,
        givenEngineFailure_UD: String,
        temperature_UD: String,
        pressureAlt_UD: String,
        runwayHeading_UD: String,
        windDirection_UD: String,
        windVelocity_UD: String,
        runwaySlope_UD: String,
        rcr_UD: String
        ){
            
            let runwayLength = defaults.string(forKey: "runwayLength_UD") ?? ""
            let aeroBraking = defaults.string(forKey: "aeroBraking_UD") ?? ""
            let tempScaleCorF = defaults.string(forKey: "tempScaleCorF_UD") ?? ""
            let aircraftGrossWeight = defaults.string(forKey: "aircraftGrossWeight_UD") ?? ""
            let aircraftBasicWeight = defaults.string(forKey: "aircraftBasicWeight_UD") ?? ""
            let fuelWeight = defaults.string(forKey: "fuelWeight_UD") ?? ""
            let pilotAndGearWeight = defaults.string(forKey: "pilotAndGearWeight_UD") ?? ""
            let podInstalled = defaults.string(forKey: "podInstalled_UD") ?? ""
            let weightOfCargoInPOD = defaults.string(forKey: "weightOfCargoInPOD_UD") ?? ""
            let weightUsedForTOLD = defaults.string(forKey: "weightUsedForTOLD_UD") ?? ""
            let givenEngineFailure = defaults.string(forKey: "givenEngineFailure_UD") ?? ""
            let temperature = defaults.string(forKey: "temperature_UD") ?? ""
            let pressureAlt = defaults.string(forKey: "pressureAlt_UD") ?? ""
            let runwayHeading = defaults.string(forKey: "runwayHeading_UD") ?? ""
            let windDirection = defaults.string(forKey: "windDirection_UD") ?? ""
            let windVelocity = defaults.string(forKey: "windVelocity_UD") ?? ""
            let runwaySlope = defaults.string(forKey: "runwaySlope_UD") ?? ""
            let rcr = defaults.string(forKey: "rcr_UD") ?? ""
            
            return (runwayLength_UD: runwayLength,
                    baseWeatherUrl_UD: self.weatherUrlJSONBase,
                    baseDafifUrl_UD: self.dafifUrlJSONBase,
                    aeroBraking_UD: aeroBraking,
                    tempScaleCorF_UD: tempScaleCorF,
                    aircraftGrossWeight_UD: aircraftGrossWeight,
                    aircraftBasicWeight_UD : aircraftBasicWeight,
                    fuelWeight_UD: fuelWeight,
                    pilotAndGearWeight_UD: pilotAndGearWeight,
                    podInstalled_UD: podInstalled,
                    weightOfCargoInPOD_UD: weightOfCargoInPOD,
                    weightUsedForTOLD_UD: weightUsedForTOLD,
                    givenEngineFailure_UD: givenEngineFailure,
                    temperature_UD: temperature,
                    pressureAlt_UD: pressureAlt,
                    runwayHeading_UD: runwayHeading,
                    windDirection_UD: windDirection,
                    windVelocity_UD: windVelocity,
                    runwaySlope_UD: runwaySlope,
                    rcr_UD: rcr
            )
    }
    
    //////////////////////////////////////////////// PRINT RESULTS FUNCTION ////////////////////////////////////////////////
    func printResults(moc: NSManagedObjectContext) -> (numOfAirfields: Int, numOfRunways: Int, numOfNavaids: Int, numOfComms: Int) {
        var numOfAirfields = 0
        var numOfRunways = 0
        var numOfNavaids = 0
        var numOfComms = 0
        do {
            let runwayRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RunwayCD")
            let runwayCount = try moc.count(for: runwayRequest)
            numOfRunways = runwayCount
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        do {
            let navRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NavaidCD")
            let navCount = try moc.count(for: navRequest)
            numOfNavaids = navCount
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        do {
            let comRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CommunicationCD")
            let comCount = try moc.count(for: comRequest)
            numOfComms = comCount
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        do {
            let airportValidationRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AirfieldCD")
            let airportCount = try moc.count(for: airportValidationRequest)
            numOfAirfields = airportCount
        }   catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        print("Number of Runways: \(numOfAirfields)")
        print("Number of Runways: \(numOfRunways)")
        print("Number of Navaids: \(numOfNavaids)")
        print("Number of Freqs: \(numOfComms)")
        return (numOfAirfields: numOfAirfields, numOfRunways: numOfRunways, numOfNavaids: numOfNavaids, numOfComms: numOfComms)
    }
    //////////////////////////////////////////////// PRINT RESULTS FUNCTION ////////////////////////////////////////////////

    //////////////////////////////////////////////// VERIFY CD MATCHES JSON FUNCTION ////////////////////////////////////////////////
    func verifyCoreDataMatchesJSON(pc: NSPersistentContainer ,moc: NSManagedObjectContext) {
        pc.performBackgroundTask({ context in
            let startTime = Date()
            var airfieldReturn = false
            var runwayReturn = false
            var navaidReturn = false
            var commReturn = false
            var counterAirfieldsJSON = 0
            var counterRunwaysJSON = 0
            var counterNavaidsJSON = 0
            var counterCommsJSON = 0
            let counterAirfieldsCD = self.printResults(moc: context).numOfAirfields
            let counterRunwaysCD = self.printResults(moc: context).numOfRunways
            let counterNavaidsCD = self.printResults(moc: context).numOfNavaids
            let counterCommsCD = self.printResults(moc: context).numOfComms
            let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            for state in StateCode.allValues {
                let airfieldstURL = documentsURL.appendingPathComponent(state.rawValue).appendingPathExtension("json")
                let decoder = JSONDecoder()
                do {
                    let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
                    counterAirfieldsJSON += resultAirfields.count
                    for airfield in resultAirfields {
                        counterRunwaysJSON += airfield.runways.count
                        counterNavaidsJSON += airfield.navaids.count
                        counterCommsJSON += airfield.communications.count
                    }
                } catch {print(error)}
            }
            if counterAirfieldsCD == counterAirfieldsJSON {
                airfieldReturn = true
            }
            if counterRunwaysCD == counterRunwaysJSON {
                runwayReturn = true
            }
            if counterNavaidsCD == counterNavaidsJSON {
                navaidReturn = true
            }
            if counterCommsCD == counterCommsJSON {
                commReturn = true
            }
            print("*****************************************************************************")
            print("Airfields in JSON: \(counterAirfieldsJSON)")
            print("Airfields in CoreData: \(counterAirfieldsCD)")
            print("*****************************************************************************")
            print("Runways in JSON: \(counterRunwaysJSON)")
            print("Runways in CoreData: \(counterRunwaysCD)")
            print("*****************************************************************************")
            print("Navaids in JSON: \(counterNavaidsJSON)")
            print("Navaids in CoreData: \(counterNavaidsCD)")
            print("*****************************************************************************")
            print("Comms in JSON: \(counterCommsJSON)")
            print("Comms in CoreData: \(counterCommsCD)")
            print("*****************************************************************************")
            let endTime = Date()
            print("Airfields match: \(airfieldReturn)")
            print("Runways match: \(runwayReturn)")
            print("Navaids match: \(navaidReturn)")
            print("Comms match: \(commReturn)")
            print("*****************************************************************************")
            print("Completion Time: \(endTime.timeIntervalSince(startTime))")
            print("*****************************************************************************")
            
            
            if airfieldReturn == false || counterAirfieldsCD == 0  || counterAirfieldsCD > counterAirfieldsJSON || runwayReturn == false || counterRunwaysCD == 0 || counterRunwaysCD > counterRunwaysJSON {
                self.deleteAirfieldsFromDB(moc: context)
                self.deleteRunwaysFromDB(moc: context)
                var counter = 1
                let start = Date()
                for state in StateCode.allValues {
                    self.loadAirfieldsAndRunwaysToDBfromJSON(state.rawValue, moc: context)
                    DispatchQueue.main.async {
                        _ = self.printResults(moc: context)
                        print(counter)
                        counter += 1
                        let end = Date()
                        print("Completion Time: \(end.timeIntervalSince(start))")
                    }
                }
            } else {
                print("Airfield and Runway JSON has previously, succesfully been loaded into CoreData")
            }
            DispatchQueue.main.async {
                print("Done")
            }
        })
    }
    //////////////////////////////////////////////// VERIFY CD MATCHES JSON FUNCTION ////////////////////////////////////////////////
    
    //////////////////////////////////////////////// VERIFY CD MATCHES JSON With TAB BAR MUTING  ////////////////////////////////////
    func verifyCoreDataMatchesJSONwithMutedTabBarItem(pc: NSPersistentContainer ,moc: NSManagedObjectContext, tabBarItem: UITabBarItem) {
        pc.performBackgroundTask({ context in
            let startTime = Date()
            var airfieldReturn = false
            var runwayReturn = false
            var navaidReturn = false
            var commReturn = false
            var counterAirfieldsJSON = 0
            var counterRunwaysJSON = 0
            var counterNavaidsJSON = 0
            var counterCommsJSON = 0
            let counterAirfieldsCD = self.printResults(moc: context).numOfAirfields
            let counterRunwaysCD = self.printResults(moc: context).numOfRunways
            let counterNavaidsCD = self.printResults(moc: context).numOfNavaids
            let counterCommsCD = self.printResults(moc: context).numOfComms
            let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            for state in StateCode.allValues {
                let airfieldstURL = documentsURL.appendingPathComponent(state.rawValue).appendingPathExtension("json")
                let decoder = JSONDecoder()
                do {
                    let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
                    counterAirfieldsJSON += resultAirfields.count
                    for airfield in resultAirfields {
                        counterRunwaysJSON += airfield.runways.count
                        counterNavaidsJSON += airfield.navaids.count
                        counterCommsJSON += airfield.communications.count
                    }
                } catch {print(error)}
            }
            if counterAirfieldsCD == counterAirfieldsJSON {
                airfieldReturn = true
            }
            if counterRunwaysCD == counterRunwaysJSON {
                runwayReturn = true
            }
            if counterNavaidsCD == counterNavaidsJSON {
                navaidReturn = true
            }
            if counterCommsCD == counterCommsJSON {
                commReturn = true
            }
            print("*****************************************************************************")
            print("Airfields in JSON: \(counterAirfieldsJSON)")
            print("Airfields in CoreData: \(counterAirfieldsCD)")
            print("*****************************************************************************")
            print("Runways in JSON: \(counterRunwaysJSON)")
            print("Runways in CoreData: \(counterRunwaysCD)")
            print("*****************************************************************************")
            print("Navaids in JSON: \(counterNavaidsJSON)")
            print("Navaids in CoreData: \(counterNavaidsCD)")
            print("*****************************************************************************")
            print("Comms in JSON: \(counterCommsJSON)")
            print("Comms in CoreData: \(counterCommsCD)")
            print("*****************************************************************************")
            let endTime = Date()
            print("Airfields match: \(airfieldReturn)")
            print("Runways match: \(runwayReturn)")
            print("Navaids match: \(navaidReturn)")
            print("Comms match: \(commReturn)")
            print("*****************************************************************************")
            print("Completion Time: \(endTime.timeIntervalSince(startTime))")
            print("*****************************************************************************")
            
            
            if airfieldReturn == false || counterAirfieldsCD == 0  || counterAirfieldsCD > counterAirfieldsJSON || runwayReturn == false || counterRunwaysCD == 0 || counterRunwaysCD > counterRunwaysJSON {
                self.deleteAirfieldsFromDB(moc: context)
                self.deleteRunwaysFromDB(moc: context)
                var counter = 1
                let start = Date()
                for state in StateCode.allValues {
                    self.loadAirfieldsAndRunwaysToDBfromJSON(state.rawValue, moc: context)
                    DispatchQueue.main.async {
                        _ = self.printResults(moc: context)
                        print(counter)
                        counter += 1
                        let end = Date()
                        print("Completion Time: \(end.timeIntervalSince(start))")
                        
                    }
                }
            } else {
                print("Airfield and Runway JSON has previously, succesfully been loaded into CoreData")
            }
            DispatchQueue.main.async {
                tabBarItem.isEnabled = true
                print("Done")
            }
        })
    }
    //////////////////////////////////////////////// VERIFY CD MATCHES JSON FUNCTION ////////////////////////////////////////////////

    //////////////////////////////////////////////// VERIFY CD MATCHES JSON With TAB BAR MUTING  ////////////////////////////////////
    func verifyCoreDataMatchesJSONwithMutedTabBarItemAndProgressBar(pc: NSPersistentContainer ,moc: NSManagedObjectContext, tabBarItem: UITabBarItem, progress: @escaping () -> Void ) {
        pc.performBackgroundTask({ context in
            let startTime = Date()
            var airfieldReturn = false
            var runwayReturn = false
            var navaidReturn = false
            var commReturn = false
            var counterAirfieldsJSON = 0
            var counterRunwaysJSON = 0
            var counterNavaidsJSON = 0
            var counterCommsJSON = 0
            let counterAirfieldsCD = self.printResults(moc: context).numOfAirfields
            let counterRunwaysCD = self.printResults(moc: context).numOfRunways
            let counterNavaidsCD = self.printResults(moc: context).numOfNavaids
            let counterCommsCD = self.printResults(moc: context).numOfComms
            let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            for state in StateCode.allValues {
                let airfieldstURL = documentsURL.appendingPathComponent(state.rawValue).appendingPathExtension("json")
                let decoder = JSONDecoder()
                do {
                    let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
                    counterAirfieldsJSON += resultAirfields.count
                    for airfield in resultAirfields {
                        counterRunwaysJSON += airfield.runways.count
                        counterNavaidsJSON += airfield.navaids.count
                        counterCommsJSON += airfield.communications.count
                    }
                } catch {print(error)}
            }
            if counterAirfieldsCD == counterAirfieldsJSON {
                airfieldReturn = true
            }
            if counterRunwaysCD == counterRunwaysJSON {
                runwayReturn = true
            }
            if counterNavaidsCD == counterNavaidsJSON {
                navaidReturn = true
            }
            if counterCommsCD == counterCommsJSON {
                commReturn = true
            }
            print("*****************************************************************************")
            print("Airfields in JSON: \(counterAirfieldsJSON)")
            print("Airfields in CoreData: \(counterAirfieldsCD)")
            print("*****************************************************************************")
            print("Runways in JSON: \(counterRunwaysJSON)")
            print("Runways in CoreData: \(counterRunwaysCD)")
            print("*****************************************************************************")
            print("Navaids in JSON: \(counterNavaidsJSON)")
            print("Navaids in CoreData: \(counterNavaidsCD)")
            print("*****************************************************************************")
            print("Comms in JSON: \(counterCommsJSON)")
            print("Comms in CoreData: \(counterCommsCD)")
            print("*****************************************************************************")
            let endTime = Date()
            print("Airfields match: \(airfieldReturn)")
            print("Runways match: \(runwayReturn)")
            print("Navaids match: \(navaidReturn)")
            print("Comms match: \(commReturn)")
            print("*****************************************************************************")
            print("Completion Time: \(endTime.timeIntervalSince(startTime))")
            print("*****************************************************************************")
            
            
            if airfieldReturn == false || counterAirfieldsCD == 0  || counterAirfieldsCD > counterAirfieldsJSON || runwayReturn == false || counterRunwaysCD == 0 || counterRunwaysCD > counterRunwaysJSON {
                self.deleteAirfieldsFromDB(moc: context)
                self.deleteRunwaysFromDB(moc: context)
                var counter = 1
                let start = Date()
                for state in StateCode.allValues {
                    self.loadAirfieldsAndRunwaysToDBfromJSON(state.rawValue, moc: context)
                    DispatchQueue.main.async {
                        _ = self.printResults(moc: context)
                        print(counter)
                        counter += 1
                        let end = Date()
                        print("Completion Time: \(end.timeIntervalSince(start))")
                        DispatchQueue.main.async {
                            progress()
                        }
                    }
                }
            } else {
                print("Airfield and Runway JSON has previously, succesfully been loaded into CoreData")
            }
            DispatchQueue.main.async {
                tabBarItem.isEnabled = true
                print("Done")
            }
        })
    }
    //////////////////////////////////////////////// VERIFY CD MATCHES JSON FUNCTION ////////////////////////////////////////////////
    
    func verifyCoreDataMatchesJSONwithProgressBar(pc: NSPersistentContainer ,moc: NSManagedObjectContext, progress: @escaping () -> Void ) {
        pc.performBackgroundTask({ context in
            let startTime = Date()
            var airfieldReturn = false
            var runwayReturn = false
            var navaidReturn = false
            var commReturn = false
            var counterAirfieldsJSON = 0
            var counterRunwaysJSON = 0
            var counterNavaidsJSON = 0
            var counterCommsJSON = 0
            let counterAirfieldsCD = self.printResults(moc: context).numOfAirfields
            let counterRunwaysCD = self.printResults(moc: context).numOfRunways
            let counterNavaidsCD = self.printResults(moc: context).numOfNavaids
            let counterCommsCD = self.printResults(moc: context).numOfComms
            let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            for state in StateCode.allValues {
                let airfieldstURL = documentsURL.appendingPathComponent(state.rawValue).appendingPathExtension("json")
                let decoder = JSONDecoder()
                do {
                    let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
                    counterAirfieldsJSON += resultAirfields.count
                    for airfield in resultAirfields {
                        counterRunwaysJSON += airfield.runways.count
                        counterNavaidsJSON += airfield.navaids.count
                        counterCommsJSON += airfield.communications.count
                    }
                } catch {print(error)}
            }
            if counterAirfieldsCD == counterAirfieldsJSON {
                airfieldReturn = true
            }
            if counterRunwaysCD == counterRunwaysJSON {
                runwayReturn = true
            }
            if counterNavaidsCD == counterNavaidsJSON {
                navaidReturn = true
            }
            if counterCommsCD == counterCommsJSON {
                commReturn = true
            }
            print("*****************************************************************************")
            print("Airfields in JSON: \(counterAirfieldsJSON)")
            print("Airfields in CoreData: \(counterAirfieldsCD)")
            print("*****************************************************************************")
            print("Runways in JSON: \(counterRunwaysJSON)")
            print("Runways in CoreData: \(counterRunwaysCD)")
            print("*****************************************************************************")
            print("Navaids in JSON: \(counterNavaidsJSON)")
            print("Navaids in CoreData: \(counterNavaidsCD)")
            print("*****************************************************************************")
            print("Comms in JSON: \(counterCommsJSON)")
            print("Comms in CoreData: \(counterCommsCD)")
            print("*****************************************************************************")
            let endTime = Date()
            print("Airfields match: \(airfieldReturn)")
            print("Runways match: \(runwayReturn)")
            print("Navaids match: \(navaidReturn)")
            print("Comms match: \(commReturn)")
            print("*****************************************************************************")
            print("Completion Time: \(endTime.timeIntervalSince(startTime))")
            print("*****************************************************************************")
            
            
            if airfieldReturn == false || counterAirfieldsCD == 0  || counterAirfieldsCD > counterAirfieldsJSON || runwayReturn == false || counterRunwaysCD == 0 || counterRunwaysCD > counterRunwaysJSON {
                self.deleteAirfieldsFromDB(moc: context)
                self.deleteRunwaysFromDB(moc: context)
                var counter = 1
                let start = Date()
                for state in StateCode.allValues {
                    self.loadAirfieldsAndRunwaysToDBfromJSON(state.rawValue, moc: context)
                    DispatchQueue.main.async {
                        _ = self.printResults(moc: context)
                        print(counter)
                        counter += 1
                        let end = Date()
                        print("Completion Time: \(end.timeIntervalSince(start))")
                        DispatchQueue.main.async {
                            progress()
                        }
                    }
                }
            } else {
                print("Airfield and Runway JSON has previously, succesfully been loaded into CoreData")
            }
            DispatchQueue.main.async {
                print("Done")
            }
        })
    }
    
    
    
    
    
    
    
    
    //////////////////////////////////////////////// VERIFY CD MATCHES JSON VOID VOID FUNCTION ////////////////////////////////////////////////
    func verifyCoreDataMatchesJSONVoidVoid() {
        let container: NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        container?.performBackgroundTask({ context in
            let startTime = Date()
            var airfieldReturn = false
            var runwayReturn = false
            var navaidReturn = false
            var commReturn = false
            var counterAirfieldsJSON = 0
            var counterRunwaysJSON = 0
            var counterNavaidsJSON = 0
            var counterCommsJSON = 0
            let counterAirfieldsCD = self.printResults(moc: context).numOfAirfields
            let counterRunwaysCD = self.printResults(moc: context).numOfRunways
            let counterNavaidsCD = self.printResults(moc: context).numOfNavaids
            let counterCommsCD = self.printResults(moc: context).numOfComms
            let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            for state in StateCode.allValues {
                let airfieldstURL = documentsURL.appendingPathComponent(state.rawValue).appendingPathExtension("json")
                let decoder = JSONDecoder()
                do {
                    let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
                    counterAirfieldsJSON += resultAirfields.count
                    for airfield in resultAirfields {
                        counterRunwaysJSON += airfield.runways.count
                        counterNavaidsJSON += airfield.navaids.count
                        counterCommsJSON += airfield.communications.count
                    }
                } catch {print(error)}
            }
            if counterAirfieldsCD == counterAirfieldsJSON {
                airfieldReturn = true
            }
            if counterRunwaysCD == counterRunwaysJSON {
                runwayReturn = true
            }
            if counterNavaidsCD == counterNavaidsJSON {
                navaidReturn = true
            }
            if counterCommsCD == counterCommsJSON {
                commReturn = true
            }
            print("*****************************************************************************")
            print("Airfields in JSON: \(counterAirfieldsJSON)")
            print("Airfields in CoreData: \(counterAirfieldsCD)")
            print("*****************************************************************************")
            print("Runways in JSON: \(counterRunwaysJSON)")
            print("Runways in CoreData: \(counterRunwaysCD)")
            print("*****************************************************************************")
            print("Navaids in JSON: \(counterNavaidsJSON)")
            print("Navaids in CoreData: \(counterNavaidsCD)")
            print("*****************************************************************************")
            print("Comms in JSON: \(counterCommsJSON)")
            print("Comms in CoreData: \(counterCommsCD)")
            print("*****************************************************************************")
            let endTime = Date()
            print("Airfields match: \(airfieldReturn)")
            print("Runways match: \(runwayReturn)")
            print("Navaids match: \(navaidReturn)")
            print("Comms match: \(commReturn)")
            print("*****************************************************************************")
            print("Completion Time: \(endTime.timeIntervalSince(startTime))")
            print("*****************************************************************************")
            
            
            if airfieldReturn == false || counterAirfieldsCD == 0  || counterAirfieldsCD > counterAirfieldsJSON || runwayReturn == false || counterRunwaysCD == 0 || counterRunwaysCD > counterRunwaysJSON {
                self.deleteAirfieldsFromDB(moc: context)
                self.deleteRunwaysFromDB(moc: context)
                var counter = 1
                let start = Date()
                for state in StateCode.allValues {
                    self.loadAirfieldsAndRunwaysToDBfromJSON(state.rawValue, moc: context)
                    DispatchQueue.main.async {
                        _ = self.printResults(moc: context)
                        print(counter)
                        counter += 1
                        let end = Date()
                        print("Completion Time: \(end.timeIntervalSince(start))")
                    }
                }
            } else {
                print("Airfield and Runway JSON has previously, succesfully been loaded into CoreData")
            }
            DispatchQueue.main.async {
                print("Done")
            }
        })
    }
    //////////////////////////////////////////////// VERIFY CD MATCHES JSON VOID VOID FUNCTION END ////////////////////////////////////////////////
    
    
    
    
    // MARK: Calculations
    func distanceAway(deviceLat lat: Double, deviceLong long: Double, airport: AirfieldCD) -> (airport: AirfieldCD, distanceAway: Double) {
        let airportLat = airport.latitude_CD
        let airportLong = airport.longitude_CD
        let myCoords =  CLLocation(latitude: lat, longitude: long)
        let airportCoords = CLLocation(latitude: airportLat, longitude: airportLong)
        let distanceAwayInNM = myCoords.distance(from: airportCoords).metersToNauticalMiles
        return (airport, distanceAwayInNM)
    }
    
    func rangeAndBearing(latitude_01: Double, longitude_01: Double, latitude_02: Double, longitude_02: Double) -> (range: Double, bearing: Double) {
        let majEarthAxis_WGS84: Double = 6_378_137.0                // maj      - meters
        let minEarthAxis_WGS84: Double = 6_356_752.314_245          // min      - meters
        let lat_01 = latitude_01.degreesToRadians
        let lat_02 = latitude_02.degreesToRadians
        let long_01 = longitude_01.degreesToRadians
        let long_02 = longitude_02.degreesToRadians
        let difLong = (longitude_02 - longitude_01).degreesToRadians
        //1: radiusCorrectionFactor()
        let a1 = 1.0/(majEarthAxis_WGS84 * majEarthAxis_WGS84)
        let b1 = (tan(lat_01) * tan(lat_01)) / (minEarthAxis_WGS84 * minEarthAxis_WGS84)
        let c1 = 1.0/((a1+b1).squareRoot())
        let d1 = c1/(cos(lat_01))
        //2: Law of Cosines
        let range = (acos(sin(lat_01)*sin(lat_02) + cos(lat_01)*cos(lat_02) * cos(difLong)) * d1).metersToNauticalMiles
        //3: Calculating Bearing from 1st coords to second
        let a3 = sin(long_02 - long_01) * cos(lat_02)
        let b3 = cos(lat_01) * sin(lat_02) - sin(lat_01) * cos(lat_02) * cos(long_02 - long_01)
        let bearing = ((atan2(a3, b3).radiansToDegrees) + 360).truncatingRemainder(dividingBy: 360) //Might need mag variation here
        let results = [range, bearing]
        return (range: results[0], bearing: results[1])
    }
    
    
    
    
    //////////////////////////////////////////////// QUERIES ////////////////////////////////////////////////
    
    // MARK: Airfield and Runway Queries
    func getRunwaysGreaterThanOrEqualToUserSettingsMinRWYLength(moc: NSManagedObjectContext) -> [RunwayCD] {
        let runwayLength = getUserSettings().minRwyLength_UD
        var runways = [RunwayCD]()
        let runwayLengthFetchRequest = NSFetchRequest<RunwayCD>(entityName: "RunwayCD")
        let runwayLengthPredicate: NSPredicate = {
            return NSPredicate(format: "%K => %@", #keyPath(RunwayCD.length_CD), "\(runwayLength)")
        }()
        runwayLengthFetchRequest.predicate = runwayLengthPredicate
        do {
            runways = try moc.fetch(runwayLengthFetchRequest)
        } catch let error as NSError {
            print("Could not fetch the Runways: \(error) : \(error.userInfo)")
        }
        return runways
    }
    
    func getAirfieldsWith(airfieldID id: Int32, moc: NSManagedObjectContext) -> [AirfieldCD] {
        var airfields = [AirfieldCD]()
        let airfieldFetchRequest = NSFetchRequest<AirfieldCD>(entityName: "AirfieldCD")
        let airfieldPredicate: NSPredicate = {
            return NSPredicate(format: "%K = %@", #keyPath(AirfieldCD.id_CD),"\(id)")
        }()
        airfieldFetchRequest.predicate = airfieldPredicate
        do {
            airfields = try moc.fetch(airfieldFetchRequest)
        } catch let error as NSError {
            print("Could not fetch the Runways: \(error) : \(error.userInfo)")
        }
        return airfields
    }
    
    func getRunwaysAtAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(airfieldId: Int32 , moc: NSManagedObjectContext) -> [RunwayCD] {
        let runwayLength = getUserSettings().minRwyLength_UD
        var runways = [RunwayCD]()
        let runwayFetchRequest = NSFetchRequest<RunwayCD>(entityName: "RunwayCD")
        let lengthPredicate: NSPredicate = {
            return NSPredicate(format: "%K => %@", #keyPath(RunwayCD.length_CD), "\(runwayLength)")
        }()
        let airfieldIdPredicate: NSPredicate = {
            return NSPredicate(format: "%K = %@", #keyPath(RunwayCD.airfieldID_CD), "\(airfieldId)")
        }()
        let groupedPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [lengthPredicate, airfieldIdPredicate])
        runwayFetchRequest.predicate = groupedPredicate
        do {
            runways = try moc.fetch(runwayFetchRequest)
        } catch let error as NSError {
            print("Could not fetch the Runways: \(error) : \(error.userInfo)")
        }
        return runways
    }
    
    func getAirfieldAndRunwaysWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(moc: NSManagedObjectContext) -> [AirfieldCD:[RunwayCD]] {
        var resultsDict = [AirfieldCD:[RunwayCD]]()
        var airfields = [AirfieldCD]()
        var runwaysIntermediate = [RunwayCD]()
        var airfieldIDSet = Set<Int32>()
        
        //Step - 1: Get Runways with a length of: length
        runwaysIntermediate = getRunwaysGreaterThanOrEqualToUserSettingsMinRWYLength(moc: moc)
        
        //Step - 2: Get Set of Airfield IDs from: Step - 1
        for runway in runwaysIntermediate {
            airfieldIDSet.insert(runway.airfieldID_CD)
        }
        
        //Step - 3: Get Airfields with ID of: airfieldIDSet
        for id in airfieldIDSet {
            var afs = [AirfieldCD]()
            afs = getAirfieldsWith(airfieldID: id, moc: moc)
            for af in afs {
                airfields.append(af)
            }
        }
        
        //Step - 4: Set dictionary with Airfield and Runways
        for airfield in airfields {
            var runways = [RunwayCD]()
            runways = getRunwaysAtAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(airfieldId: airfield.id_CD, moc: moc)
            resultsDict[airfield] = runways
        }
        
        return resultsDict
    }
    
    func getAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(moc: NSManagedObjectContext) -> [AirfieldCD] {
        var airfields = [AirfieldCD]()
        var runwaysIntermediate = [RunwayCD]()
        var airfieldIDSet = Set<Int32>()
        
        //Step - 1: Get Runways with a length of: length
        runwaysIntermediate = getRunwaysGreaterThanOrEqualToUserSettingsMinRWYLength(moc: moc)
        
        //Step - 2: Get Set of Airfield IDs from: Step - 1
        for runway in runwaysIntermediate {
            airfieldIDSet.insert(runway.airfieldID_CD)
        }
        
        //Step - 3: Get Airfields with ID of: airfieldIDSet
        for id in airfieldIDSet {
            var afs = [AirfieldCD]()
            afs = getAirfieldsWith(airfieldID: id, moc: moc)
            for af in afs {
                airfields.append(af)
            }
        }
        
        return airfields
    }
    
    func getAirfieldByICAOOnly(_ icao: String, moc: NSManagedObjectContext)  -> [AirfieldCD] {
        var airfields = [AirfieldCD]()
        let airfieldFetchRequest = NSFetchRequest<AirfieldCD>(entityName: "AirfieldCD")
        let airfieldPredicate: NSPredicate = {
            return NSPredicate(format: "%K = %@", #keyPath(AirfieldCD.icao_CD),"\(icao)")
        }()
        airfieldFetchRequest.predicate = airfieldPredicate
        do {
            airfields = try moc.fetch(airfieldFetchRequest)
        } catch let error as NSError {
            print("Could not fetch the Runways: \(error) : \(error.userInfo)")
        }
        return airfields
    }
    
    func getAirfieldByICAO(_ icao: String, moc: NSManagedObjectContext)  -> [AirfieldCD:[RunwayCD]] {
        var resultsDict = [AirfieldCD:[RunwayCD]]()
        var airfields = [AirfieldCD]()
        var airfieldIDSet = Set<Int32>()
        let airfieldFetchRequest = NSFetchRequest<AirfieldCD>(entityName: "AirfieldCD")
        let airfieldPredicate: NSPredicate = {
            return NSPredicate(format: "%K = %@", #keyPath(AirfieldCD.icao_CD),"\(icao)")
        }()
        airfieldFetchRequest.predicate = airfieldPredicate
        do {
            airfields = try moc.fetch(airfieldFetchRequest)
        } catch let error as NSError {
            print("Could not fetch the Runways: \(error) : \(error.userInfo)")
        }
        for airfield in airfields {
            airfieldIDSet.insert(airfield.id_CD)
        }
        for id in airfieldIDSet {
            var afs = [AirfieldCD]()
            afs = getAirfieldsWith(airfieldID: id, moc: moc)
            for af in afs {
                airfields.append(af)
            }
        }
        for airfield in airfields {
            var runways = [RunwayCD]()
            runways = getRunwaysAtAirfieldWithRWYLengthGreaterThanOrEqualToUserSettingsMinRWYLength(airfieldId: airfield.id_CD, moc: moc)
            resultsDict[airfield] = runways
        }
        return resultsDict
    }
    // MARK: - Naviad Queries
    func getNavaids(moc: NSManagedObjectContext) -> [NavaidCD] {
        var navaids = [NavaidCD]()
        let navaidFetchRequest = NSFetchRequest<NavaidCD>(entityName: "NavaidCD")
        do {
            navaids = try moc.fetch(navaidFetchRequest)
        } catch {
            print(error)
        }
        return navaids
    }
    
    // MARK: - Communication Queries
    func getFreqs(moc: NSManagedObjectContext) -> [FreqCD] {
        var freqs = [FreqCD]()
        let freqFetchRequest = NSFetchRequest<FreqCD>(entityName: "FreqCD")
        do {
            freqs = try moc.fetch(freqFetchRequest)
        } catch {
            print(error)
        }
        return freqs
    }
    
    
    //////////////////////////////////////////////// QUERIES END ////////////////////////////////////////////////
    
    
    
    // MARK: JSON Loading
    func loadJSONInBackground() {
        let container: NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        var counter = 1
        let start = Date()
        for state in StateCode.allValues {
            container?.performBackgroundTask({ context in
                self.loadToDBFromJSON(state.rawValue, moc: context)
                DispatchQueue.main.async {
                    _ = self.printResults(moc: context)
                    print(counter)
                    counter += 1
                    let end = Date()
                    print("Completion Time: \(end.timeIntervalSince(start))")
                }
            })
        }
    }
    
    func loadAirfieldsAndRunwaysToDBfromJSON(_ nameOfJSON: String, moc: NSManagedObjectContext){
        let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let airfieldstURL = documentsURL.appendingPathComponent(nameOfJSON).appendingPathExtension("json")
        let decoder = JSONDecoder()
        var airfieldCounter = 0
        do {
            let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
            _ = resultAirfields.map { (airfield) -> AirfieldCD in
                let airfieldDB = AirfieldCD(context: moc)
                airfieldDB.country_CD = airfield.country
                airfieldDB.elevation_CD = airfield.elevation
                airfieldDB.faa_CD = airfield.faa
                airfieldDB.icao_CD = airfield.icao
                airfieldDB.id_CD = Int32(airfield.id)
                airfieldDB.latitude_CD = airfield.lat
                airfieldDB.longitude_CD = airfield.lon
                airfieldDB.mgrs_CD = airfield.mgrs
                airfieldDB.name_CD = airfield.name
                airfieldDB.state_CD = airfield.state
                airfieldDB.timeConversion_CD = airfield.timeConversion
                
                for runway in airfield.runways {
                    let runwayDB = RunwayCD(context: moc)
                    runwayDB.airfieldID_CD = airfieldDB.id_CD
                    runwayDB.id_CD = Int32(runway.id)
                    runwayDB.lowID_CD = runway.lowID
                    runwayDB.highID_CD = runway.highID
                    runwayDB.length_CD = runway.length
                    runwayDB.width_CD = runway.width
                    runwayDB.surfaceType_CD = runway.surfaceType
                    runwayDB.runwayCondition_CD = runway.runwayCondition
                    runwayDB.magHdgHi_CD = runway.magHdgHi
                    runwayDB.magHdgLow_CD = runway.magHdgLow
                    runwayDB.trueHdgHi_CD = runway.trueHdgHi
                    runwayDB.trueHdgLow_CD = runway.trueHdgLow
                    runwayDB.coordLatHi_CD = runway.coordLatHi
                    runwayDB.coordLatLow_CD = runway.coordLatLo
                    runwayDB.coordLonHi_CD = runway.coordLonHi
                    runwayDB.coordLonLow_CD = runway.coordLonLo
                    runwayDB.elevHi_CD = runway.elevHi
                    runwayDB.elevLow_CD = runway.elevLow
                    runwayDB.slopeHi_CD = runway.slopeHi
                    runwayDB.slopeLow_CD = runway.slopeLow
                    runwayDB.tdzeHi_CD = runway.tdzeHi
                    runwayDB.tdzeLow_CD = runway.tdzeLow
                    runwayDB.overrunHiLength_CD = runway.overrunHiLength
                    runwayDB.overrunLowLength_CD = runway.overrunLowLength
                    runwayDB.overrunHiType_CD = runway.overrunHiType
                    runwayDB.overrunLowType_CD = runway.overrunLowType
                    airfieldDB.addToRunways_R_CD(runwayDB)
                }
                for navaid in airfield.navaids {
                    let navaidDB = NavaidCD(context: moc)
                    navaidDB.airfieldID_CD = airfieldDB.id_CD
                    navaidDB.id_CD = Int32(navaid.id)
                    navaidDB.name_CD = navaid.name
                    navaidDB.ident_CD = navaid.ident
                    navaidDB.type_CD = navaid.type
                    navaidDB.lat_CD = navaid.lat
                    navaidDB.long_CD = navaid.lon
                    navaidDB.frequency_CD = navaid.frequency
                    navaidDB.channel_CD = Int32(navaid.channel)
                    navaidDB.tacanDMEMode_CD = navaid.tacanDMEMode
                    navaidDB.course_CD = Int32(navaid.course)
                    navaidDB.distance_CD = navaid.distance
                }
                for comm in airfield.communications {
                    let communicationDB = CommunicationCD(context: moc)
                    communicationDB.airfieldID_CD = airfieldDB.id_CD
                    communicationDB.id_CD = Int32(comm.id)
                    communicationDB.name_CD = comm.name
                    for freq in comm.freqs {
                        let freqDB = FreqCD(context: moc)
                        freqDB.communicationsId_CD = communicationDB.id_CD
                        freqDB.id_CD = Int32(freq.id)
                        freqDB.freq_CD = freq.freq
                    }}
                airfieldCounter += 1
                return airfieldDB
            }
            moc.performAndWait {
                do {
                    try moc.save()
                } catch {
                    print(error)
                }
            }
        } catch {print(error)}
    }
    
    func loadNavaidsToDBfromJSON(_ nameOfJSON: String, moc: NSManagedObjectContext){
        let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let airfieldstURL = documentsURL.appendingPathComponent(nameOfJSON).appendingPathExtension("json")
        let decoder = JSONDecoder()
        var navaidCounter = 0
        do {
            let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
            for airfield in resultAirfields {
                let airfieldDB = AirfieldCD(context: moc)
                for navaid in airfield.navaids {
                    let navaidDB = NavaidCD(context: moc)
                    navaidDB.airfieldID_CD = airfieldDB.id_CD
                    navaidDB.id_CD = Int32(navaid.id)
                    navaidDB.name_CD = navaid.name
                    navaidDB.ident_CD = navaid.ident
                    navaidDB.type_CD = navaid.type
                    navaidDB.lat_CD = navaid.lat
                    navaidDB.long_CD = navaid.lon
                    navaidDB.frequency_CD = navaid.frequency
                    navaidDB.channel_CD = Int32(navaid.channel)
                    navaidDB.tacanDMEMode_CD = navaid.tacanDMEMode
                    navaidDB.course_CD = Int32(navaid.course)
                    navaidDB.distance_CD = navaid.distance
                    navaidCounter += 1
                    try? moc.save()
                }
            }
            try? moc.save()
        } catch {print(error)}
    }
    
    func loadCommsToDBfromJSON(_ nameOfJSON: String, moc: NSManagedObjectContext){
        let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let airfieldstURL = documentsURL.appendingPathComponent(nameOfJSON).appendingPathExtension("json")
        let decoder = JSONDecoder()
        var commCounter = 0
        do {
            let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
            for airfield in resultAirfields {
                let airfieldDB = AirfieldCD(context: moc)
                for comm in airfield.communications {
                    let communicationDB = CommunicationCD(context: moc)
                    communicationDB.airfieldID_CD = airfieldDB.id_CD
                    communicationDB.id_CD = Int32(comm.id)
                    communicationDB.name_CD = comm.name
                    try? moc.save()
                    for freq in comm.freqs {
                        let freqDB = FreqCD(context: moc)
                        freqDB.communicationsId_CD = communicationDB.id_CD
                        freqDB.id_CD = Int32(freq.id)
                        freqDB.freq_CD = freq.freq
                        try? moc.save()
                    }
                    commCounter += 1
                    try? moc.save()
                }
            }
            try? moc.save()
        } catch {print(error)}
    }
    
    func loadToDBFromJSON(_ nameOfJSON: String, moc: NSManagedObjectContext){
        let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let airfieldstURL = documentsURL.appendingPathComponent(nameOfJSON).appendingPathExtension("json")
        let decoder = JSONDecoder()
        var counter = 0
        do {
            let resultAirfields = try decoder.decode(Airfields.self, from: Data(contentsOf: airfieldstURL))
            for airfield in resultAirfields {
                let airfieldDB = AirfieldCD(context: moc)
                airfieldDB.country_CD = airfield.country
                airfieldDB.elevation_CD = airfield.elevation
                airfieldDB.faa_CD = airfield.faa
                airfieldDB.icao_CD = airfield.icao
                airfieldDB.id_CD = Int32(airfield.id)
                airfieldDB.latitude_CD = airfield.lat
                airfieldDB.longitude_CD = airfield.lon
                airfieldDB.mgrs_CD = airfield.mgrs
                airfieldDB.name_CD = airfield.name
                airfieldDB.state_CD = airfield.state
                airfieldDB.timeConversion_CD = airfield.timeConversion
                counter += 1
                
                for runway in airfield.runways {
                    let runwayDB = RunwayCD(context: moc)
                    runwayDB.airfieldID_CD = airfieldDB.id_CD
                    runwayDB.id_CD = Int32(runway.id)
                    runwayDB.lowID_CD = runway.lowID
                    runwayDB.highID_CD = runway.highID
                    runwayDB.length_CD = runway.length
                    runwayDB.width_CD = runway.width
                    runwayDB.surfaceType_CD = runway.surfaceType
                    runwayDB.runwayCondition_CD = runway.runwayCondition
                    runwayDB.magHdgHi_CD = runway.magHdgHi
                    runwayDB.magHdgLow_CD = runway.magHdgLow
                    runwayDB.trueHdgHi_CD = runway.trueHdgHi
                    runwayDB.trueHdgLow_CD = runway.trueHdgLow
                    runwayDB.coordLatHi_CD = runway.coordLatHi
                    runwayDB.coordLatLow_CD = runway.coordLatLo
                    runwayDB.coordLonHi_CD = runway.coordLonHi
                    runwayDB.coordLonLow_CD = runway.coordLonLo
                    runwayDB.elevHi_CD = runway.elevHi
                    runwayDB.elevLow_CD = runway.elevLow
                    runwayDB.slopeHi_CD = runway.slopeHi
                    runwayDB.slopeLow_CD = runway.slopeLow
                    runwayDB.tdzeHi_CD = runway.tdzeHi
                    runwayDB.tdzeLow_CD = runway.tdzeLow
                    runwayDB.overrunHiLength_CD = runway.overrunHiLength
                    runwayDB.overrunLowLength_CD = runway.overrunLowLength
                    runwayDB.overrunHiType_CD = runway.overrunHiType
                    runwayDB.overrunLowType_CD = runway.overrunLowType
                    airfieldDB.addToRunways_R_CD(runwayDB)
                    try? moc.save()
                }
                
                for navaid in airfield.navaids {
                    let navaidDB = NavaidCD(context: moc)
                    navaidDB.airfieldID_CD = airfieldDB.id_CD
                    navaidDB.id_CD = Int32(navaid.id)
                    navaidDB.name_CD = navaid.name
                    navaidDB.ident_CD = navaid.ident
                    navaidDB.type_CD = navaid.type
                    navaidDB.lat_CD = navaid.lat
                    navaidDB.long_CD = navaid.lon
                    navaidDB.frequency_CD = navaid.frequency
                    navaidDB.channel_CD = Int32(navaid.channel)
                    navaidDB.tacanDMEMode_CD = navaid.tacanDMEMode
                    navaidDB.course_CD = Int32(navaid.course)
                    navaidDB.distance_CD = navaid.distance
                    airfieldDB.addToNavaids_R_CD(navaidDB)
                    try? moc.save()
                }
                
                for comm in airfield.communications {
                    let communicationDB = CommunicationCD(context: moc)
                    communicationDB.airfieldID_CD = airfieldDB.id_CD
                    communicationDB.id_CD = Int32(comm.id)
                    communicationDB.name_CD = comm.name
                    try? moc.save()
                    for freq in comm.freqs {
                        let freqDB = FreqCD(context: moc)
                        freqDB.communicationsId_CD = communicationDB.id_CD
                        freqDB.id_CD = Int32(freq.id)
                        freqDB.freq_CD = freq.freq
                        communicationDB.addToFreqs_R_CD(freqDB)
                        try? moc.save()
                    }
                    airfieldDB.addToCommunications_R_CD(communicationDB)
                    try? moc.save()
                }
            }
            try? moc.save()
        } catch {print(error)}
    }
    
    // MARK: CD Save/Delete
    func mocSave(moc: NSManagedObjectContext){
        do {
            try moc.save()
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }}
    
    func deleteAllFromDB(moc: NSManagedObjectContext) {
        let deleteAirPort = NSBatchDeleteRequest(fetchRequest: AirfieldCD.fetchRequest())
        let deleteRunway = NSBatchDeleteRequest(fetchRequest: RunwayCD.fetchRequest())
        let deleteNavaids = NSBatchDeleteRequest(fetchRequest: NavaidCD.fetchRequest())
        let deleteFreqs = NSBatchDeleteRequest(fetchRequest: CommunicationCD.fetchRequest())
        do {
            try moc.execute(deleteAirPort)
            try moc.execute(deleteRunway)
            try moc.execute(deleteNavaids)
            try moc.execute(deleteFreqs)
            try moc.save()
        } catch {
            print("Nope")
        }
    }
    
    func deleteAirfieldsFromDB(moc: NSManagedObjectContext) {
        let deleteAirPort = NSBatchDeleteRequest(fetchRequest: AirfieldCD.fetchRequest())
        do {
            try moc.execute(deleteAirPort)
            try moc.save()
            print("All Airfields were succesfully deleted from CoreData")
        } catch {
            print("Nope")
        }
    }
    
    func deleteRunwaysFromDB(moc: NSManagedObjectContext) {
        let deleteRunway = NSBatchDeleteRequest(fetchRequest: RunwayCD.fetchRequest())
        do {
            try moc.execute(deleteRunway)
            try moc.save()
            print("All Runways were succesfully deleted from CoreData")
        } catch {
            print("Nope")
        }
    }
    
    func deleteNavaidsFromDB(moc: NSManagedObjectContext) {
        let deleteNavaids = NSBatchDeleteRequest(fetchRequest: NavaidCD.fetchRequest())
        do {
            try moc.execute(deleteNavaids)
            try moc.save()
            print("All Navaids were succesfully deleted from CoreData")
        } catch {
            print("Nope")
        }
    }
    func deleteCommsFromDB(moc: NSManagedObjectContext) {
        let deleteFreqs = NSBatchDeleteRequest(fetchRequest: CommunicationCD.fetchRequest())
        do {
            try moc.execute(deleteFreqs)
            try moc.save()
            print("All Communications were succesfully deleted from CoreData")
        } catch {
            print("Nope")
        }
    }
    
    
    
}



