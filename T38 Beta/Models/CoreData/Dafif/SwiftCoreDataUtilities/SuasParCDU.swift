

import Foundation
import CoreData


struct SuasParCDU {


	func loadSuasParToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/SUAS_SUAS_PAR.json")
		var tempArray: [SuasPar_CD] = []

		do {
			let results = try decoder.decode([SuasPar].self, from: Data(contentsOf: fileName))
			for suasPar_CD in results {
				let suasPar_CD_DB = SuasPar_CD(context: moc)
				suasPar_CD_DB.suasIdent_CD = suasPar_CD.suasIdent				suasPar_CD_DB.sector_CD = suasPar_CD.sector				suasPar_CD_DB.type_CD = suasPar_CD.type				suasPar_CD_DB.name_CD = suasPar_CD.name				suasPar_CD_DB.icao_CD = suasPar_CD.icao				suasPar_CD_DB.conAgcy_CD = suasPar_CD.conAgcy				suasPar_CD_DB.locHdatum_CD = suasPar_CD.locHdatum				suasPar_CD_DB.wgsDatum_CD = suasPar_CD.wgsDatum				suasPar_CD_DB.commName_CD = suasPar_CD.commName				suasPar_CD_DB.freq1_CD = suasPar_CD.freq1				suasPar_CD_DB.freq2_CD = suasPar_CD.freq2				suasPar_CD_DB.level_CD = suasPar_CD.level				suasPar_CD_DB.upperAlt_CD = suasPar_CD.upperAlt				suasPar_CD_DB.lowerAlt_CD = suasPar_CD.lowerAlt				suasPar_CD_DB.effTimes_CD = suasPar_CD.effTimes				suasPar_CD_DB.wx_CD = suasPar_CD.wx				suasPar_CD_DB.cycleDate_CD = suasPar_CD.cycleDate as? NSDecimalNumber				suasPar_CD_DB.effDate_CD = suasPar_CD.effDate
				tempArray.append(suasPar_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteSuasPar_CDFromDB(moc: NSManagedObjectContext) {
		let deleteSuasPar_CD = NSBatchDeleteRequest(fetchRequest: SuasPar_CD.fetchRequest())
		do {
			try moc.execute(deleteSuasPar_CD)
			try moc.save()
			print("All SuasPar_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllSuasPar_CD(moc: NSManagedObjectContext) -> [SuasPar_CD] {
		var suasPar_CD = [SuasPar_CD]()
		let suasPar_CDFetchRequest = NSFetchRequest<SuasPar_CD>(entityName: "SuasPar_CD")
		do {
			suasPar_CD = try moc.fetch(suasPar_CDFetchRequest)
		} catch {
			print(error)
		}
		return suasPar_CD
	}
}