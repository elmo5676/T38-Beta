
import Foundation

struct AtsRmk: Codable {
	let atsIdent: String? 	let seqNbr: Double? 	let direction: String? 	let type: String? 	let icao: String? 	let rmkSeq: Double? 	let remark: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case atsIdent = "ATS_IDENT"		case seqNbr = "SEQ_NBR"		case direction = "DIRECTION"		case type = "TYPE"		case icao = "ICAO"		case rmkSeq = "RMK_SEQ"		case remark = "REMARK"		case cycleDate = "CYCLE_DATE"
}
}