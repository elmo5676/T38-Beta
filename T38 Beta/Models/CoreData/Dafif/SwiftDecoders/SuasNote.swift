
import Foundation

struct SuasNote: Codable {
	let suasIdent: String? 	let sector: String? 	let noteType: String? 	let noteNbr: Double? 	let remarks: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case suasIdent = "SUAS_IDENT"		case sector = "SECTOR"		case noteType = "NOTE_TYPE"		case noteNbr = "NOTE_NBR"		case remarks = "REMARKS"		case cycleDate = "CYCLE_DATE"
}
}