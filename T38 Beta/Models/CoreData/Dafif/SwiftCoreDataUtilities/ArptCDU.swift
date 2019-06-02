

import Foundation
import CoreData


struct ArptCDU {


	func loadArptToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ARPT_ARPT.json")

		do {
			let results = try decoder.decode([Arpt].self, from: Data(contentsOf: fileName))
			_ = results.map { (arpt_CD) -> Arpt_CD in
				let arpt_CD_DB = Arpt_CD(context: moc)
				arpt_CD_DB.arptIdent_CD = arpt_CD.arptIdent				arpt_CD_DB.name_CD = arpt_CD.name				arpt_CD_DB.stateProv_CD = arpt_CD.stateProv				arpt_CD_DB.icao_CD = arpt_CD.icao				arpt_CD_DB.faaHostId_CD = arpt_CD.faaHostId				arpt_CD_DB.locHdatum_CD = arpt_CD.locHdatum				arpt_CD_DB.wgsDatum_CD = arpt_CD.wgsDatum				arpt_CD_DB.wgsLat_CD = arpt_CD.wgsLat				arpt_CD_DB.wgsDlat_CD = arpt_CD.wgsDlat as? NSDecimalNumber				arpt_CD_DB.wgsLong_CD = arpt_CD.wgsLong				arpt_CD_DB.wgsDlong_CD = arpt_CD.wgsDlong as? NSDecimalNumber				arpt_CD_DB.elev_CD = arpt_CD.elev as? NSDecimalNumber				arpt_CD_DB.type_CD = arpt_CD.type				arpt_CD_DB.magVar_CD = arpt_CD.magVar				arpt_CD_DB.wac_CD = arpt_CD.wac as? NSDecimalNumber				arpt_CD_DB.beacon_CD = arpt_CD.beacon				arpt_CD_DB.secondArpt_CD = arpt_CD.secondArpt				arpt_CD_DB.oprAgy_CD = arpt_CD.oprAgy				arpt_CD_DB.secName_CD = arpt_CD.secName				arpt_CD_DB.secIcao_CD = arpt_CD.secIcao				arpt_CD_DB.secFaa_CD = arpt_CD.secFaa				arpt_CD_DB.secOprAgy_CD = arpt_CD.secOprAgy				arpt_CD_DB.cycleDate_CD = arpt_CD.cycleDate as? NSDecimalNumber				arpt_CD_DB.terrain_CD = arpt_CD.terrain				arpt_CD_DB.hydro_CD = arpt_CD.hydro
				return arpt_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteArpt_CDFromDB(moc: NSManagedObjectContext) {
		let deleteArpt_CD = NSBatchDeleteRequest(fetchRequest: Arpt_CD.fetchRequest())
		do {
			try moc.execute(deleteArpt_CD)
			try moc.save()
			print("All Arpt_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllArpt_CD(moc: NSManagedObjectContext) -> [Arpt_CD] {
		var arpt_CD = [Arpt_CD]()
		let arpt_CDFetchRequest = NSFetchRequest<Arpt_CD>(entityName: "Arpt_CD")
		do {
			arpt_CD = try moc.fetch(arpt_CDFetchRequest)
		} catch {
			print(error)
		}
		return arpt_CD
	}
}