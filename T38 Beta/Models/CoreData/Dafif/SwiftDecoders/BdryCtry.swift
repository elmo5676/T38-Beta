
import Foundation

struct BdryCtry: Codable {
	let bdryIdent: String? 	let segNbr: Double? 	let ctry1: String? 	let ctry2: String? 	let ctry3: String? 	let ctry4: String? 	let ctry5: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case bdryIdent = "BDRY_IDENT"		case segNbr = "SEG_NBR"		case ctry1 = "CTRY_1"		case ctry2 = "CTRY_2"		case ctry3 = "CTRY_3"		case ctry4 = "CTRY_4"		case ctry5 = "CTRY_5"		case cycleDate = "CYCLE_DATE"
}
}