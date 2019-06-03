

import Foundation
import CoreData


struct PjaCDU {


	func loadPjaToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/PJA_PJA.json")
		var tempArray: [Pja_CD] = []

		do {
			let results = try decoder.decode([Pja].self, from: Data(contentsOf: fileName))
			for pja_CD in results {
				let pja_CD_DB = Pja_CD(context: moc)
				pja_CD_DB.pjaIdent_CD = pja_CD.pjaIdent				pja_CD_DB.segNbr_CD = pja_CD.segNbr as? NSDecimalNumber				pja_CD_DB.name_CD = pja_CD.name				pja_CD_DB.icaoRegion_CD = pja_CD.icaoRegion				pja_CD_DB.shap_CD = pja_CD.shap				pja_CD_DB.derivation_CD = pja_CD.derivation				pja_CD_DB.wgsLat1_CD = pja_CD.wgsLat1				pja_CD_DB.wgsDlat1_CD = pja_CD.wgsDlat1				pja_CD_DB.wgsLong1_CD = pja_CD.wgsLong1				pja_CD_DB.wgsDlong1_CD = pja_CD.wgsDlong1				pja_CD_DB.wgsLat2_CD = pja_CD.wgsLat2				pja_CD_DB.wgsDlat2_CD = pja_CD.wgsDlat2				pja_CD_DB.wgsLong2_CD = pja_CD.wgsLong2				pja_CD_DB.wgsDlong2_CD = pja_CD.wgsDlong2				pja_CD_DB.wgsLat0_CD = pja_CD.wgsLat0				pja_CD_DB.wgsDlat0_CD = pja_CD.wgsDlat0 as? NSDecimalNumber				pja_CD_DB.wgsLong0_CD = pja_CD.wgsLong0				pja_CD_DB.wgsDlong0_CD = pja_CD.wgsDlong0 as? NSDecimalNumber				pja_CD_DB.type_CD = pja_CD.type as? NSDecimalNumber				pja_CD_DB.radius1_CD = pja_CD.radius1				pja_CD_DB.radius2_CD = pja_CD.radius2				pja_CD_DB.bearing1_CD = pja_CD.bearing1 as? NSDecimalNumber				pja_CD_DB.bearing2_CD = pja_CD.bearing2 as? NSDecimalNumber				pja_CD_DB.distance1_CD = pja_CD.distance1 as? NSDecimalNumber				pja_CD_DB.distance2_CD = pja_CD.distance2 as? NSDecimalNumber				pja_CD_DB.navIdent_CD = pja_CD.navIdent				pja_CD_DB.navType_CD = pja_CD.navType as? NSDecimalNumber				pja_CD_DB.navCtry_CD = pja_CD.navCtry				pja_CD_DB.navKeyCd_CD = pja_CD.navKeyCd as? NSDecimalNumber				pja_CD_DB.cycleDate_CD = pja_CD.cycleDate as? NSDecimalNumber
				tempArray.append(pja_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deletePja_CDFromDB(moc: NSManagedObjectContext) {
		let deletePja_CD = NSBatchDeleteRequest(fetchRequest: Pja_CD.fetchRequest())
		do {
			try moc.execute(deletePja_CD)
			try moc.save()
			print("All Pja_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllPja_CD(moc: NSManagedObjectContext) -> [Pja_CD] {
		var pja_CD = [Pja_CD]()
		let pja_CDFetchRequest = NSFetchRequest<Pja_CD>(entityName: "Pja_CD")
		do {
			pja_CD = try moc.fetch(pja_CDFetchRequest)
		} catch {
			print(error)
		}
		return pja_CD
	}
}