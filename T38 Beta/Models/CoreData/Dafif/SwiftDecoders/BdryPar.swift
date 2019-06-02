
import Foundation

struct BdryPar: Codable {
	let bdryIdent: String? 	let type: Double? 	let name: String? 	let icao: String? 	let conAuth: String? 	let locHdatum: String? 	let wgsDatum: String? 	let commName: String? 	let commFreq1: String? 	let commFreq2: String? 	let classs: String? 	let classExc: String? 	let classExRmk: String? 	let level: String? 	let upperAlt: String? 	let lowerAlt: String? 	let rnp: Double? 	let cycleDate: Double? 	let upRvsm: String? 	let loRvsm: String? 


	enum CodingKeys: String, CodingKey {
		case bdryIdent = "BDRY_IDENT"		case type = "TYPE"		case name = "NAME"		case icao = "ICAO"		case conAuth = "CON_AUTH"		case locHdatum = "LOC_HDATUM"		case wgsDatum = "WGS_DATUM"		case commName = "COMM_NAME"		case commFreq1 = "COMM_FREQ1"		case commFreq2 = "COMM_FREQ2"		case classs = "CLASS"		case classExc = "CLASS_EXC"		case classExRmk = "CLASS_EX_RMK"		case level = "LEVEL"		case upperAlt = "UPPER_ALT"		case lowerAlt = "LOWER_ALT"		case rnp = "RNP"		case cycleDate = "CYCLE_DATE"		case upRvsm = "UP_RVSM"		case loRvsm = "LO_RVSM"
}
}