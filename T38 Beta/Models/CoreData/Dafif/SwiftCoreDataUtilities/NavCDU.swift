

import Foundation
import CoreData


struct NavCDU {


	func loadNavToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/NAV_NAV.json")
		var tempArray: [Nav_CD] = []

		do {
			let results = try decoder.decode([Nav].self, from: Data(contentsOf: fileName))
			for nav_CD in results {
				let nav_CD_DB = Nav_CD(context: moc)
				nav_CD_DB.navIdent_CD = nav_CD.navIdent				nav_CD_DB.type_CD = nav_CD.type as? NSDecimalNumber				nav_CD_DB.ctry_CD = nav_CD.ctry				nav_CD_DB.navKeyCd_CD = nav_CD.navKeyCd as? NSDecimalNumber				nav_CD_DB.stateProv_CD = nav_CD.stateProv				nav_CD_DB.name_CD = nav_CD.name				nav_CD_DB.icao_CD = nav_CD.icao				nav_CD_DB.wac_CD = nav_CD.wac as? NSDecimalNumber				nav_CD_DB.freq_CD = nav_CD.freq				nav_CD_DB.usageCd_CD = nav_CD.usageCd				nav_CD_DB.chan_CD = nav_CD.chan				nav_CD_DB.rcc_CD = nav_CD.rcc				nav_CD_DB.freqProt_CD = nav_CD.freqProt				nav_CD_DB.power_CD = nav_CD.power				nav_CD_DB.navRange_CD = nav_CD.navRange				nav_CD_DB.locHdatum_CD = nav_CD.locHdatum				nav_CD_DB.wgsDatum_CD = nav_CD.wgsDatum				nav_CD_DB.wgsLat_CD = nav_CD.wgsLat				nav_CD_DB.wgsDlat_CD = nav_CD.wgsDlat as? NSDecimalNumber				nav_CD_DB.wgsLong_CD = nav_CD.wgsLong				nav_CD_DB.wgsDlong_CD = nav_CD.wgsDlong as? NSDecimalNumber				nav_CD_DB.slavedVar_CD = nav_CD.slavedVar				nav_CD_DB.magVar_CD = nav_CD.magVar				nav_CD_DB.elev_CD = nav_CD.elev as? NSDecimalNumber				nav_CD_DB.dmeWgsLat_CD = nav_CD.dmeWgsLat				nav_CD_DB.dmeWgsDlat_CD = nav_CD.dmeWgsDlat				nav_CD_DB.dmeWgsLong_CD = nav_CD.dmeWgsLong				nav_CD_DB.dmeWgsDlong_CD = nav_CD.dmeWgsDlong				nav_CD_DB.dmeElev_CD = nav_CD.dmeElev				nav_CD_DB.arptIcao_CD = nav_CD.arptIcao				nav_CD_DB.os_CD = nav_CD.os				nav_CD_DB.cycleDate_CD = nav_CD.cycleDate as? NSDecimalNumber
				tempArray.append(nav_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteNav_CDFromDB(moc: NSManagedObjectContext) {
		let deleteNav_CD = NSBatchDeleteRequest(fetchRequest: Nav_CD.fetchRequest())
		do {
			try moc.execute(deleteNav_CD)
			try moc.save()
			print("All Nav_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllNav_CD(moc: NSManagedObjectContext) -> [Nav_CD] {
		var nav_CD = [Nav_CD]()
		let nav_CDFetchRequest = NSFetchRequest<Nav_CD>(entityName: "Nav_CD")
		do {
			nav_CD = try moc.fetch(nav_CDFetchRequest)
		} catch {
			print(error)
		}
		return nav_CD
	}
}