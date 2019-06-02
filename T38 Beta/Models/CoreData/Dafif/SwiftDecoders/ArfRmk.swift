
import Foundation

struct ArfRmk: Codable {
	let arfIdent: String? 	let direction: String? 	let rmkSeq: Double? 	let icao: String? 	let remarks: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arfIdent = "ARF_IDENT"		case direction = "DIRECTION"		case rmkSeq = "RMK_SEQ"		case icao = "ICAO"		case remarks = "REMARKS"		case cycleDate = "CYCLE_DATE"
}
}