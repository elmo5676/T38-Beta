

import Foundation
import CoreData


struct MtrOsmCDU {


	func loadMtrOsmToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/MTR_MTR_OSM.json")

		do {
			let results = try decoder.decode([MtrOsm].self, from: Data(contentsOf: fileName))
			_ = results.map { (mtrOsm_CD) -> MtrOsm_CD in
				let mtrOsm_CD_DB = MtrOsm_CD(context: moc)
				mtrOsm_CD_DB.mtrIdent_CD = mtrOsm_CD.mtrIdent				mtrOsm_CD_DB.segNbr_CD = mtrOsm_CD.segNbr as? NSDecimalNumber				mtrOsm_CD_DB.seqNbr_CD = mtrOsm_CD.seqNbr as? NSDecimalNumber				mtrOsm_CD_DB.suasMoaId_CD = mtrOsm_CD.suasMoaId				mtrOsm_CD_DB.cycleDate_CD = mtrOsm_CD.cycleDate as? NSDecimalNumber				mtrOsm_CD_DB.sector_CD = mtrOsm_CD.sector				mtrOsm_CD_DB.ptIdent_CD = mtrOsm_CD.ptIdent				mtrOsm_CD_DB.nxPoint_CD = mtrOsm_CD.nxPoint
				return mtrOsm_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteMtrOsm_CDFromDB(moc: NSManagedObjectContext) {
		let deleteMtrOsm_CD = NSBatchDeleteRequest(fetchRequest: MtrOsm_CD.fetchRequest())
		do {
			try moc.execute(deleteMtrOsm_CD)
			try moc.save()
			print("All MtrOsm_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllMtrOsm_CD(moc: NSManagedObjectContext) -> [MtrOsm_CD] {
		var mtrOsm_CD = [MtrOsm_CD]()
		let mtrOsm_CDFetchRequest = NSFetchRequest<MtrOsm_CD>(entityName: "MtrOsm_CD")
		do {
			mtrOsm_CD = try moc.fetch(mtrOsm_CDFetchRequest)
		} catch {
			print(error)
		}
		return mtrOsm_CD
	}
}