
import Foundation

struct Fueloil: Codable {
	let arptIdent: String? 	let icao: String? 	let fuel: String? 	let oil: String? 	let jasu: String? 	let supFluids: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arptIdent = "ARPT_IDENT"		case icao = "ICAO"		case fuel = "FUEL"		case oil = "OIL"		case jasu = "JASU"		case supFluids = "SUP_FLUIDS"		case cycleDate = "CYCLE_DATE"
}
}