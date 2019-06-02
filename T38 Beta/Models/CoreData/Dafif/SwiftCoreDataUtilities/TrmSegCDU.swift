

import Foundation
import CoreData


struct TrmSegCDU {


	func loadTrmSegToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/TRM_TRM_SEG.json")

		do {
			let results = try decoder.decode([TrmSeg].self, from: Data(contentsOf: fileName))
			_ = results.map { (trmSeg_CD) -> TrmSeg_CD in
				let trmSeg_CD_DB = TrmSeg_CD(context: moc)
				trmSeg_CD_DB.arptIdent_CD = trmSeg_CD.arptIdent				trmSeg_CD_DB.proc_CD = trmSeg_CD.proc as? NSDecimalNumber				trmSeg_CD_DB.trmIdent_CD = trmSeg_CD.trmIdent				trmSeg_CD_DB.seqNbr_CD = trmSeg_CD.seqNbr as? NSDecimalNumber				trmSeg_CD_DB.type_CD = trmSeg_CD.type as? NSDecimalNumber				trmSeg_CD_DB.transition_CD = trmSeg_CD.transition				trmSeg_CD_DB.icao_CD = trmSeg_CD.icao				trmSeg_CD_DB.trackCd_CD = trmSeg_CD.trackCd				trmSeg_CD_DB.wptId_CD = trmSeg_CD.wptId				trmSeg_CD_DB.wptCtry_CD = trmSeg_CD.wptCtry				trmSeg_CD_DB.wptDesc1_CD = trmSeg_CD.wptDesc1				trmSeg_CD_DB.wptDesc2_CD = trmSeg_CD.wptDesc2				trmSeg_CD_DB.wptDesc3_CD = trmSeg_CD.wptDesc3				trmSeg_CD_DB.wptDesc4_CD = trmSeg_CD.wptDesc4				trmSeg_CD_DB.turnDir_CD = trmSeg_CD.turnDir				trmSeg_CD_DB.nav1Ident_CD = trmSeg_CD.nav1Ident				trmSeg_CD_DB.nav1Type_CD = trmSeg_CD.nav1Type				trmSeg_CD_DB.nav1Ctry_CD = trmSeg_CD.nav1Ctry				trmSeg_CD_DB.nav1KeyCd_CD = trmSeg_CD.nav1KeyCd				trmSeg_CD_DB.nav1Bear_CD = trmSeg_CD.nav1Bear				trmSeg_CD_DB.nav1Dist_CD = trmSeg_CD.nav1Dist				trmSeg_CD_DB.nav2Ident_CD = trmSeg_CD.nav2Ident				trmSeg_CD_DB.nav2Type_CD = trmSeg_CD.nav2Type				trmSeg_CD_DB.nav2Ctry_CD = trmSeg_CD.nav2Ctry				trmSeg_CD_DB.nav2KeyCd_CD = trmSeg_CD.nav2KeyCd				trmSeg_CD_DB.nav2Bear_CD = trmSeg_CD.nav2Bear				trmSeg_CD_DB.nav2Dist_CD = trmSeg_CD.nav2Dist				trmSeg_CD_DB.magCrs_CD = trmSeg_CD.magCrs				trmSeg_CD_DB.distance_CD = trmSeg_CD.distance				trmSeg_CD_DB.altDesc_CD = trmSeg_CD.altDesc				trmSeg_CD_DB.altOne_CD = trmSeg_CD.altOne				trmSeg_CD_DB.altTwo_CD = trmSeg_CD.altTwo				trmSeg_CD_DB.rnp_CD = trmSeg_CD.rnp				trmSeg_CD_DB.cycleDate_CD = trmSeg_CD.cycleDate as? NSDecimalNumber				trmSeg_CD_DB.wptWgsLat_CD = trmSeg_CD.wptWgsLat				trmSeg_CD_DB.wptWgsDlat_CD = trmSeg_CD.wptWgsDlat as? NSDecimalNumber				trmSeg_CD_DB.wptWgsLong_CD = trmSeg_CD.wptWgsLong				trmSeg_CD_DB.wptWgsDlong_CD = trmSeg_CD.wptWgsDlong as? NSDecimalNumber				trmSeg_CD_DB.wptMvar_CD = trmSeg_CD.wptMvar as? NSDecimalNumber				trmSeg_CD_DB.nav1WgsLat_CD = trmSeg_CD.nav1WgsLat				trmSeg_CD_DB.nav1WgsDlat_CD = trmSeg_CD.nav1WgsDlat				trmSeg_CD_DB.nav1WgsLong_CD = trmSeg_CD.nav1WgsLong				trmSeg_CD_DB.nav1WgsDlong_CD = trmSeg_CD.nav1WgsDlong				trmSeg_CD_DB.nav1Mvar_CD = trmSeg_CD.nav1Mvar				trmSeg_CD_DB.nav1DmeWgsLat_CD = trmSeg_CD.nav1DmeWgsLat				trmSeg_CD_DB.nav1DmeWgsDlat_CD = trmSeg_CD.nav1DmeWgsDlat				trmSeg_CD_DB.nav1DmeWgsLong_CD = trmSeg_CD.nav1DmeWgsLong				trmSeg_CD_DB.nav1DmeWgsDlong_CD = trmSeg_CD.nav1DmeWgsDlong				trmSeg_CD_DB.nav2WgsLat_CD = trmSeg_CD.nav2WgsLat				trmSeg_CD_DB.nav2WgsDlat_CD = trmSeg_CD.nav2WgsDlat				trmSeg_CD_DB.nav2WgsLong_CD = trmSeg_CD.nav2WgsLong				trmSeg_CD_DB.nav2WgsDlong_CD = trmSeg_CD.nav2WgsDlong				trmSeg_CD_DB.nav2Mvar_CD = trmSeg_CD.nav2Mvar				trmSeg_CD_DB.nav2DmeWgsLat_CD = trmSeg_CD.nav2DmeWgsLat				trmSeg_CD_DB.nav2DmeWgsDlat_CD = trmSeg_CD.nav2DmeWgsDlat				trmSeg_CD_DB.nav2DmeWgsLong_CD = trmSeg_CD.nav2DmeWgsLong				trmSeg_CD_DB.nav2DmeWgsDlong_CD = trmSeg_CD.nav2DmeWgsDlong				trmSeg_CD_DB.speed_CD = trmSeg_CD.speed				trmSeg_CD_DB.speedAc_CD = trmSeg_CD.speedAc				trmSeg_CD_DB.speedAlt_CD = trmSeg_CD.speedAlt				trmSeg_CD_DB.speed2_CD = trmSeg_CD.speed2				trmSeg_CD_DB.speedAc2_CD = trmSeg_CD.speedAc2				trmSeg_CD_DB.speedAlt2_CD = trmSeg_CD.speedAlt2				trmSeg_CD_DB.vnav_CD = trmSeg_CD.vnav				trmSeg_CD_DB.tch_CD = trmSeg_CD.tch
				return trmSeg_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteTrmSeg_CDFromDB(moc: NSManagedObjectContext) {
		let deleteTrmSeg_CD = NSBatchDeleteRequest(fetchRequest: TrmSeg_CD.fetchRequest())
		do {
			try moc.execute(deleteTrmSeg_CD)
			try moc.save()
			print("All TrmSeg_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllTrmSeg_CD(moc: NSManagedObjectContext) -> [TrmSeg_CD] {
		var trmSeg_CD = [TrmSeg_CD]()
		let trmSeg_CDFetchRequest = NSFetchRequest<TrmSeg_CD>(entityName: "TrmSeg_CD")
		do {
			trmSeg_CD = try moc.fetch(trmSeg_CDFetchRequest)
		} catch {
			print(error)
		}
		return trmSeg_CD
	}
}