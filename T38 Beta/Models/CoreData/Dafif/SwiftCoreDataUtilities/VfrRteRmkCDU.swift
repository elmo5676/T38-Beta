

import Foundation
import CoreData


struct VfrRteRmkCDU {


	func loadVfrRteRmkToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/VFR_VFR_RTE_RMK.json")
		var tempArray: [VfrRteRmk_CD] = []

		do {
			let results = try decoder.decode([VfrRteRmk].self, from: Data(contentsOf: fileName))
			for vfrRteRmk_CD in results {
				let vfrRteRmk_CD_DB = VfrRteRmk_CD(context: moc)
				vfrRteRmk_CD_DB.heliIdent_CD = vfrRteRmk_CD.heliIdent				vfrRteRmk_CD_DB.rmkSeq_CD = vfrRteRmk_CD.rmkSeq as? NSDecimalNumber				vfrRteRmk_CD_DB.remarks_CD = vfrRteRmk_CD.remarks				vfrRteRmk_CD_DB.cycleDate_CD = vfrRteRmk_CD.cycleDate as? NSDecimalNumber
				tempArray.append(vfrRteRmk_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteVfrRteRmk_CDFromDB(moc: NSManagedObjectContext) {
		let deleteVfrRteRmk_CD = NSBatchDeleteRequest(fetchRequest: VfrRteRmk_CD.fetchRequest())
		do {
			try moc.execute(deleteVfrRteRmk_CD)
			try moc.save()
			print("All VfrRteRmk_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllVfrRteRmk_CD(moc: NSManagedObjectContext) -> [VfrRteRmk_CD] {
		var vfrRteRmk_CD = [VfrRteRmk_CD]()
		let vfrRteRmk_CDFetchRequest = NSFetchRequest<VfrRteRmk_CD>(entityName: "VfrRteRmk_CD")
		do {
			vfrRteRmk_CD = try moc.fetch(vfrRteRmk_CDFetchRequest)
		} catch {
			print(error)
		}
		return vfrRteRmk_CD
	}
}