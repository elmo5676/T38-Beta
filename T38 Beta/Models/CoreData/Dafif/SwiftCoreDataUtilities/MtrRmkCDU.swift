

import Foundation
import CoreData


struct MtrRmkCDU {


	func loadMtrRmkToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/MTR_MTR_RMK.json")
		var tempArray: [MtrRmk_CD] = []

		do {
			let results = try decoder.decode([MtrRmk].self, from: Data(contentsOf: fileName))
			for mtrRmk_CD in results {
				let mtrRmk_CD_DB = MtrRmk_CD(context: moc)
				mtrRmk_CD_DB.mtrIdent_CD = mtrRmk_CD.mtrIdent				mtrRmk_CD_DB.rmkSeq_CD = mtrRmk_CD.rmkSeq as? NSDecimalNumber				mtrRmk_CD_DB.remarks_CD = mtrRmk_CD.remarks				mtrRmk_CD_DB.cycleDate_CD = mtrRmk_CD.cycleDate as? NSDecimalNumber
				tempArray.append(mtrRmk_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteMtrRmk_CDFromDB(moc: NSManagedObjectContext) {
		let deleteMtrRmk_CD = NSBatchDeleteRequest(fetchRequest: MtrRmk_CD.fetchRequest())
		do {
			try moc.execute(deleteMtrRmk_CD)
			try moc.save()
			print("All MtrRmk_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllMtrRmk_CD(moc: NSManagedObjectContext) -> [MtrRmk_CD] {
		var mtrRmk_CD = [MtrRmk_CD]()
		let mtrRmk_CDFetchRequest = NSFetchRequest<MtrRmk_CD>(entityName: "MtrRmk_CD")
		do {
			mtrRmk_CD = try moc.fetch(mtrRmk_CDFetchRequest)
		} catch {
			print(error)
		}
		return mtrRmk_CD
	}
}