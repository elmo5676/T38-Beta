
import Foundation

struct SuasPar: Codable {
	let suasIdent: String? 	let sector: String? 	let type: String? 	let name: String? 	let icao: String? 	let conAgcy: String? 	let locHdatum: String? 	let wgsDatum: String? 	let commName: String? 	let freq1: String? 	let freq2: String? 	let level: String? 	let upperAlt: String? 	let lowerAlt: String? 	let effTimes: String? 	let wx: String? 	let cycleDate: Double? 	let effDate: String? 


	enum CodingKeys: String, CodingKey {
		case suasIdent = "SUAS_IDENT"		case sector = "SECTOR"		case type = "TYPE"		case name = "NAME"		case icao = "ICAO"		case conAgcy = "CON_AGCY"		case locHdatum = "LOC_HDATUM"		case wgsDatum = "WGS_DATUM"		case commName = "COMM_NAME"		case freq1 = "FREQ1"		case freq2 = "FREQ2"		case level = "LEVEL"		case upperAlt = "UPPER_ALT"		case lowerAlt = "LOWER_ALT"		case effTimes = "EFF_TIMES"		case wx = "WX"		case cycleDate = "CYCLE_DATE"		case effDate = "EFF_DATE"
}
}