
import Foundation

struct Bdry: Codable {
	let bdryIdent: String? 	let segNbr: Double? 	let name: String? 	let type: Double? 	let icao: String? 	let shap: String? 	let derivation: String? 	let wgsLat1: String? 	let wgsDlat1: Double? 	let wgsLong1: String? 	let wgsDlong1: Double? 	let wgsLat2: String? 	let wgsDlat2: Double? 	let wgsLong2: String? 	let wgsDlong2: Double? 	let wgsLat0: String? 	let wgsDlat0: String? 	let wgsLong0: String? 	let wgsDlong0: String? 	let radius1: String? 	let radius2: String? 	let bearing1: String? 	let bearing2: String? 	let navIdent: String? 	let navType: String? 	let navCtry: String? 	let navKeyCd: String? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case bdryIdent = "BDRY_IDENT"		case segNbr = "SEG_NBR"		case name = "NAME"		case type = "TYPE"		case icao = "ICAO"		case shap = "SHAP"		case derivation = "DERIVATION"		case wgsLat1 = "WGS_LAT1"		case wgsDlat1 = "WGS_DLAT1"		case wgsLong1 = "WGS_LONG1"		case wgsDlong1 = "WGS_DLONG1"		case wgsLat2 = "WGS_LAT2"		case wgsDlat2 = "WGS_DLAT2"		case wgsLong2 = "WGS_LONG2"		case wgsDlong2 = "WGS_DLONG2"		case wgsLat0 = "WGS_LAT0"		case wgsDlat0 = "WGS_DLAT0"		case wgsLong0 = "WGS_LONG0"		case wgsDlong0 = "WGS_DLONG0"		case radius1 = "RADIUS1"		case radius2 = "RADIUS2"		case bearing1 = "BEARING1"		case bearing2 = "BEARING2"		case navIdent = "NAV_IDENT"		case navType = "NAV_TYPE"		case navCtry = "NAV_CTRY"		case navKeyCd = "NAV_KEY_CD"		case cycleDate = "CYCLE_DATE"
}
}