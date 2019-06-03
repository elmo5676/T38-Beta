

import Foundation
import CoreData


struct ArfPtCDU {


	func loadArfPtToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ARF_ARF_PT.json")
		var tempArray: [ArfPt_CD] = []

		do {
			let results = try decoder.decode([ArfPt].self, from: Data(contentsOf: fileName))
			for arfPt_CD in results {
				let arfPt_CD_DB = ArfPt_CD(context: moc)
				arfPt_CD_DB.arfIdent_CD = arfPt_CD.arfIdent				arfPt_CD_DB.direction_CD = arfPt_CD.direction				arfPt_CD_DB.ptSeqNbr_CD = arfPt_CD.ptSeqNbr as? NSDecimalNumber				arfPt_CD_DB.icao_CD = arfPt_CD.icao				arfPt_CD_DB.usage_CD = arfPt_CD.usage				arfPt_CD_DB.ptNavFlag_CD = arfPt_CD.ptNavFlag				arfPt_CD_DB.navIdent_CD = arfPt_CD.navIdent				arfPt_CD_DB.navType_CD = arfPt_CD.navType				arfPt_CD_DB.navCtry_CD = arfPt_CD.navCtry				arfPt_CD_DB.navKeyCd_CD = arfPt_CD.navKeyCd				arfPt_CD_DB.bearing_CD = arfPt_CD.bearing				arfPt_CD_DB.distance_CD = arfPt_CD.distance				arfPt_CD_DB.wgsLat_CD = arfPt_CD.wgsLat				arfPt_CD_DB.wgsDlat_CD = arfPt_CD.wgsDlat as? NSDecimalNumber				arfPt_CD_DB.wgsLong_CD = arfPt_CD.wgsLong				arfPt_CD_DB.wgsDlong_CD = arfPt_CD.wgsDlong as? NSDecimalNumber				arfPt_CD_DB.cycleDate_CD = arfPt_CD.cycleDate as? NSDecimalNumber				arfPt_CD_DB.ptIdent_CD = arfPt_CD.ptIdent
				tempArray.append(arfPt_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteArfPt_CDFromDB(moc: NSManagedObjectContext) {
		let deleteArfPt_CD = NSBatchDeleteRequest(fetchRequest: ArfPt_CD.fetchRequest())
		do {
			try moc.execute(deleteArfPt_CD)
			try moc.save()
			print("All ArfPt_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllArfPt_CD(moc: NSManagedObjectContext) -> [ArfPt_CD] {
		var arfPt_CD = [ArfPt_CD]()
		let arfPt_CDFetchRequest = NSFetchRequest<ArfPt_CD>(entityName: "ArfPt_CD")
		do {
			arfPt_CD = try moc.fetch(arfPt_CDFetchRequest)
		} catch {
			print(error)
		}
		return arfPt_CD
	}
}