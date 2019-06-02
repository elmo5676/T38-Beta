
import Foundation

struct Gen: Codable {
	let arptIdent: String? 	let icao: String? 	let altName: String? 	let cityCrossRef: String? 	let islGroup: String? 	let notam: String? 	let oprHrs: String? 	let clearStatus: String? 	let utmGrid: String? 	let time: String? 	let daylightSave: String? 	let flipPub: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case arptIdent = "ARPT_IDENT"		case icao = "ICAO"		case altName = "ALT_NAME"		case cityCrossRef = "CITY_CROSS_REF"		case islGroup = "ISL_GROUP"		case notam = "NOTAM"		case oprHrs = "OPR_HRS"		case clearStatus = "CLEAR_STATUS"		case utmGrid = "UTM_GRID"		case time = "TIME"		case daylightSave = "DAYLIGHT_SAVE"		case flipPub = "FLIP_PUB"		case cycleDate = "CYCLE_DATE"
}
}