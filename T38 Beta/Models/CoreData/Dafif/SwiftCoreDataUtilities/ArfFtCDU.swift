

import Foundation
import CoreData


struct ArfFtCDU {


	func loadArfFtToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ARF_ARF_FT.json")

		do {
			let results = try decoder.decode([ArfFt].self, from: Data(contentsOf: fileName))
			_ = results.map { (arfFt_CD) -> ArfFt_CD in
				let arfFt_CD_DB = ArfFt_CD(context: moc)
				arfFt_CD_DB.arfIdent_CD = arfFt_CD.arfIdent				arfFt_CD_DB.direction_CD = arfFt_CD.direction				arfFt_CD_DB.icao_CD = arfFt_CD.icao				arfFt_CD_DB.ftType_CD = arfFt_CD.ftType				arfFt_CD_DB.ftNo_CD = arfFt_CD.ftNo as? NSDecimalNumber				arfFt_CD_DB.rmkSeq_CD = arfFt_CD.rmkSeq as? NSDecimalNumber				arfFt_CD_DB.remarks_CD = arfFt_CD.remarks				arfFt_CD_DB.cycleDate_CD = arfFt_CD.cycleDate as? NSDecimalNumber
				return arfFt_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteArfFt_CDFromDB(moc: NSManagedObjectContext) {
		let deleteArfFt_CD = NSBatchDeleteRequest(fetchRequest: ArfFt_CD.fetchRequest())
		do {
			try moc.execute(deleteArfFt_CD)
			try moc.save()
			print("All ArfFt_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllArfFt_CD(moc: NSManagedObjectContext) -> [ArfFt_CD] {
		var arfFt_CD = [ArfFt_CD]()
		let arfFt_CDFetchRequest = NSFetchRequest<ArfFt_CD>(entityName: "ArfFt_CD")
		do {
			arfFt_CD = try moc.fetch(arfFt_CDFetchRequest)
		} catch {
			print(error)
		}
		return arfFt_CD
	}
}