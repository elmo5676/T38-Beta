

import Foundation
import CoreData


struct AtsCtryCDU {


	func loadAtsCtryToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ATS_ATS_CTRY.json")

		do {
			let results = try decoder.decode([AtsCtry].self, from: Data(contentsOf: fileName))
			_ = results.map { (atsCtry_CD) -> AtsCtry_CD in
				let atsCtry_CD_DB = AtsCtry_CD(context: moc)
				atsCtry_CD_DB.atsIdent_CD = atsCtry_CD.atsIdent				atsCtry_CD_DB.seqNbr_CD = atsCtry_CD.seqNbr as? NSDecimalNumber				atsCtry_CD_DB.direction_CD = atsCtry_CD.direction				atsCtry_CD_DB.type_CD = atsCtry_CD.type				atsCtry_CD_DB.icao_CD = atsCtry_CD.icao				atsCtry_CD_DB.ctry_CD = atsCtry_CD.ctry				atsCtry_CD_DB.stateProv_CD = atsCtry_CD.stateProv				atsCtry_CD_DB.cycleDate_CD = atsCtry_CD.cycleDate as? NSDecimalNumber
				return atsCtry_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteAtsCtry_CDFromDB(moc: NSManagedObjectContext) {
		let deleteAtsCtry_CD = NSBatchDeleteRequest(fetchRequest: AtsCtry_CD.fetchRequest())
		do {
			try moc.execute(deleteAtsCtry_CD)
			try moc.save()
			print("All AtsCtry_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllAtsCtry_CD(moc: NSManagedObjectContext) -> [AtsCtry_CD] {
		var atsCtry_CD = [AtsCtry_CD]()
		let atsCtry_CDFetchRequest = NSFetchRequest<AtsCtry_CD>(entityName: "AtsCtry_CD")
		do {
			atsCtry_CD = try moc.fetch(atsCtry_CDFetchRequest)
		} catch {
			print(error)
		}
		return atsCtry_CD
	}
}