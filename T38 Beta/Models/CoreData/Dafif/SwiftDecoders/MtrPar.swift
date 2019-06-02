
import Foundation

struct MtrPar: Codable {
	let mtrIdent: String? 	let origAct: String? 	let schAct: String? 	let icaoRegion: String? 	let ctry: String? 	let locHdatum: String? 	let wgsDatum: String? 	let effTimes: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case mtrIdent = "MTR_IDENT"		case origAct = "ORIG_ACT"		case schAct = "SCH_ACT"		case icaoRegion = "ICAO_REGION"		case ctry = "CTRY"		case locHdatum = "LOC_HDATUM"		case wgsDatum = "WGS_DATUM"		case effTimes = "EFF_TIMES"		case cycleDate = "CYCLE_DATE"
}
}