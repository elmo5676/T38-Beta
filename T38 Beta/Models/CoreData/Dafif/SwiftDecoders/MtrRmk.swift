
import Foundation

struct MtrRmk: Codable {
	let mtrIdent: String? 	let rmkSeq: Double? 	let remarks: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case mtrIdent = "MTR_IDENT"		case rmkSeq = "RMK_SEQ"		case remarks = "REMARKS"		case cycleDate = "CYCLE_DATE"
}
}