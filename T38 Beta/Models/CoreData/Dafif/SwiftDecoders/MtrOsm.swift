
import Foundation

struct MtrOsm: Codable {
	let mtrIdent: String? 	let segNbr: Double? 	let seqNbr: Double? 	let suasMoaId: String? 	let cycleDate: Double? 	let sector: String? 	let ptIdent: String? 	let nxPoint: String? 


	enum CodingKeys: String, CodingKey {
		case mtrIdent = "MTR_IDENT"		case segNbr = "SEG_NBR"		case seqNbr = "SEQ_NBR"		case suasMoaId = "SUAS_MOA_ID"		case cycleDate = "CYCLE_DATE"		case sector = "SECTOR"		case ptIdent = "PT_IDENT"		case nxPoint = "NX_POINT"
}
}