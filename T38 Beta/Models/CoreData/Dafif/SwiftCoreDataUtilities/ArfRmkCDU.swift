

import Foundation
import CoreData


struct ArfRmkCDU {


	func loadArfRmkToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ARF_ARF_RMK.json")

		do {
			let results = try decoder.decode([ArfRmk].self, from: Data(contentsOf: fileName))
			_ = results.map { (arfRmk_CD) -> ArfRmk_CD in
				let arfRmk_CD_DB = ArfRmk_CD(context: moc)
				arfRmk_CD_DB.arfIdent_CD = arfRmk_CD.arfIdent				arfRmk_CD_DB.direction_CD = arfRmk_CD.direction				arfRmk_CD_DB.rmkSeq_CD = arfRmk_CD.rmkSeq as? NSDecimalNumber				arfRmk_CD_DB.icao_CD = arfRmk_CD.icao				arfRmk_CD_DB.remarks_CD = arfRmk_CD.remarks				arfRmk_CD_DB.cycleDate_CD = arfRmk_CD.cycleDate as? NSDecimalNumber
				return arfRmk_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteArfRmk_CDFromDB(moc: NSManagedObjectContext) {
		let deleteArfRmk_CD = NSBatchDeleteRequest(fetchRequest: ArfRmk_CD.fetchRequest())
		do {
			try moc.execute(deleteArfRmk_CD)
			try moc.save()
			print("All ArfRmk_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllArfRmk_CD(moc: NSManagedObjectContext) -> [ArfRmk_CD] {
		var arfRmk_CD = [ArfRmk_CD]()
		let arfRmk_CDFetchRequest = NSFetchRequest<ArfRmk_CD>(entityName: "ArfRmk_CD")
		do {
			arfRmk_CD = try moc.fetch(arfRmk_CDFetchRequest)
		} catch {
			print(error)
		}
		return arfRmk_CD
	}
}