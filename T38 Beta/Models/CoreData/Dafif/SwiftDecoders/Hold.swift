
import Foundation

struct Hold: Codable {
	let wptId: String? 	let wptCtry: String? 	let icao: String? 	let dup: Double? 	let inbCrs: Double? 	let turnDir: String? 	let length: Double? 	let time: String? 	let altOne: String? 	let altTwo: String? 	let speed: String? 	let trackCd: String? 	let navIdent: String? 	let navType: String? 	let navCtry: String? 	let navKeyCd: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case wptId = "WPT_ID"		case wptCtry = "WPT_CTRY"		case icao = "ICAO"		case dup = "DUP"		case inbCrs = "INB_CRS"		case turnDir = "TURN_DIR"		case length = "LENGTH"		case time = "TIME"		case altOne = "ALT_ONE"		case altTwo = "ALT_TWO"		case speed = "SPEED"		case trackCd = "TRACK_CD"		case navIdent = "NAV_IDENT"		case navType = "NAV_TYPE"		case navCtry = "NAV_CTRY"		case navKeyCd = "NAV_KEY_CD"		case cycleDate = "CYCLE_DATE"
}
}