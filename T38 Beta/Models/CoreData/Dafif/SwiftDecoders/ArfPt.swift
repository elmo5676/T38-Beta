
import Foundation

struct ArfPt: Codable {
	let arfIdent: String? 	let direction: String? 	let ptSeqNbr: Double? 	let icao: String? 	let usage: String? 	let ptNavFlag: String? 	let navIdent: String? 	let navType: String? 	let navCtry: String? 	let navKeyCd: String? 	let bearing: String? 	let distance: String? 	let wgsLat: String? 	let wgsDlat: Double? 	let wgsLong: String? 	let wgsDlong: Double? 	let cycleDate: Double? 	let ptIdent: String? 


	enum CodingKeys: String, CodingKey {
		case arfIdent = "ARF_IDENT"		case direction = "DIRECTION"		case ptSeqNbr = "PT_SEQ_NBR"		case icao = "ICAO"		case usage = "USAGE"		case ptNavFlag = "PT_NAV_FLAG"		case navIdent = "NAV_IDENT"		case navType = "NAV_TYPE"		case navCtry = "NAV_CTRY"		case navKeyCd = "NAV_KEY_CD"		case bearing = "BEARING"		case distance = "DISTANCE"		case wgsLat = "WGS_LAT"		case wgsDlat = "WGS_DLAT"		case wgsLong = "WGS_LONG"		case wgsDlong = "WGS_DLONG"		case cycleDate = "CYCLE_DATE"		case ptIdent = "PT_IDENT"
}
}