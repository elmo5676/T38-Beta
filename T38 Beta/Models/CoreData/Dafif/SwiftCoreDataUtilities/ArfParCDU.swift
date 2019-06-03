

import Foundation
import CoreData


struct ArfParCDU {


	func loadArfParToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ARF_ARF_PAR.json")
		var tempArray: [ArfPar_CD] = []

		do {
			let results = try decoder.decode([ArfPar].self, from: Data(contentsOf: fileName))
			for arfPar_CD in results {
				let arfPar_CD_DB = ArfPar_CD(context: moc)
				arfPar_CD_DB.arfIdent_CD = arfPar_CD.arfIdent				arfPar_CD_DB.direction_CD = arfPar_CD.direction				arfPar_CD_DB.icao_CD = arfPar_CD.icao				arfPar_CD_DB.type_CD = arfPar_CD.type				arfPar_CD_DB.ctry_CD = arfPar_CD.ctry				arfPar_CD_DB.locHdatum_CD = arfPar_CD.locHdatum				arfPar_CD_DB.wgsDatum_CD = arfPar_CD.wgsDatum				arfPar_CD_DB.priFreq_CD = arfPar_CD.priFreq as? NSDecimalNumber				arfPar_CD_DB.bkpFreq_CD = arfPar_CD.bkpFreq as? NSDecimalNumber				arfPar_CD_DB.apnCode_CD = arfPar_CD.apnCode				arfPar_CD_DB.apxCode_CD = arfPar_CD.apxCode				arfPar_CD_DB.receiver_CD = arfPar_CD.receiver				arfPar_CD_DB.tanker_CD = arfPar_CD.tanker				arfPar_CD_DB.alt1Desc_CD = arfPar_CD.alt1Desc				arfPar_CD_DB.refuel1Alt1_CD = arfPar_CD.refuel1Alt1				arfPar_CD_DB.refuel1Alt2_CD = arfPar_CD.refuel1Alt2				arfPar_CD_DB.alt2Desc_CD = arfPar_CD.alt2Desc				arfPar_CD_DB.refuel2Alt1_CD = arfPar_CD.refuel2Alt1				arfPar_CD_DB.refuel2Alt2_CD = arfPar_CD.refuel2Alt2				arfPar_CD_DB.alt3Desc_CD = arfPar_CD.alt3Desc				arfPar_CD_DB.refuel3Alt1_CD = arfPar_CD.refuel3Alt1				arfPar_CD_DB.refuel3Alt2_CD = arfPar_CD.refuel3Alt2				arfPar_CD_DB.cycleDate_CD = arfPar_CD.cycleDate as? NSDecimalNumber
				tempArray.append(arfPar_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteArfPar_CDFromDB(moc: NSManagedObjectContext) {
		let deleteArfPar_CD = NSBatchDeleteRequest(fetchRequest: ArfPar_CD.fetchRequest())
		do {
			try moc.execute(deleteArfPar_CD)
			try moc.save()
			print("All ArfPar_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllArfPar_CD(moc: NSManagedObjectContext) -> [ArfPar_CD] {
		var arfPar_CD = [ArfPar_CD]()
		let arfPar_CDFetchRequest = NSFetchRequest<ArfPar_CD>(entityName: "ArfPar_CD")
		do {
			arfPar_CD = try moc.fetch(arfPar_CDFetchRequest)
		} catch {
			print(error)
		}
		return arfPar_CD
	}
}