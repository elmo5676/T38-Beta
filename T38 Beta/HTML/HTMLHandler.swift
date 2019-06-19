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
import WebKit


class HTMLHandler: NSObject {
    
    override init() {
        super.init()
        copyBundleItems([image01,image02])
    }
    
    var htmlContent: String?
    let image01 = "image_0001.png"
    let image02 = "image_0002.png"
    let html = Bundle.main.path(forResource: "lineUpCard_BAB_C", ofType: "htm")
    
    
    var pdfFilename: String!
    
    func copyBundleItems(_ items: [String]) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            let existingFiles = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            if existingFiles.count > 0 {
                for file in existingFiles {
                    try fileManager.removeItem(at: file)
                }}
        } catch {
            print("Error encountered while removing items: \(error)")
        }
        do {
            for item in items {
                let itemUrl = documentsDirectory.appendingPathComponent(item)
                guard let bundleURL = Bundle.main.url(forResource: item, withExtension: nil) else {
                    continue
                }
                try fileManager.copyItem(at: bundleURL, to: itemUrl)
            }
        } catch {
            print("An error occured during copy operations: \(error)")
        }}
    
    fileprivate func setDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        _ = dateFormatter.dateFormat = "dd-MM-yy"
        return dateFormatter.string(from: date)
    }
    
    func putCalculatedValuesInLineUpCard(callSign_1: String, callSign_2: String, callSign_3: String, callSign_4: String, callSignNum_1: String, callSignNum_2: String, callSignNum_3: String, callSignNum_4: String, frontPilot_1: String, frontPilot_2: String, frontPilot_3: String, frontPilot_4: String, backPilot_1: String, backPilot_2: String, backPilot_3: String, backPilot_4: String, airToAirTac_01: String, airToAirTac_02: String, airToAirTac_03: String, airToAirTac_04: String, line_01: String, line_02: String, line_03: String, line_04: String, event: String, aircraft_1: String, aircraft_2: String, aircraft_3: String, aircraft_4: String, joker: String, bingo: String, macsSpeed: String, macsDist: String, ds: String, rsEf: String, setos: String, setosp10: String, cfl: String, eor: String, rsBeo: String, grDnSecg: String, grUpSecg: String, pa: String, temp: String, winds: String, cieling: String, icing: String, show: String, brief: String, step: String, to: String, land: String) -> String! {
        
        var HTMLContent = ""
        do {
            HTMLContent = try String(contentsOfFile: html!)
        } catch {
            print(error)
        }
        HTMLContent = HTMLContent.replacingOccurrences(of: "#image01#", with: "\(image01)")
        HTMLContent = HTMLContent.replacingOccurrences(of: "#image02#", with: "\(image02)")
        HTMLContent = HTMLContent.replacingOccurrences(of: "#DATE#", with: setDate())
        HTMLContent = HTMLContent.replacingOccurrences(of: "#RP1#", with: callSign_1)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#RP2#", with: callSign_2)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#RP3#", with: callSign_3)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#RP4#", with: callSign_4)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#CSN1#", with: callSignNum_1)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#CSN2#", with: callSignNum_2)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#CSN3#", with: callSignNum_3)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#CSN4#", with: callSignNum_4)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#FRONT1#", with: frontPilot_1)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#FRONT2#", with: frontPilot_2)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#FRONT3#", with: frontPilot_3)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#FRONT4#", with: frontPilot_4)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#BAK1#", with: backPilot_1)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#BAK2#", with: backPilot_2)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#BAK3#", with: backPilot_3)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#BAK4#", with: backPilot_4)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#A1#", with: airToAirTac_01)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#A2#", with: airToAirTac_02)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#A3#", with: airToAirTac_03)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#A4#", with: airToAirTac_04)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#LN1#", with: line_01)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#LN2#", with: line_02)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#LN3#", with: line_03)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#LN4#", with: line_04)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#EVENT#", with: event)
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
        HTMLContent = HTMLContent.replacingOccurrences(of: "#GD#", with: grDnSecg)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#GU#", with: grUpSecg)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#PA#", with: pa)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#TEMP#", with: temp)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#WINDS#", with: winds)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#CIELING#", with: cieling)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#ICING#", with: icing)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#SHOW#", with: show)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#BRIEF#", with: brief)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#STEP#", with: step)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#T/O#", with: to)
        HTMLContent = HTMLContent.replacingOccurrences(of: "#LD#", with: land)
        htmlContent = HTMLContent
        return HTMLContent
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData {
        let data = NSMutableData()
        let A4PageWidth: CGFloat = 560.0
        let A4PageHeight: CGFloat = 800.0
        UIGraphicsBeginPDFContextToData(data, CGRect(x: 0, y: 0, width: A4PageHeight, height: A4PageWidth), nil)
        UIGraphicsBeginPDFPage()
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        UIGraphicsEndPDFContext()
        return data
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
    
    func exportHTMLContentToPDFwithWebView(HTMLContent: String, webView: WKWebView, view: UIViewController) {
        let printPAgeRenderer = PDFGenerator()
        let printFormatter = webView.viewPrintFormatter()
        printPAgeRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPAgeRenderer)
        pdfFilename = "testPdf.pdf"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(pdfFilename)!
        print(path)
        pdfData.write(to: path, atomically: true)
        showOptionsAlert(pdfUrl: path, on: view, htmlLineUpCard: HTMLContent, pdfData: pdfData)
    }
    
    
    func showOptionsAlert(pdfUrl: URL, on: UIViewController, htmlLineUpCard: String, pdfData: NSData) {
        let alertController = UIAlertController(title: "Line Up Card", message: "Would you Like to create a Line Up Card. If you choose to make one, have patience. Your ipad mini will take up to 30 seconds to produce this fine piece of artwork in a printable format. In that time it will look like its locked up. If you would like it to be faster... so would I. It will when we get the new ipad minis!", preferredStyle: .alert)
        //        let actionEmail = UIAlertAction(title: "Email", style: .default) { (action) in
        //            self.sendEmail(pdfUrl: pdfUrl, view: on)
        //        }
        let actionShare = UIAlertAction(title: "Export", style: .default) { (action) in
            on.passDataToShareSheet(fileName: "LUC", ext: ".pdf", dataToWriteToFile: pdfData)
            //            on.presentingViewController?.dismiss(animated: true, completion: nil)
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
