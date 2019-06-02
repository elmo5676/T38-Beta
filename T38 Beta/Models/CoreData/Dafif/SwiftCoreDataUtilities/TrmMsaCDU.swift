

import Foundation
import CoreData


struct TrmMsaCDU {


	func loadTrmMsaToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/TRM_TRM_MSA.json")

		do {
			let results = try decoder.decode([TrmMsa].self, from: Data(contentsOf: fileName))
			_ = results.map { (trmMsa_CD) -> TrmMsa_CD in
				let trmMsa_CD_DB = TrmMsa_CD(context: moc)
				trmMsa_CD_DB.arptIdent_CD = trmMsa_CD.arptIdent				trmMsa_CD_DB.proc_CD = trmMsa_CD.proc as? NSDecimalNumber				trmMsa_CD_DB.trmIdent_CD = trmMsa_CD.trmIdent				trmMsa_CD_DB.secNbr_CD = trmMsa_CD.secNbr as? NSDecimalNumber				trmMsa_CD_DB.secAlt_CD = trmMsa_CD.secAlt as? NSDecimalNumber				trmMsa_CD_DB.icao_CD = trmMsa_CD.icao				trmMsa_CD_DB.navIdent_CD = trmMsa_CD.navIdent				trmMsa_CD_DB.navType_CD = trmMsa_CD.navType				trmMsa_CD_DB.navCtry_CD = trmMsa_CD.navCtry				trmMsa_CD_DB.navKeyCd_CD = trmMsa_CD.navKeyCd				trmMsa_CD_DB.secBear1_CD = trmMsa_CD.secBear1 as? NSDecimalNumber				trmMsa_CD_DB.secBear2_CD = trmMsa_CD.secBear2				trmMsa_CD_DB.wptIdent_CD = trmMsa_CD.wptIdent				trmMsa_CD_DB.wptCtry_CD = trmMsa_CD.wptCtry				trmMsa_CD_DB.secMile1_CD = trmMsa_CD.secMile1 as? NSDecimalNumber				trmMsa_CD_DB.secMile2_CD = trmMsa_CD.secMile2 as? NSDecimalNumber				trmMsa_CD_DB.wgsLat_CD = trmMsa_CD.wgsLat				trmMsa_CD_DB.wgsDlat_CD = trmMsa_CD.wgsDlat as? NSDecimalNumber				trmMsa_CD_DB.wgsLong_CD = trmMsa_CD.wgsLong				trmMsa_CD_DB.wgsDlong_CD = trmMsa_CD.wgsDlong as? NSDecimalNumber				trmMsa_CD_DB.cycleDate_CD = trmMsa_CD.cycleDate as? NSDecimalNumber
				return trmMsa_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteTrmMsa_CDFromDB(moc: NSManagedObjectContext) {
		let deleteTrmMsa_CD = NSBatchDeleteRequest(fetchRequest: TrmMsa_CD.fetchRequest())
		do {
			try moc.execute(deleteTrmMsa_CD)
			try moc.save()
			print("All TrmMsa_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllTrmMsa_CD(moc: NSManagedObjectContext) -> [TrmMsa_CD] {
		var trmMsa_CD = [TrmMsa_CD]()
		let trmMsa_CDFetchRequest = NSFetchRequest<TrmMsa_CD>(entityName: "TrmMsa_CD")
		do {
			trmMsa_CD = try moc.fetch(trmMsa_CDFetchRequest)
		} catch {
			print(error)
		}
		return trmMsa_CD
	}
}