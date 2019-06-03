

import Foundation
import CoreData


struct ArfSchCDU {


	func loadArfSchToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ARF_ARF_SCH.json")
		var tempArray: [ArfSch_CD] = []

		do {
			let results = try decoder.decode([ArfSch].self, from: Data(contentsOf: fileName))
			for arfSch_CD in results {
				let arfSch_CD_DB = ArfSch_CD(context: moc)
				arfSch_CD_DB.arfIdent_CD = arfSch_CD.arfIdent				arfSch_CD_DB.direction_CD = arfSch_CD.direction				arfSch_CD_DB.icao_CD = arfSch_CD.icao				arfSch_CD_DB.schUnit_CD = arfSch_CD.schUnit				arfSch_CD_DB.dsn_CD = arfSch_CD.dsn				arfSch_CD_DB.comNo_CD = arfSch_CD.comNo				arfSch_CD_DB.cycleDate_CD = arfSch_CD.cycleDate as? NSDecimalNumber
				tempArray.append(arfSch_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteArfSch_CDFromDB(moc: NSManagedObjectContext) {
		let deleteArfSch_CD = NSBatchDeleteRequest(fetchRequest: ArfSch_CD.fetchRequest())
		do {
			try moc.execute(deleteArfSch_CD)
			try moc.save()
			print("All ArfSch_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllArfSch_CD(moc: NSManagedObjectContext) -> [ArfSch_CD] {
		var arfSch_CD = [ArfSch_CD]()
		let arfSch_CDFetchRequest = NSFetchRequest<ArfSch_CD>(entityName: "ArfSch_CD")
		do {
			arfSch_CD = try moc.fetch(arfSch_CDFetchRequest)
		} catch {
			print(error)
		}
		return arfSch_CD
	}
}