
import Foundation

struct Ortca: Codable {
	let ortcaIdent: Double? 	let alt: Double? 	let nwLat: String? 	let nwDlat: Double? 	let nwLong: String? 	let nwDlong: Double? 	let neLat: String? 	let neDlat: Double? 	let neLong: String? 	let neDlong: Double? 	let swLat: String? 	let swDlat: Double? 	let swLong: String? 	let swDlong: Double? 	let seLat: String? 	let seDlat: Double? 	let seLong: String? 	let seDlong: Double? 	let cycleDate: Double? 	let ortcaId: Double? 


	enum CodingKeys: String, CodingKey {
		case ortcaIdent = "ORTCA_IDENT"		case alt = "ALT"		case nwLat = "NW_LAT"		case nwDlat = "NW_DLAT"		case nwLong = "NW_LONG"		case nwDlong = "NW_DLONG"		case neLat = "NE_LAT"		case neDlat = "NE_DLAT"		case neLong = "NE_LONG"		case neDlong = "NE_DLONG"		case swLat = "SW_LAT"		case swDlat = "SW_DLAT"		case swLong = "SW_LONG"		case swDlong = "SW_DLONG"		case seLat = "SE_LAT"		case seDlat = "SE_DLAT"		case seLong = "SE_LONG"		case seDlong = "SE_DLONG"		case cycleDate = "CYCLE_DATE"		case ortcaId = "ORTCA_ID"
}
}