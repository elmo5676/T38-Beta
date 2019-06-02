

import Foundation
import CoreData


struct MtrParCDU {


	func loadMtrParToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/MTR_MTR_PAR.json")

		do {
			let results = try decoder.decode([MtrPar].self, from: Data(contentsOf: fileName))
			_ = results.map { (mtrPar_CD) -> MtrPar_CD in
				let mtrPar_CD_DB = MtrPar_CD(context: moc)
				mtrPar_CD_DB.mtrIdent_CD = mtrPar_CD.mtrIdent				mtrPar_CD_DB.origAct_CD = mtrPar_CD.origAct				mtrPar_CD_DB.schAct_CD = mtrPar_CD.schAct				mtrPar_CD_DB.icaoRegion_CD = mtrPar_CD.icaoRegion				mtrPar_CD_DB.ctry_CD = mtrPar_CD.ctry				mtrPar_CD_DB.locHdatum_CD = mtrPar_CD.locHdatum				mtrPar_CD_DB.wgsDatum_CD = mtrPar_CD.wgsDatum				mtrPar_CD_DB.effTimes_CD = mtrPar_CD.effTimes				mtrPar_CD_DB.cycleDate_CD = mtrPar_CD.cycleDate as? NSDecimalNumber
				return mtrPar_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteMtrPar_CDFromDB(moc: NSManagedObjectContext) {
		let deleteMtrPar_CD = NSBatchDeleteRequest(fetchRequest: MtrPar_CD.fetchRequest())
		do {
			try moc.execute(deleteMtrPar_CD)
			try moc.save()
			print("All MtrPar_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllMtrPar_CD(moc: NSManagedObjectContext) -> [MtrPar_CD] {
		var mtrPar_CD = [MtrPar_CD]()
		let mtrPar_CDFetchRequest = NSFetchRequest<MtrPar_CD>(entityName: "MtrPar_CD")
		do {
			mtrPar_CD = try moc.fetch(mtrPar_CDFetchRequest)
		} catch {
			print(error)
		}
		return mtrPar_CD
	}
}