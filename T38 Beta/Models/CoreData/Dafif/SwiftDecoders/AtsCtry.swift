
import Foundation

struct AtsCtry: Codable {
	let atsIdent: String? 	let seqNbr: Double? 	let direction: String? 	let type: String? 	let icao: String? 	let ctry: String? 	let stateProv: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case atsIdent = "ATS_IDENT"		case seqNbr = "SEQ_NBR"		case direction = "DIRECTION"		case type = "TYPE"		case icao = "ICAO"		case ctry = "CTRY"		case stateProv = "STATE_PROV"		case cycleDate = "CYCLE_DATE"
}
}