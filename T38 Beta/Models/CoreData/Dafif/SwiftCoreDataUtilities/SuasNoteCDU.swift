

import Foundation
import CoreData


struct SuasNoteCDU {


	func loadSuasNoteToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/SUAS_SUAS_NOTE.json")

		do {
			let results = try decoder.decode([SuasNote].self, from: Data(contentsOf: fileName))
			_ = results.map { (suasNote_CD) -> SuasNote_CD in
				let suasNote_CD_DB = SuasNote_CD(context: moc)
				suasNote_CD_DB.suasIdent_CD = suasNote_CD.suasIdent				suasNote_CD_DB.sector_CD = suasNote_CD.sector				suasNote_CD_DB.noteType_CD = suasNote_CD.noteType				suasNote_CD_DB.noteNbr_CD = suasNote_CD.noteNbr as? NSDecimalNumber				suasNote_CD_DB.remarks_CD = suasNote_CD.remarks				suasNote_CD_DB.cycleDate_CD = suasNote_CD.cycleDate as? NSDecimalNumber
				return suasNote_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteSuasNote_CDFromDB(moc: NSManagedObjectContext) {
		let deleteSuasNote_CD = NSBatchDeleteRequest(fetchRequest: SuasNote_CD.fetchRequest())
		do {
			try moc.execute(deleteSuasNote_CD)
			try moc.save()
			print("All SuasNote_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllSuasNote_CD(moc: NSManagedObjectContext) -> [SuasNote_CD] {
		var suasNote_CD = [SuasNote_CD]()
		let suasNote_CDFetchRequest = NSFetchRequest<SuasNote_CD>(entityName: "SuasNote_CD")
		do {
			suasNote_CD = try moc.fetch(suasNote_CDFetchRequest)
		} catch {
			print(error)
		}
		return suasNote_CD
	}
}