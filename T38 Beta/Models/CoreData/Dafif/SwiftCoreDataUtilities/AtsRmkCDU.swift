

import Foundation
import CoreData


struct AtsRmkCDU {


	func loadAtsRmkToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ATS_ATS_RMK.json")
		var tempArray: [AtsRmk_CD] = []

		do {
			let results = try decoder.decode([AtsRmk].self, from: Data(contentsOf: fileName))
			for atsRmk_CD in results {
				let atsRmk_CD_DB = AtsRmk_CD(context: moc)
				atsRmk_CD_DB.atsIdent_CD = atsRmk_CD.atsIdent				atsRmk_CD_DB.seqNbr_CD = atsRmk_CD.seqNbr as? NSDecimalNumber				atsRmk_CD_DB.direction_CD = atsRmk_CD.direction				atsRmk_CD_DB.type_CD = atsRmk_CD.type				atsRmk_CD_DB.icao_CD = atsRmk_CD.icao				atsRmk_CD_DB.rmkSeq_CD = atsRmk_CD.rmkSeq as? NSDecimalNumber				atsRmk_CD_DB.remark_CD = atsRmk_CD.remark				atsRmk_CD_DB.cycleDate_CD = atsRmk_CD.cycleDate as? NSDecimalNumber
				tempArray.append(atsRmk_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteAtsRmk_CDFromDB(moc: NSManagedObjectContext) {
		let deleteAtsRmk_CD = NSBatchDeleteRequest(fetchRequest: AtsRmk_CD.fetchRequest())
		do {
			try moc.execute(deleteAtsRmk_CD)
			try moc.save()
			print("All AtsRmk_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllAtsRmk_CD(moc: NSManagedObjectContext) -> [AtsRmk_CD] {
		var atsRmk_CD = [AtsRmk_CD]()
		let atsRmk_CDFetchRequest = NSFetchRequest<AtsRmk_CD>(entityName: "AtsRmk_CD")
		do {
			atsRmk_CD = try moc.fetch(atsRmk_CDFetchRequest)
		} catch {
			print(error)
		}
		return atsRmk_CD
	}
}