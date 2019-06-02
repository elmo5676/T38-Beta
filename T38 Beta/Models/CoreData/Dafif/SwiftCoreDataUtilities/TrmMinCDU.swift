

import Foundation
import CoreData


struct TrmMinCDU {


	func loadTrmMinToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/TRM_TRM_MIN.json")

		do {
			let results = try decoder.decode([TrmMin].self, from: Data(contentsOf: fileName))
			_ = results.map { (trmMin_CD) -> TrmMin_CD in
				let trmMin_CD_DB = TrmMin_CD(context: moc)
				trmMin_CD_DB.arptIdent_CD = trmMin_CD.arptIdent				trmMin_CD_DB.proc_CD = trmMin_CD.proc as? NSDecimalNumber				trmMin_CD_DB.trmIdent_CD = trmMin_CD.trmIdent				trmMin_CD_DB.appType_CD = trmMin_CD.appType				trmMin_CD_DB.icao_CD = trmMin_CD.icao				trmMin_CD_DB.catADh_CD = trmMin_CD.catADh as? NSDecimalNumber				trmMin_CD_DB.catARv_CD = trmMin_CD.catARv				trmMin_CD_DB.catAHa_CD = trmMin_CD.catAHa as? NSDecimalNumber				trmMin_CD_DB.catAWxCl_CD = trmMin_CD.catAWxCl as? NSDecimalNumber				trmMin_CD_DB.catAWxPv_CD = trmMin_CD.catAWxPv				trmMin_CD_DB.catBDh_CD = trmMin_CD.catBDh as? NSDecimalNumber				trmMin_CD_DB.catBRv_CD = trmMin_CD.catBRv				trmMin_CD_DB.catBHa_CD = trmMin_CD.catBHa as? NSDecimalNumber				trmMin_CD_DB.catBWxCl_CD = trmMin_CD.catBWxCl as? NSDecimalNumber				trmMin_CD_DB.catBWxPv_CD = trmMin_CD.catBWxPv				trmMin_CD_DB.catCDh_CD = trmMin_CD.catCDh as? NSDecimalNumber				trmMin_CD_DB.catCRv_CD = trmMin_CD.catCRv				trmMin_CD_DB.catCHa_CD = trmMin_CD.catCHa as? NSDecimalNumber				trmMin_CD_DB.catCWxCl_CD = trmMin_CD.catCWxCl as? NSDecimalNumber				trmMin_CD_DB.catCWxPv_CD = trmMin_CD.catCWxPv				trmMin_CD_DB.catDDh_CD = trmMin_CD.catDDh as? NSDecimalNumber				trmMin_CD_DB.catDRv_CD = trmMin_CD.catDRv				trmMin_CD_DB.catDHa_CD = trmMin_CD.catDHa as? NSDecimalNumber				trmMin_CD_DB.catDWxCl_CD = trmMin_CD.catDWxCl as? NSDecimalNumber				trmMin_CD_DB.catDWxPv_CD = trmMin_CD.catDWxPv				trmMin_CD_DB.catEDh_CD = trmMin_CD.catEDh				trmMin_CD_DB.catERv_CD = trmMin_CD.catERv				trmMin_CD_DB.catEHa_CD = trmMin_CD.catEHa				trmMin_CD_DB.catEWxCl_CD = trmMin_CD.catEWxCl				trmMin_CD_DB.catEWxPv_CD = trmMin_CD.catEWxPv				trmMin_CD_DB.minRmk_CD = trmMin_CD.minRmk				trmMin_CD_DB.cycleDate_CD = trmMin_CD.cycleDate as? NSDecimalNumber
				return trmMin_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteTrmMin_CDFromDB(moc: NSManagedObjectContext) {
		let deleteTrmMin_CD = NSBatchDeleteRequest(fetchRequest: TrmMin_CD.fetchRequest())
		do {
			try moc.execute(deleteTrmMin_CD)
			try moc.save()
			print("All TrmMin_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllTrmMin_CD(moc: NSManagedObjectContext) -> [TrmMin_CD] {
		var trmMin_CD = [TrmMin_CD]()
		let trmMin_CDFetchRequest = NSFetchRequest<TrmMin_CD>(entityName: "TrmMin_CD")
		do {
			trmMin_CD = try moc.fetch(trmMin_CDFetchRequest)
		} catch {
			print(error)
		}
		return trmMin_CD
	}
}