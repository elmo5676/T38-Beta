
import Foundation

struct Arpt: Codable {
	let arptIdent: String? 	let name: String? 	let stateProv: String? 	let icao: String? 	let faaHostId: String? 	let locHdatum: String? 	let wgsDatum: String? 	let wgsLat: String? 	let wgsDlat: Double? 	let wgsLong: String? 	let wgsDlong: Double? 	let elev: Double? 	let type: String? 	let magVar: String? 	let wac: Double? 	let beacon: String? 	let secondArpt: String? 	let oprAgy: String? 	let secName: String? 	let secIcao: String? 	let secFaa: String? 	let secOprAgy: String? 	let cycleDate: Double? 	let terrain: String? 	let hydro: String? 


	enum CodingKeys: String, CodingKey {
		case arptIdent = "ARPT_IDENT"		case name = "NAME"		case stateProv = "STATE_PROV"		case icao = "ICAO"		case faaHostId = "FAA_HOST_ID"		case locHdatum = "LOC_HDATUM"		case wgsDatum = "WGS_DATUM"		case wgsLat = "WGS_LAT"		case wgsDlat = "WGS_DLAT"		case wgsLong = "WGS_LONG"		case wgsDlong = "WGS_DLONG"		case elev = "ELEV"		case type = "TYPE"		case magVar = "MAG_VAR"		case wac = "WAC"		case beacon = "BEACON"		case secondArpt = "SECOND_ARPT"		case oprAgy = "OPR_AGY"		case secName = "SEC_NAME"		case secIcao = "SEC_ICAO"		case secFaa = "SEC_FAA"		case secOprAgy = "SEC_OPR_AGY"		case cycleDate = "CYCLE_DATE"		case terrain = "TERRAIN"		case hydro = "HYDRO"
}
}