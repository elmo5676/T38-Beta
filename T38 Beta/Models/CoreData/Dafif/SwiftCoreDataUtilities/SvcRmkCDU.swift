

import Foundation
import CoreData


struct SvcRmkCDU {


	func loadSvcRmkToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/SUPP_SVC_RMK.json")

		do {
			let results = try decoder.decode([SvcRmk].self, from: Data(contentsOf: fileName))
			_ = results.map { (svcRmk_CD) -> SvcRmk_CD in
				let svcRmk_CD_DB = SvcRmk_CD(context: moc)
				svcRmk_CD_DB.arptIdent_CD = svcRmk_CD.arptIdent				svcRmk_CD_DB.type_CD = svcRmk_CD.type				svcRmk_CD_DB.rmkSeq_CD = svcRmk_CD.rmkSeq as? NSDecimalNumber				svcRmk_CD_DB.icao_CD = svcRmk_CD.icao				svcRmk_CD_DB.remarks_CD = svcRmk_CD.remarks				svcRmk_CD_DB.cycleDate_CD = svcRmk_CD.cycleDate as? NSDecimalNumber
				return svcRmk_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteSvcRmk_CDFromDB(moc: NSManagedObjectContext) {
		let deleteSvcRmk_CD = NSBatchDeleteRequest(fetchRequest: SvcRmk_CD.fetchRequest())
		do {
			try moc.execute(deleteSvcRmk_CD)
			try moc.save()
			print("All SvcRmk_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllSvcRmk_CD(moc: NSManagedObjectContext) -> [SvcRmk_CD] {
		var svcRmk_CD = [SvcRmk_CD]()
		let svcRmk_CDFetchRequest = NSFetchRequest<SvcRmk_CD>(entityName: "SvcRmk_CD")
		do {
			svcRmk_CD = try moc.fetch(svcRmk_CDFetchRequest)
		} catch {
			print(error)
		}
		return svcRmk_CD
	}
}