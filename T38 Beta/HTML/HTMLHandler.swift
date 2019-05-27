//
//  HTMLHandler.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 5/26/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


class HTMLHandler: NSObject {
    
    override init() {
        super.init()
    }
    
    let pathToLineUpCardHTMLTemplate = Bundle.main.path(forResource: "luc", ofType: "htm")
    
    var pdfFilename: String!
    
    var callSign_1: String!
    
    func putCalculatedValuesInLineUpCard(callSign_1: String,
                                         callSign_2: String,
                                         callSign_3: String,
                                         callSign_4: String,
                                         callSignNum_1: String,
                                         callSignNum_2: String,
                                         callSignNum_3: String,
                                         callSignNum_4: String,
                                         frontPilot_1: String,
                                         frontPilot_2: String,
                                         frontPilot_3: String,
                                         frontPilot_4: String,
                                         backPilot_1: String,
                                         backPilot_2: String,
                                         backPilot_3: String,
                                         backPilot_4: String,
                                         aircraft_1: String,
                                         aircraft_2: String,
                                         aircraft_3: String,
                                         aircraft_4: String,
                                         joker: String,
                                         bingo: String,
                                         macsSpeed: String,
                                         macsDist: String,
                                         ds: String,
                                         rsEf: String,
                                         setos: String,
                                         setosp10: String,
                                         cfl: String,
                                         eor: String,
                                         rsBeo: String,
                                         grDnSecg: String,
                                         grUpSecg: String,
                                         pa: String,
                                         temp: String,
                                         winds: String,
                                         cieling: String,
                                         icing: String,
                                         show: String,
                                         brief: String,
                                         step: String,
                                         to: String,
                                         land: String,
                                         missionOb1: String,
                                         missionOb2: String,
                                         trainingObj1: String,
                                         trainingObj2: String,
                                         trainingObj3: String,
                                         trainingObj4: String,
                                         trainingObj5: String) -> String! {
        
        do {
            var HTMLContent = try String(contentsOfFile: pathToLineUpCardHTMLTemplate!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ROPER1#", with: callSign_1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ROPER2#", with: callSign_2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ROPER3#", with: callSign_3)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ROPER4#", with: callSign_4)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CSNUM1#", with: callSignNum_1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CSNUM2#", with: callSignNum_2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CSNUM3#", with: callSignNum_3)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CSNUM4#", with: callSignNum_4)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FRONT1#", with: frontPilot_1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FRONT2#", with: frontPilot_2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FRONT3#", with: frontPilot_3)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FRONT4#", with: frontPilot_4)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#BAK1#", with: backPilot_1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#BAK2#", with: backPilot_2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#BAK3#", with: backPilot_3)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#BAK4#", with: backPilot_4)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ACFT1#", with: aircraft_1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ACFT2#", with: aircraft_2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ACFT3#", with: aircraft_3)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ACFT4#", with: aircraft_4)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#J1.6#", with: joker)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#B1.2#", with: bingo)
            let macDandS = "\(macsSpeed) / \(macsDist)"
            HTMLContent = HTMLContent.replacingOccurrences(of: "#MAC / D#", with: macDandS)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#DS#", with: ds)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#RS-EF#", with: rsEf)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SETOS#", with: setos)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SETOS10#", with: setosp10)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CFL#", with: cfl)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#@EOR#", with: eor)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#RS-BEO#", with: rsBeo)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#GRDSECG#", with: grDnSecg)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#GRUSECG#", with: grUpSecg)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#PA#", with: pa)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TEMP#", with: temp)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#WINDS#", with: winds)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CIELING#", with: cieling)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ICING#", with: icing)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SHOW#", with: show)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#BRIEF#", with: brief)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#STEP#", with: step)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#T/O#", with: to)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LAND#", with: land)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#MISSION OBJ 1#", with: missionOb1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#MISSION OBJ 2#", with: missionOb2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TRNGOBJ1#", with: trainingObj1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TRNGOBJ2#", with: trainingObj2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TRNGOBJ3#", with: trainingObj3)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TRNGOBJ4#", with: trainingObj4)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TRNGOBJ5#", with: trainingObj5)
            return HTMLContent
        } catch {
            print("Not gonna happen today cowboy")
        }
        return nil
    }
    
    
    func exportHTMLContentToPDF(HTMLContent: String, view: UIViewController) {
        let printPAgeRenderer = PDFGenerator()
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPAgeRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPAgeRenderer)
        pdfFilename = "testPdf.pdf"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(pdfFilename)!
        print(path)
        pdfData.write(to: path, atomically: true)
        showOptionsAlert(pdfUrl: path, on: view, htmlLineUpCard: HTMLContent, pdfData: pdfData)
        
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData {
        let data = NSMutableData()
        let A4PageWidth: CGFloat = 740
        let A4PageHeight: CGFloat = 841.8
        UIGraphicsBeginPDFContextToData(data, CGRect(x: 0, y: 0, width: A4PageHeight, height: A4PageWidth), nil)
        UIGraphicsBeginPDFPage()
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        UIGraphicsEndPDFContext()
        return data
    }
    
    
    func showOptionsAlert(pdfUrl: URL, on: UIViewController, htmlLineUpCard: String, pdfData: NSData) {
        let alertController = UIAlertController(title: "Line Up Card", message: "Would you Like to create a Line Up Card", preferredStyle: .alert)
//        let actionEmail = UIAlertAction(title: "Email", style: .default) { (action) in
//            self.sendEmail(pdfUrl: pdfUrl, view: on)
//        }
        let actionShare = UIAlertAction(title: "Export", style: .default) { (action) in
            on.passDataToShareSheet(fileName: "LUC", ext: ".pdf", dataToWriteToFile: pdfData)
        }
//        let actionPrint = UIAlertAction(title: "Print", style: .default) { (action) in
//            self.airPrint(htmlLineUpCard: htmlLineUpCard)
//        }
        let actionNothing = UIAlertAction(title: "Dismiss", style: .default) { (action) in
        }
//        alertController.addAction(actionEmail)
        alertController.addAction(actionShare)
//        alertController.addAction(actionPrint)
        alertController.addAction(actionNothing)
        on.present(alertController, animated: true, completion: nil)
    }
    
    func sendEmail(pdfUrl: URL, view: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.setSubject("Line Up Card")
            do {
                let data = try Data(contentsOf: pdfUrl)
                mailComposer.addAttachmentData(data, mimeType: "application/pdf", fileName: "LUC")
                view.present(mailComposer, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
    }
    
    
    func airPrint(htmlLineUpCard: String) {
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = .general
        printInfo.jobName = "Line Up Card"
        printController.printInfo = printInfo
        let formatter = UIMarkupTextPrintFormatter(markupText: htmlLineUpCard)
        formatter.perPageContentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        printController.printFormatter = formatter
        printController.present(animated: true, completionHandler: nil)
    }
    
    
    func getDocDir() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
}
