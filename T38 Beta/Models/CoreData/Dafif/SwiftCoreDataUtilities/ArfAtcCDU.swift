

import Foundation
import CoreData


struct ArfAtcCDU {


	func loadArfAtcToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ARF_ARF_ATC.json")
		var tempArray: [ArfAtc_CD] = []

		do {
			let results = try decoder.decode([ArfAtc].self, from: Data(contentsOf: fileName))
			for arfAtc_CD in results {
				let arfAtc_CD_DB = ArfAtc_CD(context: moc)
				arfAtc_CD_DB.arfIdent_CD = arfAtc_CD.arfIdent				arfAtc_CD_DB.direction_CD = arfAtc_CD.direction				arfAtc_CD_DB.icao_CD = arfAtc_CD.icao				arfAtc_CD_DB.usage_CD = arfAtc_CD.usage				arfAtc_CD_DB.center_CD = arfAtc_CD.center				arfAtc_CD_DB.cntrMult_CD = arfAtc_CD.cntrMult as? NSDecimalNumber				arfAtc_CD_DB.freq1_CD = arfAtc_CD.freq1				arfAtc_CD_DB.eW1_CD = arfAtc_CD.eW1				arfAtc_CD_DB.freq2_CD = arfAtc_CD.freq2				arfAtc_CD_DB.eW2_CD = arfAtc_CD.eW2				arfAtc_CD_DB.freq3_CD = arfAtc_CD.freq3				arfAtc_CD_DB.eW3_CD = arfAtc_CD.eW3				arfAtc_CD_DB.freq4_CD = arfAtc_CD.freq4				arfAtc_CD_DB.eW4_CD = arfAtc_CD.eW4				arfAtc_CD_DB.freq5_CD = arfAtc_CD.freq5				arfAtc_CD_DB.eW5_CD = arfAtc_CD.eW5				arfAtc_CD_DB.atcRmk_CD = arfAtc_CD.atcRmk				arfAtc_CD_DB.cycleDate_CD = arfAtc_CD.cycleDate as? NSDecimalNumber
				tempArray.append(arfAtc_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteArfAtc_CDFromDB(moc: NSManagedObjectContext) {
		let deleteArfAtc_CD = NSBatchDeleteRequest(fetchRequest: ArfAtc_CD.fetchRequest())
		do {
			try moc.execute(deleteArfAtc_CD)
			try moc.save()
			print("All ArfAtc_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllArfAtc_CD(moc: NSManagedObjectContext) -> [ArfAtc_CD] {
		var arfAtc_CD = [ArfAtc_CD]()
		let arfAtc_CDFetchRequest = NSFetchRequest<ArfAtc_CD>(entityName: "ArfAtc_CD")
		do {
			arfAtc_CD = try moc.fetch(arfAtc_CDFetchRequest)
		} catch {
			print(error)
		}
		return arfAtc_CD
	}
}