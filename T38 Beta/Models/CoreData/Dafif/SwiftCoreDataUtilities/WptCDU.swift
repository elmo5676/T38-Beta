

import Foundation
import CoreData


struct WptCDU {


	func loadWptToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/WPT_WPT.json")

		do {
			let results = try decoder.decode([Wpt].self, from: Data(contentsOf: fileName))
			_ = results.map { (wpt_CD) -> Wpt_CD in
				let wpt_CD_DB = Wpt_CD(context: moc)
				wpt_CD_DB.wptIdent_CD = wpt_CD.wptIdent				wpt_CD_DB.ctry_CD = wpt_CD.ctry				wpt_CD_DB.stateProv_CD = wpt_CD.stateProv as? NSDecimalNumber				wpt_CD_DB.wptNavFlag_CD = wpt_CD.wptNavFlag				wpt_CD_DB.type_CD = wpt_CD.type				wpt_CD_DB.desc_CD = wpt_CD.desc				wpt_CD_DB.icao_CD = wpt_CD.icao				wpt_CD_DB.usageCd_CD = wpt_CD.usageCd				wpt_CD_DB.bearing_CD = wpt_CD.bearing as? NSDecimalNumber				wpt_CD_DB.distance_CD = wpt_CD.distance as? NSDecimalNumber				wpt_CD_DB.wac_CD = wpt_CD.wac as? NSDecimalNumber				wpt_CD_DB.locHdatum_CD = wpt_CD.locHdatum				wpt_CD_DB.wgsDatum_CD = wpt_CD.wgsDatum				wpt_CD_DB.wgsLat_CD = wpt_CD.wgsLat				wpt_CD_DB.wgsDlat_CD = wpt_CD.wgsDlat as? NSDecimalNumber				wpt_CD_DB.wgsLong_CD = wpt_CD.wgsLong				wpt_CD_DB.wgsDlong_CD = wpt_CD.wgsDlong as? NSDecimalNumber				wpt_CD_DB.magVar_CD = wpt_CD.magVar				wpt_CD_DB.navIdent_CD = wpt_CD.navIdent				wpt_CD_DB.navType_CD = wpt_CD.navType as? NSDecimalNumber				wpt_CD_DB.navCtry_CD = wpt_CD.navCtry				wpt_CD_DB.navKeyCd_CD = wpt_CD.navKeyCd as? NSDecimalNumber				wpt_CD_DB.cycleDate_CD = wpt_CD.cycleDate as? NSDecimalNumber				wpt_CD_DB.wptRvsm_CD = wpt_CD.wptRvsm				wpt_CD_DB.rwyId_CD = wpt_CD.rwyId				wpt_CD_DB.rwyIcao_CD = wpt_CD.rwyIcao
				return wpt_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteWpt_CDFromDB(moc: NSManagedObjectContext) {
		let deleteWpt_CD = NSBatchDeleteRequest(fetchRequest: Wpt_CD.fetchRequest())
		do {
			try moc.execute(deleteWpt_CD)
			try moc.save()
			print("All Wpt_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllWpt_CD(moc: NSManagedObjectContext) -> [Wpt_CD] {
		var wpt_CD = [Wpt_CD]()
		let wpt_CDFetchRequest = NSFetchRequest<Wpt_CD>(entityName: "Wpt_CD")
		do {
			wpt_CD = try moc.fetch(wpt_CDFetchRequest)
		} catch {
			print(error)
		}
		return wpt_CD
	}
}