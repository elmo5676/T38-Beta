
import Foundation

struct VfrRteSeg: Codable {
	let heliIdent: String? 	let rteIdent: Double? 	let segNbr: Double? 	let rteName: String? 	let ptName: String? 	let ptIdentity: String? 	let ptWgsLat: String? 	let ptWgsDlat: Double? 	let ptWgsLong: String? 	let ptWgsDlong: Double? 	let utmGrid: String? 	let ptLatOffR: String? 	let ptDlatOffR: String? 	let ptLongOffR: String? 	let ptDlongOffR: String? 	let ptLatOffL: String? 	let ptDlatOffL: String? 	let ptLongOffL: String? 	let ptDlongOffL: String? 	let ptType: String? 	let ptSym: String? 	let atHeli: String? 	let segName: String? 	let magCrs: String? 	let pathCode: String? 	let altDesc: String? 	let alt: Double? 	let turnDir: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case heliIdent = "HELI_IDENT"		case rteIdent = "RTE_IDENT"		case segNbr = "SEG_NBR"		case rteName = "RTE_NAME"		case ptName = "PT_NAME"		case ptIdentity = "PT_IDENTITY"		case ptWgsLat = "PT_WGS_LAT"		case ptWgsDlat = "PT_WGS_DLAT"		case ptWgsLong = "PT_WGS_LONG"		case ptWgsDlong = "PT_WGS_DLONG"		case utmGrid = "UTM_GRID"		case ptLatOffR = "PT_LAT_OFF_R"		case ptDlatOffR = "PT_DLAT_OFF_R"		case ptLongOffR = "PT_LONG_OFF_R"		case ptDlongOffR = "PT_DLONG_OFF_R"		case ptLatOffL = "PT_LAT_OFF_L"		case ptDlatOffL = "PT_DLAT_OFF_L"		case ptLongOffL = "PT_LONG_OFF_L"		case ptDlongOffL = "PT_DLONG_OFF_L"		case ptType = "PT_TYPE"		case ptSym = "PT_SYM"		case atHeli = "AT_HELI"		case segName = "SEG_NAME"		case magCrs = "MAG_CRS"		case pathCode = "PATH_CODE"		case altDesc = "ALT_DESC"		case alt = "ALT"		case turnDir = "TURN_DIR"		case cycleDate = "CYCLE_DATE"
}
}