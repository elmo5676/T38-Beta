
import Foundation

struct TrmRmk: Codable {
	let arptIdent: String? 	let proc: Double? 	let trmIdent: String? 	let appType: String? 	let rmkSeq: Double? 	let icao: String? 	let remarks: String? 	let cycleDate: Double? 	let rmkType: String? 


	enum CodingKeys: String, CodingKey {
		case arptIdent = "ARPT_IDENT"		case proc = "PROC"		case trmIdent = "TRM_IDENT"		case appType = "APP_TYPE"		case rmkSeq = "RMK_SEQ"		case icao = "ICAO"		case remarks = "REMARKS"		case cycleDate = "CYCLE_DATE"		case rmkType = "RMK_TYPE"
}
}