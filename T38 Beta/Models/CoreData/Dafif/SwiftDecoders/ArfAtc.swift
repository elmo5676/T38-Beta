
import Foundation

struct ArfAtc: Codable {
	let arfIdent: String? 	let direction: String? 	let icao: String? 	let usage: String? 	let center: String? 	let cntrMult: Double? 	let freq1: String? 	let eW1: String? 	let freq2: String? 	let eW2: String? 	let freq3: String? 	let eW3: String? 	let freq4: String? 	let eW4: String? 	let freq5: String? 	let eW5: String? 	let atcRmk: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arfIdent = "ARF_IDENT"		case direction = "DIRECTION"		case icao = "ICAO"		case usage = "USAGE"		case center = "CENTER"		case cntrMult = "CNTR_MULT"		case freq1 = "FREQ1"		case eW1 = "E_W1"		case freq2 = "FREQ2"		case eW2 = "E_W2"		case freq3 = "FREQ3"		case eW3 = "E_W3"		case freq4 = "FREQ4"		case eW4 = "E_W4"		case freq5 = "FREQ5"		case eW5 = "E_W5"		case atcRmk = "ATC_RMK"		case cycleDate = "CYCLE_DATE"
}
}