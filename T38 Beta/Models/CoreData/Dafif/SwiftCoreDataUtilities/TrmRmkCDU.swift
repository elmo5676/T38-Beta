

import Foundation
import CoreData


struct TrmRmkCDU {


	func loadTrmRmkToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/TRM_TRM_RMK.json")

		do {
			let results = try decoder.decode([TrmRmk].self, from: Data(contentsOf: fileName))
			_ = results.map { (trmRmk_CD) -> TrmRmk_CD in
				let trmRmk_CD_DB = TrmRmk_CD(context: moc)
				trmRmk_CD_DB.arptIdent_CD = trmRmk_CD.arptIdent				trmRmk_CD_DB.proc_CD = trmRmk_CD.proc as? NSDecimalNumber				trmRmk_CD_DB.trmIdent_CD = trmRmk_CD.trmIdent				trmRmk_CD_DB.appType_CD = trmRmk_CD.appType				trmRmk_CD_DB.rmkSeq_CD = trmRmk_CD.rmkSeq as? NSDecimalNumber				trmRmk_CD_DB.icao_CD = trmRmk_CD.icao				trmRmk_CD_DB.remarks_CD = trmRmk_CD.remarks				trmRmk_CD_DB.cycleDate_CD = trmRmk_CD.cycleDate as? NSDecimalNumber				trmRmk_CD_DB.rmkType_CD = trmRmk_CD.rmkType
				return trmRmk_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteTrmRmk_CDFromDB(moc: NSManagedObjectContext) {
		let deleteTrmRmk_CD = NSBatchDeleteRequest(fetchRequest: TrmRmk_CD.fetchRequest())
		do {
			try moc.execute(deleteTrmRmk_CD)
			try moc.save()
			print("All TrmRmk_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllTrmRmk_CD(moc: NSManagedObjectContext) -> [TrmRmk_CD] {
		var trmRmk_CD = [TrmRmk_CD]()
		let trmRmk_CDFetchRequest = NSFetchRequest<TrmRmk_CD>(entityName: "TrmRmk_CD")
		do {
			trmRmk_CD = try moc.fetch(trmRmk_CDFetchRequest)
		} catch {
			print(error)
		}
		return trmRmk_CD
	}
}