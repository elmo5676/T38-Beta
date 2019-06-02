

import Foundation
import CoreData


struct GenCDU {


	func loadGenToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/SUPP_GEN.json")

		do {
			let results = try decoder.decode([Gen].self, from: Data(contentsOf: fileName))
			_ = results.map { (gen_CD) -> Gen_CD in
				let gen_CD_DB = Gen_CD(context: moc)
				gen_CD_DB.arptIdent_CD = gen_CD.arptIdent				gen_CD_DB.icao_CD = gen_CD.icao				gen_CD_DB.altName_CD = gen_CD.altName				gen_CD_DB.cityCrossRef_CD = gen_CD.cityCrossRef				gen_CD_DB.islGroup_CD = gen_CD.islGroup				gen_CD_DB.notam_CD = gen_CD.notam				gen_CD_DB.oprHrs_CD = gen_CD.oprHrs				gen_CD_DB.clearStatus_CD = gen_CD.clearStatus				gen_CD_DB.utmGrid_CD = gen_CD.utmGrid				gen_CD_DB.time_CD = gen_CD.time				gen_CD_DB.daylightSave_CD = gen_CD.daylightSave				gen_CD_DB.flipPub_CD = gen_CD.flipPub				gen_CD_DB.cycleDate_CD = gen_CD.cycleDate as? NSDecimalNumber
				return gen_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteGen_CDFromDB(moc: NSManagedObjectContext) {
		let deleteGen_CD = NSBatchDeleteRequest(fetchRequest: Gen_CD.fetchRequest())
		do {
			try moc.execute(deleteGen_CD)
			try moc.save()
			print("All Gen_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllGen_CD(moc: NSManagedObjectContext) -> [Gen_CD] {
		var gen_CD = [Gen_CD]()
		let gen_CDFetchRequest = NSFetchRequest<Gen_CD>(entityName: "Gen_CD")
		do {
			gen_CD = try moc.fetch(gen_CDFetchRequest)
		} catch {
			print(error)
		}
		return gen_CD
	}
}