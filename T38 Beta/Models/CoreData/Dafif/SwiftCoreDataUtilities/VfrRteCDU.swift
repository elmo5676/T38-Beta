

import Foundation
import CoreData


struct VfrRteCDU {


	func loadVfrRteToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/VFR_VFR_RTE.json")
		var tempArray: [VfrRte_CD] = []

		do {
			let results = try decoder.decode([VfrRte].self, from: Data(contentsOf: fileName))
			for vfrRte_CD in results {
				let vfrRte_CD_DB = VfrRte_CD(context: moc)
				vfrRte_CD_DB.heliIdent_CD = vfrRte_CD.heliIdent				vfrRte_CD_DB.heliName_CD = vfrRte_CD.heliName				vfrRte_CD_DB.ctry_CD = vfrRte_CD.ctry				vfrRte_CD_DB.stateProv_CD = vfrRte_CD.stateProv				vfrRte_CD_DB.icao_CD = vfrRte_CD.icao				vfrRte_CD_DB.faaHostId_CD = vfrRte_CD.faaHostId				vfrRte_CD_DB.wgsDatum_CD = vfrRte_CD.wgsDatum				vfrRte_CD_DB.wgsLat_CD = vfrRte_CD.wgsLat				vfrRte_CD_DB.rpWgsDlat_CD = vfrRte_CD.rpWgsDlat as? NSDecimalNumber				vfrRte_CD_DB.wgsLong_CD = vfrRte_CD.wgsLong				vfrRte_CD_DB.rpWgsDlong_CD = vfrRte_CD.rpWgsDlong as? NSDecimalNumber				vfrRte_CD_DB.elev_CD = vfrRte_CD.elev as? NSDecimalNumber				vfrRte_CD_DB.magVar_CD = vfrRte_CD.magVar				vfrRte_CD_DB.cityCrossRef_CD = vfrRte_CD.cityCrossRef				vfrRte_CD_DB.locHdatum_CD = vfrRte_CD.locHdatum				vfrRte_CD_DB.cycleDate_CD = vfrRte_CD.cycleDate as? NSDecimalNumber
				tempArray.append(vfrRte_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteVfrRte_CDFromDB(moc: NSManagedObjectContext) {
		let deleteVfrRte_CD = NSBatchDeleteRequest(fetchRequest: VfrRte_CD.fetchRequest())
		do {
			try moc.execute(deleteVfrRte_CD)
			try moc.save()
			print("All VfrRte_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllVfrRte_CD(moc: NSManagedObjectContext) -> [VfrRte_CD] {
		var vfrRte_CD = [VfrRte_CD]()
		let vfrRte_CDFetchRequest = NSFetchRequest<VfrRte_CD>(entityName: "VfrRte_CD")
		do {
			vfrRte_CD = try moc.fetch(vfrRte_CDFetchRequest)
		} catch {
			print(error)
		}
		return vfrRte_CD
	}
}