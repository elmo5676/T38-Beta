
import Foundation

struct TrmClb: Codable {
	let arptIdent: String? 	let proc: Double? 	let trmIdent: String? 	let rwyId: Double? 	let occNo: Double? 	let icao: String? 	let desig: Double? 	let knots: Double? 	let rateDesc: Double? 	let alt: Double? 	let ftnote: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arptIdent = "ARPT_IDENT"		case proc = "PROC"		case trmIdent = "TRM_IDENT"		case rwyId = "RWY_ID"		case occNo = "OCC_NO"		case icao = "ICAO"		case desig = "DESIG"		case knots = "KNOTS"		case rateDesc = "RATE_DESC"		case alt = "ALT"		case ftnote = "FTNOTE"		case cycleDate = "CYCLE_DATE"
}
}