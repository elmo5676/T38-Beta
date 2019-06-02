

import Foundation
import CoreData


struct AtsCDU {


	func loadAtsToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ATS_ATS.json")

		do {
			let results = try decoder.decode([Ats].self, from: Data(contentsOf: fileName))
			_ = results.map { (ats_CD) -> Ats_CD in
				let ats_CD_DB = Ats_CD(context: moc)
				ats_CD_DB.atsIdent_CD = ats_CD.atsIdent				ats_CD_DB.seqNbr_CD = ats_CD.seqNbr as? NSDecimalNumber				ats_CD_DB.direction_CD = ats_CD.direction				ats_CD_DB.type_CD = ats_CD.type				ats_CD_DB.icao_CD = ats_CD.icao				ats_CD_DB.bidirect_CD = ats_CD.bidirect				ats_CD_DB.freqClass_CD = ats_CD.freqClass				ats_CD_DB.level_CD = ats_CD.level				ats_CD_DB.status_CD = ats_CD.status				ats_CD_DB.wpt1Icao_CD = ats_CD.wpt1Icao				ats_CD_DB.wpt1NavType_CD = ats_CD.wpt1NavType				ats_CD_DB.wpt1Ident_CD = ats_CD.wpt1Ident				ats_CD_DB.wpt1Ctry_CD = ats_CD.wpt1Ctry				ats_CD_DB.wpt1Desc1_CD = ats_CD.wpt1Desc1				ats_CD_DB.wpt1Desc2_CD = ats_CD.wpt1Desc2				ats_CD_DB.wpt1Desc3_CD = ats_CD.wpt1Desc3				ats_CD_DB.wpt1Desc4_CD = ats_CD.wpt1Desc4				ats_CD_DB.wpt1WgsLat_CD = ats_CD.wpt1WgsLat				ats_CD_DB.wpt1WgsDlat_CD = ats_CD.wpt1WgsDlat as? NSDecimalNumber				ats_CD_DB.wpt1WgsLong_CD = ats_CD.wpt1WgsLong				ats_CD_DB.wpt1WgsDlong_CD = ats_CD.wpt1WgsDlong as? NSDecimalNumber				ats_CD_DB.wpt2Icao_CD = ats_CD.wpt2Icao				ats_CD_DB.wpt2NavType_CD = ats_CD.wpt2NavType as? NSDecimalNumber				ats_CD_DB.wpt2Ident_CD = ats_CD.wpt2Ident				ats_CD_DB.wpt2Ctry_CD = ats_CD.wpt2Ctry				ats_CD_DB.wpt2Desc1_CD = ats_CD.wpt2Desc1				ats_CD_DB.wpt2Desc2_CD = ats_CD.wpt2Desc2				ats_CD_DB.wpt2Desc3_CD = ats_CD.wpt2Desc3				ats_CD_DB.wpt2Desc4_CD = ats_CD.wpt2Desc4				ats_CD_DB.wpt2WgsLat_CD = ats_CD.wpt2WgsLat				ats_CD_DB.wpt2WgsDlat_CD = ats_CD.wpt2WgsDlat as? NSDecimalNumber				ats_CD_DB.wpt2WgsLong_CD = ats_CD.wpt2WgsLong				ats_CD_DB.wpt2WgsDlong_CD = ats_CD.wpt2WgsDlong as? NSDecimalNumber				ats_CD_DB.outbdCrs_CD = ats_CD.outbdCrs as? NSDecimalNumber				ats_CD_DB.distance_CD = ats_CD.distance as? NSDecimalNumber				ats_CD_DB.inbdCrs_CD = ats_CD.inbdCrs as? NSDecimalNumber				ats_CD_DB.minAlt_CD = ats_CD.minAlt				ats_CD_DB.upperLimit_CD = ats_CD.upperLimit				ats_CD_DB.lowerLimit_CD = ats_CD.lowerLimit				ats_CD_DB.maa_CD = ats_CD.maa				ats_CD_DB.cruiseLevel_CD = ats_CD.cruiseLevel				ats_CD_DB.rnp_CD = ats_CD.rnp				ats_CD_DB.cycleDate_CD = ats_CD.cycleDate as? NSDecimalNumber				ats_CD_DB.rvsm_CD = ats_CD.rvsm				ats_CD_DB.fixTurn1_CD = ats_CD.fixTurn1				ats_CD_DB.fixTurn2_CD = ats_CD.fixTurn2
				return ats_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteAts_CDFromDB(moc: NSManagedObjectContext) {
		let deleteAts_CD = NSBatchDeleteRequest(fetchRequest: Ats_CD.fetchRequest())
		do {
			try moc.execute(deleteAts_CD)
			try moc.save()
			print("All Ats_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllAts_CD(moc: NSManagedObjectContext) -> [Ats_CD] {
		var ats_CD = [Ats_CD]()
		let ats_CDFetchRequest = NSFetchRequest<Ats_CD>(entityName: "Ats_CD")
		do {
			ats_CD = try moc.fetch(ats_CDFetchRequest)
		} catch {
			print(error)
		}
		return ats_CD
	}
}