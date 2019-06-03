

import Foundation
import CoreData


struct TrmClbCDU {


	func loadTrmClbToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/TRM_TRM_CLB.json")
		var tempArray: [TrmClb_CD] = []

		do {
			let results = try decoder.decode([TrmClb].self, from: Data(contentsOf: fileName))
			for trmClb_CD in results {
				let trmClb_CD_DB = TrmClb_CD(context: moc)
				trmClb_CD_DB.arptIdent_CD = trmClb_CD.arptIdent				trmClb_CD_DB.proc_CD = trmClb_CD.proc as? NSDecimalNumber				trmClb_CD_DB.trmIdent_CD = trmClb_CD.trmIdent				trmClb_CD_DB.rwyId_CD = trmClb_CD.rwyId as? NSDecimalNumber				trmClb_CD_DB.occNo_CD = trmClb_CD.occNo as? NSDecimalNumber				trmClb_CD_DB.icao_CD = trmClb_CD.icao				trmClb_CD_DB.desig_CD = trmClb_CD.desig as? NSDecimalNumber				trmClb_CD_DB.knots_CD = trmClb_CD.knots as? NSDecimalNumber				trmClb_CD_DB.rateDesc_CD = trmClb_CD.rateDesc as? NSDecimalNumber				trmClb_CD_DB.alt_CD = trmClb_CD.alt as? NSDecimalNumber				trmClb_CD_DB.ftnote_CD = trmClb_CD.ftnote				trmClb_CD_DB.cycleDate_CD = trmClb_CD.cycleDate as? NSDecimalNumber
				tempArray.append(trmClb_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteTrmClb_CDFromDB(moc: NSManagedObjectContext) {
		let deleteTrmClb_CD = NSBatchDeleteRequest(fetchRequest: TrmClb_CD.fetchRequest())
		do {
			try moc.execute(deleteTrmClb_CD)
			try moc.save()
			print("All TrmClb_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllTrmClb_CD(moc: NSManagedObjectContext) -> [TrmClb_CD] {
		var trmClb_CD = [TrmClb_CD]()
		let trmClb_CDFetchRequest = NSFetchRequest<TrmClb_CD>(entityName: "TrmClb_CD")
		do {
			trmClb_CD = try moc.fetch(trmClb_CDFetchRequest)
		} catch {
			print(error)
		}
		return trmClb_CD
	}
}