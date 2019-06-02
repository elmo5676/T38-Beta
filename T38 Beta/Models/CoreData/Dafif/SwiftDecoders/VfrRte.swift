
import Foundation

struct VfrRte: Codable {
	let heliIdent: String? 	let heliName: String? 	let ctry: String? 	let stateProv: String? 	let icao: String? 	let faaHostId: String? 	let wgsDatum: String? 	let wgsLat: String? 	let rpWgsDlat: Double? 	let wgsLong: String? 	let rpWgsDlong: Double? 	let elev: Double? 	let magVar: String? 	let cityCrossRef: String? 	let locHdatum: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case heliIdent = "HELI_IDENT"		case heliName = "HELI_NAME"		case ctry = "CTRY"		case stateProv = "STATE_PROV"		case icao = "ICAO"		case faaHostId = "FAA_HOST_ID"		case wgsDatum = "WGS_DATUM"		case wgsLat = "WGS_LAT"		case rpWgsDlat = "RP_WGS_DLAT"		case wgsLong = "WGS_LONG"		case rpWgsDlong = "RP_WGS_DLONG"		case elev = "ELEV"		case magVar = "MAG_VAR"		case cityCrossRef = "CITY_CROSS_REF"		case locHdatum = "LOC_HDATUM"		case cycleDate = "CYCLE_DATE"
}
}