

import Foundation
import CoreData


struct BdryCDU {


	func loadBdryToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/BDRY_BDRY.json")

		do {
			let results = try decoder.decode([Bdry].self, from: Data(contentsOf: fileName))
			_ = results.map { (bdry_CD) -> Bdry_CD in
				let bdry_CD_DB = Bdry_CD(context: moc)
				bdry_CD_DB.bdryIdent_CD = bdry_CD.bdryIdent				bdry_CD_DB.segNbr_CD = bdry_CD.segNbr as? NSDecimalNumber				bdry_CD_DB.name_CD = bdry_CD.name				bdry_CD_DB.type_CD = bdry_CD.type as? NSDecimalNumber				bdry_CD_DB.icao_CD = bdry_CD.icao				bdry_CD_DB.shap_CD = bdry_CD.shap				bdry_CD_DB.derivation_CD = bdry_CD.derivation				bdry_CD_DB.wgsLat1_CD = bdry_CD.wgsLat1				bdry_CD_DB.wgsDlat1_CD = bdry_CD.wgsDlat1 as? NSDecimalNumber				bdry_CD_DB.wgsLong1_CD = bdry_CD.wgsLong1				bdry_CD_DB.wgsDlong1_CD = bdry_CD.wgsDlong1 as? NSDecimalNumber				bdry_CD_DB.wgsLat2_CD = bdry_CD.wgsLat2				bdry_CD_DB.wgsDlat2_CD = bdry_CD.wgsDlat2 as? NSDecimalNumber				bdry_CD_DB.wgsLong2_CD = bdry_CD.wgsLong2				bdry_CD_DB.wgsDlong2_CD = bdry_CD.wgsDlong2 as? NSDecimalNumber				bdry_CD_DB.wgsLat0_CD = bdry_CD.wgsLat0				bdry_CD_DB.wgsDlat0_CD = bdry_CD.wgsDlat0				bdry_CD_DB.wgsLong0_CD = bdry_CD.wgsLong0				bdry_CD_DB.wgsDlong0_CD = bdry_CD.wgsDlong0				bdry_CD_DB.radius1_CD = bdry_CD.radius1				bdry_CD_DB.radius2_CD = bdry_CD.radius2				bdry_CD_DB.bearing1_CD = bdry_CD.bearing1				bdry_CD_DB.bearing2_CD = bdry_CD.bearing2				bdry_CD_DB.navIdent_CD = bdry_CD.navIdent				bdry_CD_DB.navType_CD = bdry_CD.navType				bdry_CD_DB.navCtry_CD = bdry_CD.navCtry				bdry_CD_DB.navKeyCd_CD = bdry_CD.navKeyCd				bdry_CD_DB.cycleDate_CD = bdry_CD.cycleDate as? NSDecimalNumber
				return bdry_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteBdry_CDFromDB(moc: NSManagedObjectContext) {
		let deleteBdry_CD = NSBatchDeleteRequest(fetchRequest: Bdry_CD.fetchRequest())
		do {
			try moc.execute(deleteBdry_CD)
			try moc.save()
			print("All Bdry_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllBdry_CD(moc: NSManagedObjectContext) -> [Bdry_CD] {
		var bdry_CD = [Bdry_CD]()
		let bdry_CDFetchRequest = NSFetchRequest<Bdry_CD>(entityName: "Bdry_CD")
		do {
			bdry_CD = try moc.fetch(bdry_CDFetchRequest)
		} catch {
			print(error)
		}
		return bdry_CD
	}
}