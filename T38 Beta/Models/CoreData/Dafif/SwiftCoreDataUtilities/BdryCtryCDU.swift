

import Foundation
import CoreData


struct BdryCtryCDU {


	func loadBdryCtryToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/BDRY_BDRY_CTRY.json")

		do {
			let results = try decoder.decode([BdryCtry].self, from: Data(contentsOf: fileName))
			_ = results.map { (bdryCtry_CD) -> BdryCtry_CD in
				let bdryCtry_CD_DB = BdryCtry_CD(context: moc)
				bdryCtry_CD_DB.bdryIdent_CD = bdryCtry_CD.bdryIdent				bdryCtry_CD_DB.segNbr_CD = bdryCtry_CD.segNbr as? NSDecimalNumber				bdryCtry_CD_DB.ctry1_CD = bdryCtry_CD.ctry1				bdryCtry_CD_DB.ctry2_CD = bdryCtry_CD.ctry2				bdryCtry_CD_DB.ctry3_CD = bdryCtry_CD.ctry3				bdryCtry_CD_DB.ctry4_CD = bdryCtry_CD.ctry4				bdryCtry_CD_DB.ctry5_CD = bdryCtry_CD.ctry5				bdryCtry_CD_DB.cycleDate_CD = bdryCtry_CD.cycleDate as? NSDecimalNumber
				return bdryCtry_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteBdryCtry_CDFromDB(moc: NSManagedObjectContext) {
		let deleteBdryCtry_CD = NSBatchDeleteRequest(fetchRequest: BdryCtry_CD.fetchRequest())
		do {
			try moc.execute(deleteBdryCtry_CD)
			try moc.save()
			print("All BdryCtry_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllBdryCtry_CD(moc: NSManagedObjectContext) -> [BdryCtry_CD] {
		var bdryCtry_CD = [BdryCtry_CD]()
		let bdryCtry_CDFetchRequest = NSFetchRequest<BdryCtry_CD>(entityName: "BdryCtry_CD")
		do {
			bdryCtry_CD = try moc.fetch(bdryCtry_CDFetchRequest)
		} catch {
			print(error)
		}
		return bdryCtry_CD
	}
}