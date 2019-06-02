
import Foundation

struct MtrOv: Codable {
	let mtrIdent: String? 	let segNbr: Double? 	let ptIdent: String? 	let ptUsage: String? 	let ptLat: String? 	let ptDlat: Double? 	let ptLong: String? 	let ptDlong: Double? 	let ptWdthL: Double? 	let ptWdthR: Double? 	let ptTrnRad: String? 	let ptTrnDir: String? 	let ptBiSec: Double? 	let nxPoint: String? 	let nxUsage: String? 	let nxLat: String? 	let nxDlat: Double? 	let nxLong: String? 	let nxDlong: Double? 	let nxWdthL: Double? 	let nxWdthR: Double? 	let nxTrnRad: String? 	let nxTrnDir: String? 	let nxBiSec: Double? 	let cycleDate: Double? 


	enum CodingKeys: String, CodingKey {
		case mtrIdent = "MTR_IDENT"		case segNbr = "SEG_NBR"		case ptIdent = "PT_IDENT"		case ptUsage = "PT_USAGE"		case ptLat = "PT_LAT"		case ptDlat = "PT_DLAT"		case ptLong = "PT_LONG"		case ptDlong = "PT_DLONG"		case ptWdthL = "PT_WDTH_L"		case ptWdthR = "PT_WDTH_R"		case ptTrnRad = "PT_TRN_RAD"		case ptTrnDir = "PT_TRN_DIR"		case ptBiSec = "PT_BI_SEC"		case nxPoint = "NX_POINT"		case nxUsage = "NX_USAGE"		case nxLat = "NX_LAT"		case nxDlat = "NX_DLAT"		case nxLong = "NX_LONG"		case nxDlong = "NX_DLONG"		case nxWdthL = "NX_WDTH_L"		case nxWdthR = "NX_WDTH_R"		case nxTrnRad = "NX_TRN_RAD"		case nxTrnDir = "NX_TRN_DIR"		case nxBiSec = "NX_BI_SEC"		case cycleDate = "CYCLE_DATE"
}
}