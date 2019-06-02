
import Foundation

struct VfrRteRmk: Codable {
	let heliIdent: String? 	let rmkSeq: Double? 	let remarks: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case heliIdent = "HELI_IDENT"		case rmkSeq = "RMK_SEQ"		case remarks = "REMARKS"		case cycleDate = "CYCLE_DATE"
}
}