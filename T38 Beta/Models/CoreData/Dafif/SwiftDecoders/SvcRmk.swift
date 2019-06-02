
import Foundation

struct SvcRmk: Codable {
	let arptIdent: String? 	let type: String? 	let rmkSeq: Double? 	let icao: String? 	let remarks: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arptIdent = "ARPT_IDENT"		case type = "TYPE"		case rmkSeq = "RMK_SEQ"		case icao = "ICAO"		case remarks = "REMARKS"		case cycleDate = "CYCLE_DATE"
}
}