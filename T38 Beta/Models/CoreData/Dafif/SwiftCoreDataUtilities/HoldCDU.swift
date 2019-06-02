

import Foundation
import CoreData


struct HoldCDU {


	func loadHoldToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/HOLD_HOLD.json")

		do {
			let results = try decoder.decode([Hold].self, from: Data(contentsOf: fileName))
			_ = results.map { (hold_CD) -> Hold_CD in
				let hold_CD_DB = Hold_CD(context: moc)
				hold_CD_DB.wptId_CD = hold_CD.wptId				hold_CD_DB.wptCtry_CD = hold_CD.wptCtry				hold_CD_DB.icao_CD = hold_CD.icao				hold_CD_DB.dup_CD = hold_CD.dup as? NSDecimalNumber				hold_CD_DB.inbCrs_CD = hold_CD.inbCrs as? NSDecimalNumber				hold_CD_DB.turnDir_CD = hold_CD.turnDir				hold_CD_DB.length_CD = hold_CD.length as? NSDecimalNumber				hold_CD_DB.time_CD = hold_CD.time				hold_CD_DB.altOne_CD = hold_CD.altOne				hold_CD_DB.altTwo_CD = hold_CD.altTwo				hold_CD_DB.speed_CD = hold_CD.speed				hold_CD_DB.trackCd_CD = hold_CD.trackCd				hold_CD_DB.navIdent_CD = hold_CD.navIdent				hold_CD_DB.navType_CD = hold_CD.navType				hold_CD_DB.navCtry_CD = hold_CD.navCtry				hold_CD_DB.navKeyCd_CD = hold_CD.navKeyCd				hold_CD_DB.cycleDate_CD = hold_CD.cycleDate as? NSDecimalNumber
				return hold_CD_DB
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteHold_CDFromDB(moc: NSManagedObjectContext) {
		let deleteHold_CD = NSBatchDeleteRequest(fetchRequest: Hold_CD.fetchRequest())
		do {
			try moc.execute(deleteHold_CD)
			try moc.save()
			print("All Hold_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllHold_CD(moc: NSManagedObjectContext) -> [Hold_CD] {
		var hold_CD = [Hold_CD]()
		let hold_CDFetchRequest = NSFetchRequest<Hold_CD>(entityName: "Hold_CD")
		do {
			hold_CD = try moc.fetch(hold_CDFetchRequest)
		} catch {
			print(error)
		}
		return hold_CD
	}
}