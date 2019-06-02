

import Foundation
import CoreData


struct BdryParCDU {


	func loadBdryParToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/BDRY_BDRY_PAR.json")

		do {
			let results = try decoder.decode([BdryPar].self, from: Data(contentsOf: fileName))
			_ = results.map { (bdryPar_CD) -> BdryPar_CD in
				let bdryPar_CD_DB = BdryPar_CD(context: moc)
				bdryPar_CD_DB.bdryIdent_CD = bdryPar_CD.bdryIdent
				bdryPar_CD_DB.type_CD = bdryPar_CD.type as? NSDecimalNumber
				bdryPar_CD_DB.name_CD = bdryPar_CD.name
				bdryPar_CD_DB.icao_CD = bdryPar_CD.icao
				bdryPar_CD_DB.conAuth_CD = bdryPar_CD.conAuth
				bdryPar_CD_DB.locHdatum_CD = bdryPar_CD.locHdatum
				bdryPar_CD_DB.wgsDatum_CD = bdryPar_CD.wgsDatum
				bdryPar_CD_DB.commName_CD = bdryPar_CD.commName
				bdryPar_CD_DB.commFreq1_CD = bdryPar_CD.commFreq1
				bdryPar_CD_DB.commFreq2_CD = bdryPar_CD.commFreq2
				bdryPar_CD_DB.class_CD = bdryPar_CD.classs
				bdryPar_CD_DB.classExc_CD = bdryPar_CD.classExc
				bdryPar_CD_DB.classExRmk_CD = bdryPar_CD.classExRmk
				bdryPar_CD_DB.level_CD = bdryPar_CD.level
				bdryPar_CD_DB.upperAlt_CD = bdryPar_CD.upperAlt
				bdryPar_CD_DB.lowerAlt_CD = bdryPar_CD.lowerAlt
				bdryPar_CD_DB.rnp_CD = bdryPar_CD.rnp as? NSDecimalNumber
				bdryPar_CD_DB.cycleDate_CD = bdryPar_CD.cycleDate as? NSDecimalNumber
				bdryPar_CD_DB.upRvsm_CD = bdryPar_CD.upRvsm
				bdryPar_CD_DB.loRvsm_CD = bdryPar_CD.loRvsm
				return bdryPar_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteBdryPar_CDFromDB(moc: NSManagedObjectContext) {
		let deleteBdryPar_CD = NSBatchDeleteRequest(fetchRequest: BdryPar_CD.fetchRequest())
		do {
			try moc.execute(deleteBdryPar_CD)
			try moc.save()
			print("All BdryPar_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllBdryPar_CD(moc: NSManagedObjectContext) -> [BdryPar_CD] {
		var bdryPar_CD = [BdryPar_CD]()
		let bdryPar_CDFetchRequest = NSFetchRequest<BdryPar_CD>(entityName: "BdryPar_CD")
		do {
			bdryPar_CD = try moc.fetch(bdryPar_CDFetchRequest)
		} catch {
			print(error)
		}
		return bdryPar_CD
	}
}
