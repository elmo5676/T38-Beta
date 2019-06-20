
import UIKit
import CoreData
import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaults = UserDefaults.standard
    var timesAppHasOpened: Int = 0
    

    func saveTimesOpen() -> Void {
        defaults.set(timesAppHasOpened, forKey: "timesOpened")
    }
    func getCurrentTimesOpened() -> Int {
        return defaults.integer(forKey: "timesOpened") + 1
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let cdu = CoreDataUtilies()
        
        if cdu.getUserSettings().homeAirfieldICAO_UD == "" {
            cdu.setUserSettings(useHomeField: true,
                                homeAirfieldICAO: "KBAB",
                                minRwyLength: "8000")}
        
        if cdu.getUserDefaults().runwaySlope_UD == "" {
            cdu.setUserDefaults(runwayLength: "8000",
                                aeroBraking: "No",
                                tempScaleCorF: "C",
                                aircraftGrossWeight: "12861",
                                aircraftBasicWeight: "8461",
                                fuelWeight: "4000",
                                pilotAndGearWeight: "400",
                                podInstalled: "No",
                                weightOfCargoInPOD: "0",
                                weightUsedForTOLD: "12861",
                                givenEngineFailure: "0",
                                temperature: "15",
                                pressureAlt: "0",
                                runwayHeading: "145",
                                windDirection: "0",
                                windVelocity: "0",
                                runwaySlope: "0",
                                rcr: "23"
                                )}
      
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveTimesOpen()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveTimesOpen()
        self.saveContext()
    }
    
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        //Name of CoreData Model File:
        let container = NSPersistentContainer(name: "T38CD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}







