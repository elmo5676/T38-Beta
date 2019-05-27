//
//  ViewController.swift
//  Calculator
//
//  Created by elmo on 3/24/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit
import CoreLocation

var corner = 0.0

class CalcViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet var digitButtonCollection: [UIButton]!
    @IBOutlet var operationButtonCollection: [UIButton]!
    @IBOutlet weak var questionButtonOutlet: UIButton!
    @IBOutlet weak var nearestButtonOutlet: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    

    var cdu = CoreDataUtilies()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        setFormatting()
        let locMan = CLLocationManager()
        locMan.delegate = self
        let times = delegate.timesAppHasOpened
        print(times)
    }
    override func viewWillDisappear(_ animated: Bool) {
        setFormatting()
        delegate.timesAppHasOpened = delegate.getCurrentTimesOpened()
        delegate.saveTimesOpen()
    }
    
    
    func initialAlertForSuperSmartPilots(timesAlreadyDisplayed: Int){
        if timesAlreadyDisplayed <= 1 {
          print(timesAlreadyDisplayed)
            alertWithMessage(message: "Please make sure your iPad is connected to the internet on initial installation of version 3.0 or above. This version needs to download DAFIF on initial installation and process it. If the TOLD TAB is greyed out, this indicates that the required data has not been downloaded and processed. give it a minute on initial installation. If it still doesn’t work after several minutes, go to the SETTINGS TAB and press UPDATE DATA button.", title: "Info for Version 3.0", buttonTitle: "Ok, I Understand")
        }
    }
    
    func alertWithMessage(message: String, title: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true)
    }
    
    
    
    @IBAction func calcDirectionsButton(_ sender: UIButton) {
    }
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            if String(format: "%.2f", newValue).suffix(2) == "00" {
                display.text = String(format: "%.0f", newValue)
            } else if String(format: "%.2f", newValue).suffix(1) == "0" {
                display.text = String(format: "%.1f", newValue)
            } else {
                display.text = String(format: "%.2f", newValue)
            }
            
        }
    }
    
    private var brain = CalcBrains()
    @IBAction func nearestButton(_ sender: UIButton) {
        popoverPresentationController?.sourceRect = sender.bounds
        sender.showPressed()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "nearestPop"?:
            if let popoverPresentationController = segue.destination.popoverPresentationController, let sourceView = sender as? UIView {
                popoverPresentationController.sourceRect = sourceView.bounds
                popoverPresentationController.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2549019608, blue: 0.3098039216, alpha: 1)
            }
        case "calcDirectionsSeque"?:
            if let popoverPresentationController = segue.destination.popoverPresentationController, let sourceView = sender as? UIView {
            popoverPresentationController.sourceRect = sourceView.bounds
            }
        case "nearestReconfiguredSegue"?:
            if let popoverPresentationController = segue.destination.popoverPresentationController, let sourceView = sender as? UIView {
                popoverPresentationController.sourceRect = sourceView.bounds
                popoverPresentationController.sourceRect = sourceView.bounds
                popoverPresentationController.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2549019608, blue: 0.3098039216, alpha: 1)
            }
        case "planningSegue":
            if let popoverPresentationController = segue.destination.popoverPresentationController, let sourceView = sender as? UIView {
                popoverPresentationController.sourceRect = sourceView.bounds
                popoverPresentationController.sourceRect = sourceView.bounds
                popoverPresentationController.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2549019608, blue: 0.3098039216, alpha: 1)
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        let operatorTitle = sender.currentTitle!
        if sender.currentTitle == "C" {
            brain.clearState()
            operatorLabel.text = " "
        } else {
            let accumValue = String(format: "%.2f", brain.accumulator)
            operatorLabel.text = "\(operatorTitle) \(accumValue)"
        }

        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
            operatorLabel.text = operatorTitle
            
        }
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathmaticalSymbol)
        }
        displayValue = brain.result
    }
    
    
    var locManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        questionButtonOutlet.layer.borderColor = #colorLiteral(red: 0.5724972486, green: 0.5725823045, blue: 0.5724785328, alpha: 1)
        questionButtonOutlet.layer.borderWidth = 1
        questionButtonOutlet.layer.cornerRadius = CGFloat(15)
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        digitButtonCollection.colorScheme_Standard()
        operationButtonCollection.colorScheme_Dark()
        locManager.requestWhenInUseAuthorization()
        locManager.requestAlwaysAuthorization()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    
    func setFormatting() {
        nearestButtonOutlet.imageView?.contentMode = .scaleAspectFit
        iconImage.layer.cornerRadius = 8
        versionLabel.text = "\(buildNumber)"
        versionLabel.adjustsFontSizeToFitWidth = true
    }
    
    
}



































