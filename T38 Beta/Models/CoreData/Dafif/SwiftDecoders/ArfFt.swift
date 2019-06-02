
import Foundation

struct ArfFt: Codable {
	let arfIdent: String? 	let direction: String? 	let icao: String? 	let ftType: String? 	let ftNo: Double? 	let rmkSeq: Double? 	let remarks: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arfIdent = "ARF_IDENT"		case direction = "DIRECTION"		case icao = "ICAO"		case ftType = "FT_TYPE"		case ftNo = "FT_NO"		case rmkSeq = "RMK_SEQ"		case remarks = "REMARKS"		case cycleDate = "CYCLE_DATE"
}
}