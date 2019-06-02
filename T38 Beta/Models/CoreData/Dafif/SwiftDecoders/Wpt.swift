
import Foundation

struct Wpt: Codable {
	let wptIdent: String? 	let ctry: String? 	let stateProv: Double? 	let wptNavFlag: String? 	let type: String? 	let desc: String? 	let icao: String? 	let usageCd: String? 	let bearing: Double? 	let distance: Double? 	let wac: Double? 	let locHdatum: String? 	let wgsDatum: String? 	let wgsLat: String? 	let wgsDlat: Double? 	let wgsLong: String? 	let wgsDlong: Double? 	let magVar: String? 	let navIdent: String? 	let navType: Double? 	let navCtry: String? 	let navKeyCd: Double? 	let cycleDate: Double? 	let wptRvsm: String? 	let rwyId: String? 	let rwyIcao: String? 


	enum CodingKeys: String, CodingKey {
		case wptIdent = "WPT_IDENT"		case ctry = "CTRY"		case stateProv = "STATE_PROV"		case wptNavFlag = "WPT_NAV_FLAG"		case type = "TYPE"		case desc = "DESC"		case icao = "ICAO"		case usageCd = "USAGE_CD"		case bearing = "BEARING"		case distance = "DISTANCE"		case wac = "WAC"		case locHdatum = "LOC_HDATUM"		case wgsDatum = "WGS_DATUM"		case wgsLat = "WGS_LAT"		case wgsDlat = "WGS_DLAT"		case wgsLong = "WGS_LONG"		case wgsDlong = "WGS_DLONG"		case magVar = "MAG_VAR"		case navIdent = "NAV_IDENT"		case navType = "NAV_TYPE"		case navCtry = "NAV_CTRY"		case navKeyCd = "NAV_KEY_CD"		case cycleDate = "CYCLE_DATE"		case wptRvsm = "WPT_RVSM"		case rwyId = "RWY_ID"		case rwyIcao = "RWY_ICAO"
}
}