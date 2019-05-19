//
//  TailTableViewController.swift
//  T38
//
//  Created by Matthew Elmore on 3/27/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

class TailTableViewController: UITableViewController {
    
    var basicWeight: Double     = 0
    var tailTitle: String       = ""
    var tails: [Tail]           = []
    var tailsKBAB: [TailKBAB]   = []
    var tailsKSZL: [TailKSZL]   = []
    var chosenTailDelegate: TOLDReconfiguredDelegate?

    
    func getBasicWeightForKBAB(tail: TailKBAB) -> (wt: Double, tailNumber: String) {
        switch tail {
        case ._64_13285:
            return (wt: 8303, tailNumber: "64-3285")
        case ._64_13247:
            return (wt: 8301, tailNumber: "64-3247")
        case ._68_8185:
            return (wt: 8225, tailNumber: "68-8185")
        case ._64_13217:
            return (wt: 8244, tailNumber: "64-3217")
        case ._66_4332:
            return (wt: 8223, tailNumber: "66-4332")
        case ._64_13304:
            return (wt: 8299, tailNumber: "64-3304")
        case ._64_13270:
            return (wt: 8290, tailNumber: "64-3270")
        case ._64_13240:
            return (wt: 8285, tailNumber: "64-3240")
        case ._65_10342:
            return (wt: 8324, tailNumber: "65-0342")
        case ._68_8150:
            return (wt: 8294, tailNumber: "68-8150")
        case ._64_13301:
            return (wt: 8312, tailNumber: "64-3301")
        case ._64_13297:
            return (wt: 8246, tailNumber: "64-3297")
        case ._65_10429:
            return (wt: 8346, tailNumber: "65-0429")
        }
    }
    
    func getBasicWeightForKSZL(tail: TailKSZL) -> (wt: Double, tailNumber: String) {
        switch tail {
        case ._68_8179:
            return (wt: Tail._68_8179.rawValue, tailNumber: "68-8179")
        case ._65_10419:
            return (wt: Tail._65_10419.rawValue, tailNumber: "65-0419")
        case ._67_14845:
            return (wt: Tail._67_14845.rawValue, tailNumber: "67-4845")
        case ._65_10324:
            return (wt: Tail._65_10324.rawValue, tailNumber: "65-0324")
        case ._64_13268:
            return (wt: Tail._64_13268.rawValue, tailNumber: "64-3268")
        case ._67_14920:
            return (wt: Tail._67_14920.rawValue, tailNumber: "67-4920")
        case ._67_14831:
            return (wt: Tail._67_14831.rawValue, tailNumber: "67-4831")
        case ._67_14826:
            return (wt: Tail._67_14826.rawValue, tailNumber: "67-4826")
        case ._65_10442:
            return (wt: Tail._65_10442.rawValue, tailNumber: "65-0442")
        case ._65_10418:
            return (wt: Tail._65_10418.rawValue, tailNumber: "65-0418")
        case ._66_8402:
            return (wt: Tail._66_8402.rawValue, tailNumber: "66-8402")
        case ._64_13206:
            return (wt: Tail._64_13206.rawValue, tailNumber: "64-3206")
        case ._64_13265:
            return (wt: Tail._64_13265.rawValue, tailNumber: "64-3265")
        case ._65_10361:
            return (wt: Tail._65_10361.rawValue, tailNumber: "65-0361")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tails = Tail.allTails
        tailsKBAB = TailKBAB.allTails
        tailsKSZL = TailKSZL.allTails
    }
    
    //This changes size of the table based on content
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.preferredContentSize = tableView.contentSize
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tailsKBAB.count
        case 1:
            return tailsKSZL.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "KBAB"
        case 1:
            return "KSZL"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var icao = ""
        switch section {
        case 0:
            icao = "KBAB"
        case 1:
            icao = "KSZL"
        default:
            print("no SOUP for YOU!")
        }
        let vw = UIView()
        vw.backgroundColor = #colorLiteral(red: 0.1927910447, green: 0.210706085, blue: 0.2634028196, alpha: 1)
        vw.frame.size.width = tableView.frame.width - 5
        let labelSize = CGRect(x: 10, y: 0, width: vw.frame.width - 10, height: 30)
        let tailLabel = UILabel(frame: labelSize)
        let weightLabel = UILabel(frame: labelSize)
        let icaoLabel = UILabel(frame: labelSize)
        tailLabel.textColor = .white
        weightLabel.textColor = .white
        icaoLabel.textColor = .white
        tailLabel.textAlignment = .left
        weightLabel.textAlignment = .right
        icaoLabel.textAlignment = .center
        tailLabel.text = "Tail"
        weightLabel.text = "Weight"
        icaoLabel.text = "\(icao)"
        vw.addSubview(tailLabel)
        vw.addSubview(icaoLabel)
        vw.addSubview(weightLabel)
        return vw
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tailCell", for: indexPath)
        switch indexPath.section {
        case 0:
            let title = getBasicWeightForKBAB(tail: tailsKBAB[indexPath.row])
            cell.textLabel?.text = title.tailNumber
            cell.detailTextLabel?.text = "\(String(format: "%.0f",title.wt))"
        case 1:
            let title = getBasicWeightForKSZL(tail: tailsKSZL[indexPath.row])
            cell.textLabel?.text = title.tailNumber
            cell.detailTextLabel?.text = "\(String(format: "%.0f",title.wt))"
        default:
            print("no tail for YOU!")
        }
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let chosenTail = getBasicWeightForKBAB(tail: tailsKBAB[indexPath.row])
            basicWeight = chosenTail.wt
            tailTitle = chosenTail.tailNumber
            chosenTailDelegate?.getChosenTail(tailTitle: tailTitle, basicWeight: basicWeight)
            print("\(tailTitle) : \(basicWeight)")
        case 1:
            let chosenTail = getBasicWeightForKSZL(tail: tailsKSZL[indexPath.row])
            basicWeight = chosenTail.wt
            tailTitle = chosenTail.tailNumber
            chosenTailDelegate?.getChosenTail(tailTitle: tailTitle, basicWeight: basicWeight)
            print("\(tailTitle) : \(basicWeight)")
        default:
            print("no tail for YOU!")
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
