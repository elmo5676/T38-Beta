
import Foundation

struct ArfPar: Codable {
	let arfIdent: String? 	let direction: String? 	let icao: String? 	let type: String? 	let ctry: String? 	let locHdatum: String? 	let wgsDatum: String? 	let priFreq: Double? 	let bkpFreq: Double? 	let apnCode: String? 	let apxCode: String? 	let receiver: String? 	let tanker: String? 	let alt1Desc: String? 	let refuel1Alt1: String? 	let refuel1Alt2: String? 	let alt2Desc: String? 	let refuel2Alt1: String? 	let refuel2Alt2: String? 	let alt3Desc: String? 	let refuel3Alt1: String? 	let refuel3Alt2: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arfIdent = "ARF_IDENT"		case direction = "DIRECTION"		case icao = "ICAO"		case type = "TYPE"		case ctry = "CTRY"		case locHdatum = "LOC_HDATUM"		case wgsDatum = "WGS_DATUM"		case priFreq = "PRI_FREQ"		case bkpFreq = "BKP_FREQ"		case apnCode = "APN_CODE"		case apxCode = "APX_CODE"		case receiver = "RECEIVER"		case tanker = "TANKER"		case alt1Desc = "ALT1_DESC"		case refuel1Alt1 = "REFUEL1_ALT1"		case refuel1Alt2 = "REFUEL1_ALT2"		case alt2Desc = "ALT2_DESC"		case refuel2Alt1 = "REFUEL2_ALT1"		case refuel2Alt2 = "REFUEL2_ALT2"		case alt3Desc = "ALT3_DESC"		case refuel3Alt1 = "REFUEL3_ALT1"		case refuel3Alt2 = "REFUEL3_ALT2"		case cycleDate = "CYCLE_DATE"
}
}