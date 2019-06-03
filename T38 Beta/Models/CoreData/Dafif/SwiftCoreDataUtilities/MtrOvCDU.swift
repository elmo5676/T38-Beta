

import Foundation
import CoreData


struct MtrOvCDU {


	func loadMtrOvToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/MTR_MTR_OV.json")
		var tempArray: [MtrOv_CD] = []

		do {
			let results = try decoder.decode([MtrOv].self, from: Data(contentsOf: fileName))
			for mtrOv_CD in results {
				let mtrOv_CD_DB = MtrOv_CD(context: moc)
				mtrOv_CD_DB.mtrIdent_CD = mtrOv_CD.mtrIdent				mtrOv_CD_DB.segNbr_CD = mtrOv_CD.segNbr as? NSDecimalNumber				mtrOv_CD_DB.ptIdent_CD = mtrOv_CD.ptIdent				mtrOv_CD_DB.ptUsage_CD = mtrOv_CD.ptUsage				mtrOv_CD_DB.ptLat_CD = mtrOv_CD.ptLat				mtrOv_CD_DB.ptDlat_CD = mtrOv_CD.ptDlat as? NSDecimalNumber				mtrOv_CD_DB.ptLong_CD = mtrOv_CD.ptLong				mtrOv_CD_DB.ptDlong_CD = mtrOv_CD.ptDlong as? NSDecimalNumber				mtrOv_CD_DB.ptWdthL_CD = mtrOv_CD.ptWdthL as? NSDecimalNumber				mtrOv_CD_DB.ptWdthR_CD = mtrOv_CD.ptWdthR as? NSDecimalNumber				mtrOv_CD_DB.ptTrnRad_CD = mtrOv_CD.ptTrnRad				mtrOv_CD_DB.ptTrnDir_CD = mtrOv_CD.ptTrnDir				mtrOv_CD_DB.ptBiSec_CD = mtrOv_CD.ptBiSec as? NSDecimalNumber				mtrOv_CD_DB.nxPoint_CD = mtrOv_CD.nxPoint				mtrOv_CD_DB.nxUsage_CD = mtrOv_CD.nxUsage				mtrOv_CD_DB.nxLat_CD = mtrOv_CD.nxLat				mtrOv_CD_DB.nxDlat_CD = mtrOv_CD.nxDlat as? NSDecimalNumber				mtrOv_CD_DB.nxLong_CD = mtrOv_CD.nxLong				mtrOv_CD_DB.nxDlong_CD = mtrOv_CD.nxDlong as? NSDecimalNumber				mtrOv_CD_DB.nxWdthL_CD = mtrOv_CD.nxWdthL as? NSDecimalNumber				mtrOv_CD_DB.nxWdthR_CD = mtrOv_CD.nxWdthR as? NSDecimalNumber				mtrOv_CD_DB.nxTrnRad_CD = mtrOv_CD.nxTrnRad				mtrOv_CD_DB.nxTrnDir_CD = mtrOv_CD.nxTrnDir				mtrOv_CD_DB.nxBiSec_CD = mtrOv_CD.nxBiSec as? NSDecimalNumber				mtrOv_CD_DB.cycleDate_CD = mtrOv_CD.cycleDate as? NSDecimalNumber
				tempArray.append(mtrOv_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteMtrOv_CDFromDB(moc: NSManagedObjectContext) {
		let deleteMtrOv_CD = NSBatchDeleteRequest(fetchRequest: MtrOv_CD.fetchRequest())
		do {
			try moc.execute(deleteMtrOv_CD)
			try moc.save()
			print("All MtrOv_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllMtrOv_CD(moc: NSManagedObjectContext) -> [MtrOv_CD] {
		var mtrOv_CD = [MtrOv_CD]()
		let mtrOv_CDFetchRequest = NSFetchRequest<MtrOv_CD>(entityName: "MtrOv_CD")
		do {
			mtrOv_CD = try moc.fetch(mtrOv_CDFetchRequest)
		} catch {
			print(error)
		}
		return mtrOv_CD
	}
}