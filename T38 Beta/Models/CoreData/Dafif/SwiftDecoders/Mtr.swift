
import Foundation

struct Mtr: Codable {
	let mtrIdent: String? 	let ptIdent: String? 	let nxPoint: String? 	let icaoRegion: String? 	let crsaltDesc: String? 	let crsAlt1: String? 	let crsAlt2: String? 	let enraltDesc: String? 	let enrAlt1: String? 	let enrAlt2: String? 	let ptNavFlag: String? 	let navIdent: String? 	let navType: Double? 	let navCtry: String? 	let navKeyCd: Double? 	let bearing: Double? 	let distance: Double? 	let mtrWidthL: Double? 	let mtrWidthR: Double? 	let usageCd: String? 	let wgsLat: String? 	let wgsDlat: Double? 	let wgsLong: String? 	let wgsDlong: Double? 	let turnRad: String? 	let turnDir: String? 	let addInfo: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case mtrIdent = "MTR_IDENT"		case ptIdent = "PT_IDENT"		case nxPoint = "NX_POINT"		case icaoRegion = "ICAO_REGION"		case crsaltDesc = "CRSALT_DESC"		case crsAlt1 = "CRS_ALT1"		case crsAlt2 = "CRS_ALT2"		case enraltDesc = "ENRALT_DESC"		case enrAlt1 = "ENR_ALT1"		case enrAlt2 = "ENR_ALT2"		case ptNavFlag = "PT_NAV_FLAG"		case navIdent = "NAV_IDENT"		case navType = "NAV_TYPE"		case navCtry = "NAV_CTRY"		case navKeyCd = "NAV_KEY_CD"		case bearing = "BEARING"		case distance = "DISTANCE"		case mtrWidthL = "MTR_WIDTH_L"		case mtrWidthR = "MTR_WIDTH_R"		case usageCd = "USAGE_CD"		case wgsLat = "WGS_LAT"		case wgsDlat = "WGS_DLAT"		case wgsLong = "WGS_LONG"		case wgsDlong = "WGS_DLONG"		case turnRad = "TURN_RAD"		case turnDir = "TURN_DIR"		case addInfo = "ADD_INFO"		case cycleDate = "CYCLE_DATE"
}
}