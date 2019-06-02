
import Foundation

struct SuasCtry: Codable {
	let suasIdent: String? 	let sector: String? 	let icao: String? 	let ctry1: String? 	let ctry2: String? 	let ctry3: String? 	let ctry4: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case suasIdent = "SUAS_IDENT"		case sector = "SECTOR"		case icao = "ICAO"		case ctry1 = "CTRY_1"		case ctry2 = "CTRY_2"		case ctry3 = "CTRY_3"		case ctry4 = "CTRY_4"		case cycleDate = "CYCLE_DATE"
}
}