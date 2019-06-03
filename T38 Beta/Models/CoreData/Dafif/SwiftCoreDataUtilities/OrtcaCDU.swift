

import Foundation
import CoreData


struct OrtcaCDU {


	func loadOrtcaToCDfromJSON(moc: NSManagedObjectContext){
		let decoder = JSONDecoder()
		let fileName = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("DAFIF_JSON/ORTCA_ORTCA.json")
		var tempArray: [Ortca_CD] = []

		do {
			let results = try decoder.decode([Ortca].self, from: Data(contentsOf: fileName))
			for ortca_CD in results {
				let ortca_CD_DB = Ortca_CD(context: moc)
				ortca_CD_DB.ortcaIdent_CD = ortca_CD.ortcaIdent as? NSDecimalNumber				ortca_CD_DB.alt_CD = ortca_CD.alt as? NSDecimalNumber				ortca_CD_DB.nwLat_CD = ortca_CD.nwLat				ortca_CD_DB.nwDlat_CD = ortca_CD.nwDlat as? NSDecimalNumber				ortca_CD_DB.nwLong_CD = ortca_CD.nwLong				ortca_CD_DB.nwDlong_CD = ortca_CD.nwDlong as? NSDecimalNumber				ortca_CD_DB.neLat_CD = ortca_CD.neLat				ortca_CD_DB.neDlat_CD = ortca_CD.neDlat as? NSDecimalNumber				ortca_CD_DB.neLong_CD = ortca_CD.neLong				ortca_CD_DB.neDlong_CD = ortca_CD.neDlong as? NSDecimalNumber				ortca_CD_DB.swLat_CD = ortca_CD.swLat				ortca_CD_DB.swDlat_CD = ortca_CD.swDlat as? NSDecimalNumber				ortca_CD_DB.swLong_CD = ortca_CD.swLong				ortca_CD_DB.swDlong_CD = ortca_CD.swDlong as? NSDecimalNumber				ortca_CD_DB.seLat_CD = ortca_CD.seLat				ortca_CD_DB.seDlat_CD = ortca_CD.seDlat as? NSDecimalNumber				ortca_CD_DB.seLong_CD = ortca_CD.seLong				ortca_CD_DB.seDlong_CD = ortca_CD.seDlong as? NSDecimalNumber				ortca_CD_DB.cycleDate_CD = ortca_CD.cycleDate as? NSDecimalNumber				ortca_CD_DB.ortcaId_CD = ortca_CD.ortcaId as? NSDecimalNumber
				tempArray.append(ortca_CD_DB)
			}
			moc.performAndWait {
				do {
					try moc.save()
				} catch {
					print(error)
				}}
		} catch {print(error)}
	}


	func deleteOrtca_CDFromDB(moc: NSManagedObjectContext) {
		let deleteOrtca_CD = NSBatchDeleteRequest(fetchRequest: Ortca_CD.fetchRequest())
		do {
			try moc.execute(deleteOrtca_CD)
			try moc.save()
			print("All Ortca_CD were succesfully deleted from CoreData")
		} catch {
			print("Nope")
		}
	}


	func getAllOrtca_CD(moc: NSManagedObjectContext) -> [Ortca_CD] {
		var ortca_CD = [Ortca_CD]()
		let ortca_CDFetchRequest = NSFetchRequest<Ortca_CD>(entityName: "Ortca_CD")
		do {
			ortca_CD = try moc.fetch(ortca_CDFetchRequest)
		} catch {
			print(error)
		}
		return ortca_CD
	}
}