

import Foundation
import CoreData


struct SuasCtryCDU {


	func loadSuasCtryToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/SUAS_SUAS_CTRY.json")

		do {
			let results = try decoder.decode([SuasCtry].self, from: Data(contentsOf: fileName))
			_ = results.map { (suasCtry_CD) -> SuasCtry_CD in
				let suasCtry_CD_DB = SuasCtry_CD(context: moc)
				suasCtry_CD_DB.suasIdent_CD = suasCtry_CD.suasIdent				suasCtry_CD_DB.sector_CD = suasCtry_CD.sector				suasCtry_CD_DB.icao_CD = suasCtry_CD.icao				suasCtry_CD_DB.ctry1_CD = suasCtry_CD.ctry1				suasCtry_CD_DB.ctry2_CD = suasCtry_CD.ctry2				suasCtry_CD_DB.ctry3_CD = suasCtry_CD.ctry3				suasCtry_CD_DB.ctry4_CD = suasCtry_CD.ctry4				suasCtry_CD_DB.cycleDate_CD = suasCtry_CD.cycleDate as? NSDecimalNumber
				return suasCtry_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteSuasCtry_CDFromDB(moc: NSManagedObjectContext) {
		let deleteSuasCtry_CD = NSBatchDeleteRequest(fetchRequest: SuasCtry_CD.fetchRequest())
		do {
			try moc.execute(deleteSuasCtry_CD)
			try moc.save()
			print("All SuasCtry_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllSuasCtry_CD(moc: NSManagedObjectContext) -> [SuasCtry_CD] {
		var suasCtry_CD = [SuasCtry_CD]()
		let suasCtry_CDFetchRequest = NSFetchRequest<SuasCtry_CD>(entityName: "SuasCtry_CD")
		do {
			suasCtry_CD = try moc.fetch(suasCtry_CDFetchRequest)
		} catch {
			print(error)
		}
		return suasCtry_CD
	}
}