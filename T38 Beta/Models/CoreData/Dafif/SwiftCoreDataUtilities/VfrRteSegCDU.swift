

import Foundation
import CoreData


struct VfrRteSegCDU {


	func loadVfrRteSegToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/VFR_VFR_RTE_SEG.json")

		do {
			let results = try decoder.decode([VfrRteSeg].self, from: Data(contentsOf: fileName))
			_ = results.map { (vfrRteSeg_CD) -> VfrRteSeg_CD in
				let vfrRteSeg_CD_DB = VfrRteSeg_CD(context: moc)
				vfrRteSeg_CD_DB.heliIdent_CD = vfrRteSeg_CD.heliIdent				vfrRteSeg_CD_DB.rteIdent_CD = vfrRteSeg_CD.rteIdent as? NSDecimalNumber				vfrRteSeg_CD_DB.segNbr_CD = vfrRteSeg_CD.segNbr as? NSDecimalNumber				vfrRteSeg_CD_DB.rteName_CD = vfrRteSeg_CD.rteName				vfrRteSeg_CD_DB.ptName_CD = vfrRteSeg_CD.ptName				vfrRteSeg_CD_DB.ptIdentity_CD = vfrRteSeg_CD.ptIdentity				vfrRteSeg_CD_DB.ptWgsLat_CD = vfrRteSeg_CD.ptWgsLat				vfrRteSeg_CD_DB.ptWgsDlat_CD = vfrRteSeg_CD.ptWgsDlat as? NSDecimalNumber				vfrRteSeg_CD_DB.ptWgsLong_CD = vfrRteSeg_CD.ptWgsLong				vfrRteSeg_CD_DB.ptWgsDlong_CD = vfrRteSeg_CD.ptWgsDlong as? NSDecimalNumber				vfrRteSeg_CD_DB.utmGrid_CD = vfrRteSeg_CD.utmGrid				vfrRteSeg_CD_DB.ptLatOffR_CD = vfrRteSeg_CD.ptLatOffR				vfrRteSeg_CD_DB.ptDlatOffR_CD = vfrRteSeg_CD.ptDlatOffR				vfrRteSeg_CD_DB.ptLongOffR_CD = vfrRteSeg_CD.ptLongOffR				vfrRteSeg_CD_DB.ptDlongOffR_CD = vfrRteSeg_CD.ptDlongOffR				vfrRteSeg_CD_DB.ptLatOffL_CD = vfrRteSeg_CD.ptLatOffL				vfrRteSeg_CD_DB.ptDlatOffL_CD = vfrRteSeg_CD.ptDlatOffL				vfrRteSeg_CD_DB.ptLongOffL_CD = vfrRteSeg_CD.ptLongOffL				vfrRteSeg_CD_DB.ptDlongOffL_CD = vfrRteSeg_CD.ptDlongOffL				vfrRteSeg_CD_DB.ptType_CD = vfrRteSeg_CD.ptType				vfrRteSeg_CD_DB.ptSym_CD = vfrRteSeg_CD.ptSym				vfrRteSeg_CD_DB.atHeli_CD = vfrRteSeg_CD.atHeli				vfrRteSeg_CD_DB.segName_CD = vfrRteSeg_CD.segName				vfrRteSeg_CD_DB.magCrs_CD = vfrRteSeg_CD.magCrs				vfrRteSeg_CD_DB.pathCode_CD = vfrRteSeg_CD.pathCode				vfrRteSeg_CD_DB.altDesc_CD = vfrRteSeg_CD.altDesc				vfrRteSeg_CD_DB.alt_CD = vfrRteSeg_CD.alt as? NSDecimalNumber				vfrRteSeg_CD_DB.turnDir_CD = vfrRteSeg_CD.turnDir				vfrRteSeg_CD_DB.cycleDate_CD = vfrRteSeg_CD.cycleDate as? NSDecimalNumber
				return vfrRteSeg_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteVfrRteSeg_CDFromDB(moc: NSManagedObjectContext) {
		let deleteVfrRteSeg_CD = NSBatchDeleteRequest(fetchRequest: VfrRteSeg_CD.fetchRequest())
		do {
			try moc.execute(deleteVfrRteSeg_CD)
			try moc.save()
			print("All VfrRteSeg_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllVfrRteSeg_CD(moc: NSManagedObjectContext) -> [VfrRteSeg_CD] {
		var vfrRteSeg_CD = [VfrRteSeg_CD]()
		let vfrRteSeg_CDFetchRequest = NSFetchRequest<VfrRteSeg_CD>(entityName: "VfrRteSeg_CD")
		do {
			vfrRteSeg_CD = try moc.fetch(vfrRteSeg_CDFetchRequest)
		} catch {
			print(error)
		}
		return vfrRteSeg_CD
	}
}