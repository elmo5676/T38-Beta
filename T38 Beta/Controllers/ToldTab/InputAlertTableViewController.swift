//
//  InputAlertTableViewController.swift
//  T38
//
//  Created by Matthew Elmore on 4/23/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

class InputAlertTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //This changes size of the table based on content
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    //This changes size of the table based on content
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.preferredContentSize = tableView.contentSize
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    var titles: [String] = ["Aero Braking","Temperature","Temp Scale","Pressure Alt","Runway Length","Runway Heading","Wind Dir","Wind Speed","Runway Slope","RCR","Take Off Weight","Pod Mounted"]
    var userInputs: [String] = []
    var calcInputs: [String] = []

    //testArrays
//    var userInputs = ["0", "18.0", "C", "815.0", "11000.0", "346.0", "0.0", "0.0", "0.5", "23.0", "12740.0", "0"]
//    var calcInputs = ["0", "18.0", "C", "814.0", "11000.0", "346.0", "0.0", "0.0", "0.5", "23.0", "12740.0", "0"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let vw = UIView()
            vw.backgroundColor = #colorLiteral(red: 0.1927910447, green: 0.210706085, blue: 0.2634028196, alpha: 1)
            vw.frame.size.width = tableView.frame.width - 5
            let labelSize = CGRect(x: 10, y: 0, width: vw.frame.width - 10, height: 30)
            let pilotInput = UILabel(frame: labelSize)
            pilotInput.textColor = .white
            pilotInput.textAlignment = .center
            pilotInput.text = "***** ATTENTION *****"
            vw.addSubview(pilotInput)
            return vw
        case 1:
            let vw = UIView()
            vw.backgroundColor = #colorLiteral(red: 0.1927910447, green: 0.210706085, blue: 0.2634028196, alpha: 1)
            vw.frame.size.width = tableView.frame.width - 5
            let labelSize = CGRect(x: 10, y: 0, width: vw.frame.width - 10, height: 30)
            let pilotInput = UILabel(frame: labelSize)
            let calcInput = UILabel(frame: labelSize)
            pilotInput.textColor = .white
            calcInput.textColor = .white
            pilotInput.textAlignment = .left
            calcInput.textAlignment = .right
            pilotInput.text = "Pilot Input"
            calcInput.text = "Calc Input"
            vw.addSubview(pilotInput)
            vw.addSubview(calcInput)
            return vw
        default:
            return nil
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return userInputs.count
        default: return 0
        }
    }

    func switchFromBoolToYorN(str: String) -> String {
        var result = ""
        if str == "0" {
            result = "N"
        } else if str == "1" {
            result = "Y"
        } else {
            result = "error"
        }
        return result
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "inputsTitleCell", for: indexPath)
            return titleCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "inputsCell", for: indexPath) as! InputsCellTableViewCell
            cell.leftLabel.text = userInputs[indexPath.row]
            cell.rightLabel.text = calcInputs[indexPath.row]
            cell.centerLabel.text = titles[indexPath.row]
            
            switch indexPath.row {
            case 0:
                userInputs[indexPath.row] = switchFromBoolToYorN(str: userInputs[indexPath.row])
                calcInputs[indexPath.row] = switchFromBoolToYorN(str: calcInputs[indexPath.row])
            case 11:
                userInputs[indexPath.row] = switchFromBoolToYorN(str: userInputs[indexPath.row])
                calcInputs[indexPath.row] = switchFromBoolToYorN(str: calcInputs[indexPath.row])
            default:
                print("")
            }
            if userInputs[indexPath.row] != calcInputs[indexPath.row] {
                cell.backroundCellView.backgroundColor = #colorLiteral(red: 0.7128432393, green: 0.1082888916, blue: 0.02164147422, alpha: 1)
                cell.centerLabel.font = UIFont(name: ".SFUIText-Semibold", size: 17)
                cell.leftLabel.font = UIFont(name: ".SFUIText-Semibold", size: 17)
                cell.rightLabel.font = UIFont(name: ".SFUIText-Semibold", size: 17)
                cell.centerLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.leftLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.rightLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            cell.centerLabel.text = titles[indexPath.row]
            cell.leftLabel.text = userInputs[indexPath.row]
            cell.rightLabel.text = calcInputs[indexPath.row]
            return cell
        default:
            let dCell = UITableViewCell()
            return dCell
        }
        
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
 


}
