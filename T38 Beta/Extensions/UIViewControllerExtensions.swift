//
//  UIViewControllerExtensions.swift
//  T38
//
//  Created by elmo on 5/27/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    func directToInForeFlight(icao: String) {
        var urlString = URLComponents(string: "foreflightmobile://maps/search?")!
        urlString.query = "q=D \(String(describing: icao))"
        let url = urlString.url!
        UIApplication.shared.open(url , options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    func popOverFormat(_ po: UIStoryboardSegue, sender: Any?){
        if let po = po.destination.popoverPresentationController, let _ = sender as? UIView {
            po.backgroundColor = .clear
        }
    }
    
    func alert(title: String, message: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true)
    }
    
    func sizeClass() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
        return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func passToShareSheet(fileName: String, ext: String, stringToWriteToFile: String){
        let fileName = "\(fileName).\(ext)"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        do {
            try stringToWriteToFile.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            let vc = UIActivityViewController(activityItems: [path as Any], applicationActivities: [])
            vc.popoverPresentationController?.sourceView = self.view
            print("Success")
            present(vc, animated: true, completion: nil)
            print(stringToWriteToFile)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func passToShareSheetWithfileNamePopupWith(alertTitle: String, alertMessage: String, placeHolder: String, ext: String, stingToWrite: String) {
        //Alert for naming the file:
        var fileNameTextField: UITextField?
        func fileNameTextField_(textField: UITextField!) {
            fileNameTextField = textField
            fileNameTextField?.placeholder = placeHolder
        }
        func okHandler(alert: UIAlertAction!) {
            var overlayFileName = placeHolder
            if fileNameTextField?.text == "" || fileNameTextField?.text == nil {
                overlayFileName = placeHolder
            } else {
                overlayFileName = (fileNameTextField?.text)!
            }
            self.passToShareSheet(fileName: overlayFileName, ext: ext, stringToWriteToFile: stingToWrite)
        }
        func alertControllerName() {
            let alertController = UIAlertController(title: alertTitle,
                                                    message: alertMessage,
                                                    preferredStyle: .alert)
            alertController.addTextField(configurationHandler: fileNameTextField_)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: okHandler)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
        alertControllerName()
    }
    
    
    // MARK: - Animations
    enum ButtonShape {
        case round
        case rectangle
    }
    enum OpenDirection {
        case up
        case down
        case left
        case right
        case radialFromBottomLeft
        case radialFromBottomRight
        case radialFromTopLeft
        case radialFromTopRight
    }
    
    enum TitleType {
        case string
        case image
    }
    
    func setTitle(_ title: String, forButton: UIButton){
        forButton.setTitle(title, for: .normal)
    }
    
    func setImageForTitle(_ title: String, forButton: UIButton, withTint: UIColor){
        forButton.setImage(UIImage(named: title), for: .normal)
        forButton.imageView?.contentMode = .scaleAspectFit
        let inset: CGFloat = 12
        forButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        forButton.tintColor = withTint
    }
    
    func createPopUpWith(numberOfButtons: Int,
                                onButton: UIButton,
                                withBlur: UIVisualEffectView,
                                onView: UIView,
                                withTitles: [String],
                                titleType: TitleType,
                                funcName: Selector,
                                open: Bool,
                                buttonShape: ButtonShape,
                                direction: OpenDirection,
                                duration: CGFloat,
                                cornerRadiusOfRectButtons: CGFloat,
                                buttonSpacing: CGFloat,
                                borderWidth: CGFloat,
                                borderColor: CGColor,
                                buttonContainer: [UIButton],
                                blurContainer: [UIVisualEffectView]) -> (buttons: [UIButton], blurs: [UIVisualEffectView])  {
        
        //If you use .rectangle and keep the buttonSpacing less than 0.1 it has them connected with rounding the outer buttons only
        var btnOutletCollection: [UIButton] = [onButton]
        let frame = onButton.frame
        var cornerRadius: CGFloat = cornerRadiusOfRectButtons
        var blurCollection: [UIVisualEffectView] = [withBlur]
        let duration = duration
        var spacing: CGFloat = buttonSpacing
        let backgroundColor = onButton.backgroundColor
        let fontColor = onButton.titleColor(for: .normal)
        func buttonCreation() {
            for i in 0...numberOfButtons - 1 {
                let button = UIButton(type: .custom)
                button.frame = frame
                button.center = onButton.center
//                button.setTitleColor(UIColor.clear, for: .normal)
//                button.setTitleColor(#colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1)
                button.layer.cornerRadius = cornerRadius
                
                switch titleType {
                case .image:
                    setImageForTitle(withTitles[i], forButton: button, withTint: onButton.currentTitleColor)
                case .string:
                    button.setTitle(withTitles[i], for: .normal)
                }
                button.tag = i
                button.addTarget(self, action: funcName, for: .touchUpInside)
                print(button.tag)
                let blur = UIBlurEffect(style: .dark)
                let blurView = UIVisualEffectView(effect: blur)
                blurView.frame = frame
                blurView.layer.cornerRadius = cornerRadius
                blurView.layer.masksToBounds = true
                if buttonShape == .rectangle {
                    switch direction {
                    case .up:
                        blurView.bounds.size.width = onButton.bounds.width
                        button.bounds.size.width = 0
                    case .down:
                        blurView.bounds.size.width = onButton.bounds.width
                        button.bounds.size.width = 0
                    case .left:
                        blurView.bounds.size.width = 0
                        button.bounds.size.width = onButton.bounds.height
                    case .right:
                        blurView.bounds.size.width = 0
                        button.bounds.size.width = onButton.bounds.height
                    default:
                        blurView.bounds.size.width = 0
                        button.bounds.size.width = 0
                    }
                    //                    blurView.bounds.size.width = 0
                    //                    button.bounds.size.width = 0
                }
                btnOutletCollection.append(button)
                blurCollection.append(blurView)
                for i in 1...blurCollection.count - 1 {
                    blurCollection[i].clipsToBounds = true
                    btnOutletCollection[i].clipsToBounds = true
                }
                
//                onView.insertSubview(blurView, belowSubview: onButton)
                onView.insertSubview(button, belowSubview: onButton)
//                onView.insertSubview(button, aboveSubview: onButton)
//                onView.insertSubview(blurView, aboveSubview: onButton)
                
            }
        }
        
        func initialFormatting() {
            for i in 0...btnOutletCollection.count - 1 {
                btnOutletCollection[i].layer.cornerRadius = cornerRadius
                blurCollection[i].layer.cornerRadius = cornerRadius
//                btnOutletCollection[i].backgroundColor = UIColor.clear
                btnOutletCollection[i].backgroundColor = #colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1)
                btnOutletCollection[i].layer.borderWidth = borderWidth
                btnOutletCollection[i].layer.borderColor = borderColor
                if blurCollection.count != 0 {
                }}}
        
        func openButton(btnShape: ButtonShape, dir: OpenDirection, i: Int) {
            let spacingFactor = CGFloat(numberOfButtons - 1)
            let rC = Double(btnOutletCollection[0].bounds.width + spacing)
            let angle = 90 / (numberOfButtons - 1)
            let spacingR = CGFloat(rC/(Double(angle).degreesToRadians))
            let x0 = btnOutletCollection[0].center.x
            let y0 = btnOutletCollection[0].center.y
            func radialOpening(x1: CGFloat, y1: CGFloat){
                btnOutletCollection[i].center.x = x1
                btnOutletCollection[i].center.y = y1
                blurCollection[i].center.x = x1
                blurCollection[i].center.y = y1
            }
            switch direction {
            case .radialFromBottomLeft:
                let x1 = x0 + spacingR * CGFloat(cos(Double(angle * (i) - angle).degreesToRadians))
                let y1 = y0 - spacingR * CGFloat(sin(Double(angle * (i) - angle).degreesToRadians))
                radialOpening(x1: x1, y1: y1)
            case .radialFromBottomRight:
                let x1 = x0 - spacingR * CGFloat(cos(Double(angle * (i) - angle).degreesToRadians))
                let y1 = y0 - spacingR * CGFloat(sin(Double(angle * (i) - angle).degreesToRadians))
                radialOpening(x1: x1, y1: y1)
            case .radialFromTopLeft:
                let x1 = x0 + spacingR * CGFloat(cos(Double(angle * (i) - angle).degreesToRadians))
                let y1 = y0 + spacingR * CGFloat(sin(Double(angle * (i) - angle).degreesToRadians))
                radialOpening(x1: x1, y1: y1)
            case .radialFromTopRight:
                let x1 = x0 - spacingR * CGFloat(cos(Double(angle * (i) - angle).degreesToRadians))
                let y1 = y0 + spacingR * CGFloat(sin(Double(angle * (i) - angle).degreesToRadians))
                radialOpening(x1: x1, y1: y1)
            case .up:
                blurCollection[i].center.x = blurCollection[0].center.x
                blurCollection[i].center.y = blurCollection[i-1].center.y - blurCollection[0].bounds.height - spacing
                btnOutletCollection[i].center.x = btnOutletCollection[0].center.x
                btnOutletCollection[i].center.y = btnOutletCollection[i-1].center.y - btnOutletCollection[0].bounds.height - spacing
            case .down:
                blurCollection[i].center.x = blurCollection[0].center.x
                blurCollection[i].center.y = blurCollection[i-1].center.y + blurCollection[0].bounds.height + spacing
                btnOutletCollection[i].center.x = btnOutletCollection[0].center.x
                btnOutletCollection[i].center.y = btnOutletCollection[i-1].center.y + btnOutletCollection[0].bounds.height + spacing
            case .left:
                blurCollection[i].center.x = blurCollection[i-1].center.x - blurCollection[0].bounds.width - spacing
                blurCollection[i].center.y = blurCollection[0].center.y
                btnOutletCollection[i].center.x = btnOutletCollection[i-1].center.x - btnOutletCollection[0].bounds.width - spacing
                btnOutletCollection[i].center.y = btnOutletCollection[0].center.y
            case .right:
                blurCollection[i].center.x = blurCollection[i-1].center.x + blurCollection[0].bounds.width + spacing
                blurCollection[i].center.y = blurCollection[0].center.y
                btnOutletCollection[i].center.x = btnOutletCollection[i-1].center.x + btnOutletCollection[0].bounds.width + spacing
                btnOutletCollection[i].center.y = btnOutletCollection[0].center.y
            }
            btnOutletCollection[i].isHidden = true
            blurCollection[i].bounds.size.width = blurCollection[0].bounds.size.width
            blurCollection[i].bounds.size.height = blurCollection[0].bounds.size.height
            blurCollection[i].alpha = 1
            btnOutletCollection[i].bounds.size.width = btnOutletCollection[0].bounds.size.width
            btnOutletCollection[i].bounds.size.height = btnOutletCollection[0].bounds.size.height
            btnOutletCollection[i].alpha = 1
            btnOutletCollection[i].layer.borderWidth = borderWidth
            btnOutletCollection[i].layer.borderColor = borderColor
            if spacing <= 0.09 {
                blurCollection[i].layer.cornerRadius = 0
                btnOutletCollection[i].layer.cornerRadius = 0
            } else {
                blurCollection[i].layer.cornerRadius = cornerRadius
                btnOutletCollection[i].layer.cornerRadius = cornerRadius
            }
            
        }
        
        func closeRound(dir: OpenDirection, i: Int) {
            blurContainer[i].center.x = blurContainer[0].center.x
            blurContainer[i].center.y = blurContainer[0].center.y
            blurContainer[i].bounds.size.height = 0.0
            blurContainer[i].bounds.size.width = 0.0
            blurContainer[i].layer.cornerRadius = 0.0
            blurContainer[i].alpha = 0
            buttonContainer[i].center.x = buttonContainer[0].center.x
            buttonContainer[i].center.y = buttonContainer[0].center.y
            buttonContainer[i].bounds.size.width = 0.0
            buttonContainer[i].bounds.size.height = 0.0
            buttonContainer[i].layer.cornerRadius = 0.0
            buttonContainer[i].alpha = 0
        }
        
        func closeRect(dir: OpenDirection, i: Int) {
            blurContainer[i].center.x = blurContainer[0].center.x
            blurContainer[i].center.y = blurContainer[0].center.y
            func radials() {
                blurContainer[i].bounds.size.width = 0.0
                blurContainer[i].bounds.size.height = 0.0
                buttonContainer[i].bounds.size.width = 0.0
                buttonContainer[i].bounds.size.height = 0.0
            }
            switch direction {
            case .radialFromBottomLeft:
                radials()
            case .radialFromBottomRight:
                radials()
            case .radialFromTopLeft:
                radials()
            case .radialFromTopRight:
                radials()
            case .up:
                blurContainer[i].bounds.size.width = blurContainer[0].bounds.size.width
                blurContainer[i].bounds.size.height = 0.0
                buttonContainer[i].bounds.size.width = buttonContainer[0].bounds.size.width
                buttonContainer[i].bounds.size.height = 0.0
            case .down:
                blurContainer[i].bounds.size.width = blurContainer[0].bounds.size.width
                blurContainer[i].bounds.size.height = 0.0
                buttonContainer[i].bounds.size.width = buttonContainer[0].bounds.size.width
                buttonContainer[i].bounds.size.height = 0.0
            case .left:
                blurContainer[i].bounds.size.height = blurContainer[0].bounds.size.height
                blurContainer[i].bounds.size.width = 0.0
                buttonContainer[i].bounds.size.height = buttonContainer[0].bounds.size.height
                buttonContainer[i].bounds.size.width = 0.0
            case .right:
                blurContainer[i].bounds.size.height = blurContainer[0].bounds.size.height
                blurContainer[i].bounds.size.width = 0.0
                buttonContainer[i].bounds.size.height = buttonContainer[0].bounds.size.height
                buttonContainer[i].bounds.size.width = 0.0
            }
            blurContainer[i].alpha = 0
            buttonContainer[i].alpha = 0
        }
        
        func cleanUp() {
            for i in 1...buttonContainer.count - 1 {
                buttonContainer[i].removeFromSuperview()
                blurContainer[i].removeFromSuperview()
            }
            btnOutletCollection = [buttonContainer[0]]
            blurCollection = [blurContainer[0]]
        }
        
        func round() {
            cornerRadius = btnOutletCollection[0].bounds.width/2
            initialFormatting()
            if open {
                buttonCreation()
                UIView.animate(withDuration: TimeInterval(duration), animations: {
                    for i in 1...btnOutletCollection.count - 1 {
                        openButton(btnShape: buttonShape, dir: direction, i: i)
                    }
                }) { (true) in
                    for i in 1...btnOutletCollection.count - 1 {
                        btnOutletCollection[i].isHidden = false
                        btnOutletCollection[i].setTitleColor(fontColor, for: .normal)
                    }
                    print("What's the meaning of life, the universe and everything?")
                }
            } else {
                if buttonContainer.count > 1 {
                    for i in 1...buttonContainer.count - 1 {
                        buttonContainer[i].isHidden = true
                    }
                    UIView.animate(withDuration: TimeInterval(duration), animations: {
                        for i in 1...buttonContainer.count - 1 {
                            closeRound(dir: direction, i: i)
                        }
                    }) { (true) in
                        print("42")
                        cleanUp()
                    }}}
        }
        
        func rectangleTargetButton(sender: UIView, cornerRadius: CGFloat, direction: OpenDirection){
            sender.clipsToBounds = true
            sender.layer.cornerRadius = cornerRadius
            switch direction {
            case .up:
                sender.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            case .down:
                sender.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .left:
                sender.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            case .right:
                sender.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            case .radialFromBottomLeft:
                print("ATIS smells like eldaberries")
            case .radialFromBottomRight:
                print("We are the knights who say NEE")
            case .radialFromTopLeft:
                print("")
            case .radialFromTopRight:
                print("")
            }}
        func rectanglePopUpCornersOpening(sender: UIView, cornerRadius: CGFloat, direction: OpenDirection){
            sender.clipsToBounds = true
            sender.layer.cornerRadius = cornerRadius
            switch direction {
            case .up:
                sender.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .down:
                sender.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .left:
                sender.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            case .right:
                sender.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            case .radialFromBottomLeft:
                print("ATIS smells like eldaberries")
            case .radialFromBottomRight:
                print("We are the knights who say NEE")
            case .radialFromTopLeft:
                print("")
            case .radialFromTopRight:
                print("")
            }}
        func rectangleMainButtonCornersClosing(sender: UIView, cornerRadius: CGFloat){
            sender.clipsToBounds = true
            sender.layer.cornerRadius = cornerRadius
            sender.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        func rectangle() {
            initialFormatting()
            if open {
                buttonCreation()
                UIView.animate(withDuration: TimeInterval(duration), animations: {
                    for i in 1...btnOutletCollection.count - 1 {
                        openButton(btnShape: buttonShape, dir: direction, i: i)
                    }
                }) { (true) in
                    for i in 1...btnOutletCollection.count - 1 {
                        btnOutletCollection[i].isHidden = false
                        btnOutletCollection[i].setTitleColor(fontColor, for: .normal)
                    }
                    print("ATIS, get a haircut and do something with your life")
                }
                if spacing <= 0.09 {
                    rectangleTargetButton(sender: onButton, cornerRadius: cornerRadius, direction: direction)
                    rectangleTargetButton(sender: withBlur, cornerRadius: cornerRadius, direction: direction)
                    let nbrBtns = numberOfButtons
                    rectanglePopUpCornersOpening(sender: blurCollection[nbrBtns] , cornerRadius: cornerRadius, direction: direction)
                    rectanglePopUpCornersOpening(sender: btnOutletCollection[nbrBtns] , cornerRadius: cornerRadius, direction: direction)
                }} else {
                if buttonContainer.count > 1 {
                    for i in 1...buttonContainer.count - 1 {
                        buttonContainer[i].isHidden = true
                    }
                    UIView.animate(withDuration: TimeInterval(duration), animations: {
                        for i in 1...buttonContainer.count - 1 {
                            closeRect(dir: direction, i: i)
                        }
                    }) { (true) in
                        print("Get your shit together!!")
                        cleanUp()
                    }}
                if spacing <= 0.09 {
                    rectangleMainButtonCornersClosing(sender: onButton, cornerRadius: cornerRadius)
                    rectangleMainButtonCornersClosing(sender: withBlur, cornerRadius: cornerRadius)
                }}}
        
        switch buttonShape {
        case .round:
            round()
        case .rectangle:
            rectangle()
        }
        
        return (buttons: btnOutletCollection, blurs: blurCollection)
        
    }
    
    
    
    
    
    
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
