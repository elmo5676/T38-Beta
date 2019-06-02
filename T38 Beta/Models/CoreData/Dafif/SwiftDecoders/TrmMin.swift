
import Foundation

struct TrmMin: Codable {
	let arptIdent: String? 	let proc: Double? 	let trmIdent: String? 	let appType: String? 	let icao: String? 	let catADh: Double? 	let catARv: String? 	let catAHa: Double? 	let catAWxCl: Double? 	let catAWxPv: String? 	let catBDh: Double? 	let catBRv: String? 	let catBHa: Double? 	let catBWxCl: Double? 	let catBWxPv: String? 	let catCDh: Double? 	let catCRv: String? 	let catCHa: Double? 	let catCWxCl: Double? 	let catCWxPv: String? 	let catDDh: Double? 	let catDRv: String? 	let catDHa: Double? 	let catDWxCl: Double? 	let catDWxPv: String? 	let catEDh: String? 	let catERv: String? 	let catEHa: String? 	let catEWxCl: String? 	let catEWxPv: String? 	let minRmk: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arptIdent = "ARPT_IDENT"		case proc = "PROC"		case trmIdent = "TRM_IDENT"		case appType = "APP_TYPE"		case icao = "ICAO"		case catADh = "CAT_A_DH"		case catARv = "CAT_A_RV"		case catAHa = "CAT_A_HA"		case catAWxCl = "CAT_A_WX_CL"		case catAWxPv = "CAT_A_WX_PV"		case catBDh = "CAT_B_DH"		case catBRv = "CAT_B_RV"		case catBHa = "CAT_B_HA"		case catBWxCl = "CAT_B_WX_CL"		case catBWxPv = "CAT_B_WX_PV"		case catCDh = "CAT_C_DH"		case catCRv = "CAT_C_RV"		case catCHa = "CAT_C_HA"		case catCWxCl = "CAT_C_WX_CL"		case catCWxPv = "CAT_C_WX_PV"		case catDDh = "CAT_D_DH"		case catDRv = "CAT_D_RV"		case catDHa = "CAT_D_HA"		case catDWxCl = "CAT_D_WX_CL"		case catDWxPv = "CAT_D_WX_PV"		case catEDh = "CAT_E_DH"		case catERv = "CAT_E_RV"		case catEHa = "CAT_E_HA"		case catEWxCl = "CAT_E_WX_CL"		case catEWxPv = "CAT_E_WX_PV"		case minRmk = "MIN_RMK"		case cycleDate = "CYCLE_DATE"
}
}