
import Foundation

struct TrmPar: Codable {
	let arptIdent: String? 	let proc: Double? 	let trmIdent: String? 	let icao: String? 	let esAlt: String? 	let julianDate: Double? 	let amdtNo: Double? 	let opr: String? 	let hostCtryAuth: String? 	let cycleDate: Double? 	let altMin: String? 	let tranAlt: Double? 	let tranLvl: Double? 	let rteTypeQual: String? 


	enum CodingKeys: String, CodingKey {
		case arptIdent = "ARPT_IDENT"		case proc = "PROC"		case trmIdent = "TRM_IDENT"		case icao = "ICAO"		case esAlt = "ES_ALT"		case julianDate = "JULIAN_DATE"		case amdtNo = "AMDT_NO"		case opr = "OPR"		case hostCtryAuth = "HOST_CTRY_AUTH"		case cycleDate = "CYCLE_DATE"		case altMin = "ALT_MIN"		case tranAlt = "TRAN_ALT"		case tranLvl = "TRAN_LVL"		case rteTypeQual = "RTE_TYPE_QUAL"
}
}