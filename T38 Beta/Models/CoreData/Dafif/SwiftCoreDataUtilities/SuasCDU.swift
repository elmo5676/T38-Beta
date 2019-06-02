

import Foundation
import CoreData


struct SuasCDU {


	func loadSuasToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/SUAS_SUAS.json")

		do {
			let results = try decoder.decode([Suas].self, from: Data(contentsOf: fileName))
			_ = results.map { (suas_CD) -> Suas_CD in
				let suas_CD_DB = Suas_CD(context: moc)
				suas_CD_DB.suasIdent_CD = suas_CD.suasIdent				suas_CD_DB.sector_CD = suas_CD.sector				suas_CD_DB.segNbr_CD = suas_CD.segNbr as? NSDecimalNumber				suas_CD_DB.name_CD = suas_CD.name				suas_CD_DB.type_CD = suas_CD.type				suas_CD_DB.icao_CD = suas_CD.icao				suas_CD_DB.shap_CD = suas_CD.shap				suas_CD_DB.derivation_CD = suas_CD.derivation				suas_CD_DB.wgsLat1_CD = suas_CD.wgsLat1				suas_CD_DB.wgsDlat1_CD = suas_CD.wgsDlat1 as? NSDecimalNumber				suas_CD_DB.wgsLong1_CD = suas_CD.wgsLong1				suas_CD_DB.wgsDlong1_CD = suas_CD.wgsDlong1 as? NSDecimalNumber				suas_CD_DB.wgsLat2_CD = suas_CD.wgsLat2				suas_CD_DB.wgsDlat2_CD = suas_CD.wgsDlat2 as? NSDecimalNumber				suas_CD_DB.wgsLong2_CD = suas_CD.wgsLong2				suas_CD_DB.wgsDlong2_CD = suas_CD.wgsDlong2 as? NSDecimalNumber				suas_CD_DB.wgsLat0_CD = suas_CD.wgsLat0				suas_CD_DB.wgsDlat0_CD = suas_CD.wgsDlat0				suas_CD_DB.wgsLong0_CD = suas_CD.wgsLong0				suas_CD_DB.wgsDlong0_CD = suas_CD.wgsDlong0				suas_CD_DB.radius1_CD = suas_CD.radius1				suas_CD_DB.radius2_CD = suas_CD.radius2				suas_CD_DB.bearing1_CD = suas_CD.bearing1				suas_CD_DB.bearing2_CD = suas_CD.bearing2				suas_CD_DB.navIdent_CD = suas_CD.navIdent				suas_CD_DB.navType_CD = suas_CD.navType				suas_CD_DB.navCtry_CD = suas_CD.navCtry				suas_CD_DB.navKeyCd_CD = suas_CD.navKeyCd				suas_CD_DB.cycleDate_CD = suas_CD.cycleDate as? NSDecimalNumber
				return suas_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteSuas_CDFromDB(moc: NSManagedObjectContext) {
		let deleteSuas_CD = NSBatchDeleteRequest(fetchRequest: Suas_CD.fetchRequest())
		do {
			try moc.execute(deleteSuas_CD)
			try moc.save()
			print("All Suas_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllSuas_CD(moc: NSManagedObjectContext) -> [Suas_CD] {
		var suas_CD = [Suas_CD]()
		let suas_CDFetchRequest = NSFetchRequest<Suas_CD>(entityName: "Suas_CD")
		do {
			suas_CD = try moc.fetch(suas_CDFetchRequest)
		} catch {
			print(error)
		}
		return suas_CD
	}
}