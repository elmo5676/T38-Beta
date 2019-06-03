

import Foundation
import CoreData


struct MtrCDU {


	func loadMtrToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/MTR_MTR.json")
		var tempArray: [Mtr_CD] = []

		do {
			let results = try decoder.decode([Mtr].self, from: Data(contentsOf: fileName))
			for mtr_CD in results {
				let mtr_CD_DB = Mtr_CD(context: moc)
				mtr_CD_DB.mtrIdent_CD = mtr_CD.mtrIdent				mtr_CD_DB.ptIdent_CD = mtr_CD.ptIdent				mtr_CD_DB.nxPoint_CD = mtr_CD.nxPoint				mtr_CD_DB.icaoRegion_CD = mtr_CD.icaoRegion				mtr_CD_DB.crsaltDesc_CD = mtr_CD.crsaltDesc				mtr_CD_DB.crsAlt1_CD = mtr_CD.crsAlt1				mtr_CD_DB.crsAlt2_CD = mtr_CD.crsAlt2				mtr_CD_DB.enraltDesc_CD = mtr_CD.enraltDesc				mtr_CD_DB.enrAlt1_CD = mtr_CD.enrAlt1				mtr_CD_DB.enrAlt2_CD = mtr_CD.enrAlt2				mtr_CD_DB.ptNavFlag_CD = mtr_CD.ptNavFlag				mtr_CD_DB.navIdent_CD = mtr_CD.navIdent				mtr_CD_DB.navType_CD = mtr_CD.navType as? NSDecimalNumber				mtr_CD_DB.navCtry_CD = mtr_CD.navCtry				mtr_CD_DB.navKeyCd_CD = mtr_CD.navKeyCd as? NSDecimalNumber				mtr_CD_DB.bearing_CD = mtr_CD.bearing as? NSDecimalNumber				mtr_CD_DB.distance_CD = mtr_CD.distance as? NSDecimalNumber				mtr_CD_DB.mtrWidthL_CD = mtr_CD.mtrWidthL as? NSDecimalNumber				mtr_CD_DB.mtrWidthR_CD = mtr_CD.mtrWidthR as? NSDecimalNumber				mtr_CD_DB.usageCd_CD = mtr_CD.usageCd				mtr_CD_DB.wgsLat_CD = mtr_CD.wgsLat				mtr_CD_DB.wgsDlat_CD = mtr_CD.wgsDlat as? NSDecimalNumber				mtr_CD_DB.wgsLong_CD = mtr_CD.wgsLong				mtr_CD_DB.wgsDlong_CD = mtr_CD.wgsDlong as? NSDecimalNumber				mtr_CD_DB.turnRad_CD = mtr_CD.turnRad				mtr_CD_DB.turnDir_CD = mtr_CD.turnDir				mtr_CD_DB.addInfo_CD = mtr_CD.addInfo				mtr_CD_DB.cycleDate_CD = mtr_CD.cycleDate as? NSDecimalNumber
				tempArray.append(mtr_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteMtr_CDFromDB(moc: NSManagedObjectContext) {
		let deleteMtr_CD = NSBatchDeleteRequest(fetchRequest: Mtr_CD.fetchRequest())
		do {
			try moc.execute(deleteMtr_CD)
			try moc.save()
			print("All Mtr_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllMtr_CD(moc: NSManagedObjectContext) -> [Mtr_CD] {
		var mtr_CD = [Mtr_CD]()
		let mtr_CDFetchRequest = NSFetchRequest<Mtr_CD>(entityName: "Mtr_CD")
		do {
			mtr_CD = try moc.fetch(mtr_CDFetchRequest)
		} catch {
			print(error)
		}
		return mtr_CD
	}
}