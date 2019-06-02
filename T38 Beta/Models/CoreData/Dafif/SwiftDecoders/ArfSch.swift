
import Foundation

struct ArfSch: Codable {
	let arfIdent: String? 	let direction: String? 	let icao: String? 	let schUnit: String? 	let dsn: String? 	let comNo: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arfIdent = "ARF_IDENT"		case direction = "DIRECTION"		case icao = "ICAO"		case schUnit = "SCH_UNIT"		case dsn = "DSN"		case comNo = "COM_NO"		case cycleDate = "CYCLE_DATE"
}
}