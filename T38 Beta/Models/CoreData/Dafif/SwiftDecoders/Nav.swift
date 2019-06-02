
import Foundation

struct Nav: Codable {
	let navIdent: String? 	let type: Double? 	let ctry: String? 	let navKeyCd: Double? 	let stateProv: String? 	let name: String? 	let icao: String? 	let wac: Double? 	let freq: String? 	let usageCd: String? 	let chan: String? 	let rcc: String? 	let freqProt: String? 	let power: String? 	let navRange: String? 	let locHdatum: String? 	let wgsDatum: String? 	let wgsLat: String? 	let wgsDlat: Double? 	let wgsLong: String? 	let wgsDlong: Double? 	let slavedVar: String? 	let magVar: String? 	let elev: Double? 	let dmeWgsLat: String? 	let dmeWgsDlat: String? 	let dmeWgsLong: String? 	let dmeWgsDlong: String? 	let dmeElev: String? 	let arptIcao: String? 	let os: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case navIdent = "NAV_IDENT"		case type = "TYPE"		case ctry = "CTRY"		case navKeyCd = "NAV_KEY_CD"		case stateProv = "STATE_PROV"		case name = "NAME"		case icao = "ICAO"		case wac = "WAC"		case freq = "FREQ"		case usageCd = "USAGE_CD"		case chan = "CHAN"		case rcc = "RCC"		case freqProt = "FREQ_PROT"		case power = "POWER"		case navRange = "NAV_RANGE"		case locHdatum = "LOC_HDATUM"		case wgsDatum = "WGS_DATUM"		case wgsLat = "WGS_LAT"		case wgsDlat = "WGS_DLAT"		case wgsLong = "WGS_LONG"		case wgsDlong = "WGS_DLONG"		case slavedVar = "SLAVED_VAR"		case magVar = "MAG_VAR"		case elev = "ELEV"		case dmeWgsLat = "DME_WGS_LAT"		case dmeWgsDlat = "DME_WGS_DLAT"		case dmeWgsLong = "DME_WGS_LONG"		case dmeWgsDlong = "DME_WGS_DLONG"		case dmeElev = "DME_ELEV"		case arptIcao = "ARPT_ICAO"		case os = "OS"		case cycleDate = "CYCLE_DATE"
}
}