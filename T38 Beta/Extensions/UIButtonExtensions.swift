//
//  UIButtonExtensions.swift
//  T38
//
//  Created by elmo on 5/27/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    func wiggle() {
        let wiggleAnim = CABasicAnimation(keyPath: "position")
        wiggleAnim.duration = 0.05
        wiggleAnim.repeatCount = 5
        wiggleAnim.autoreverses = true
        wiggleAnim.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        wiggleAnim.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(wiggleAnim, forKey: "position")
    }
    func dim() {
        UIView.animate(withDuration: 0.17, animations: {self.alpha = 0.65}) {
            (finished) in UIView.animate(withDuration: 0.15, animations: {
                self.alpha = 1.0})
        }
    }
    func colorize() {
        let randomNumberArray = generateRandomNumbers(quantity: 3)
        let randomColor = UIColor(red: randomNumberArray[0]/255, green:     randomNumberArray[1]/255, blue: randomNumberArray[2]/255, alpha: 1.0)
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = randomColor
        }
    }
    
    
    func showPressed() {
        let bgc = self.layer.backgroundColor
        UIView.animate(withDuration: 0.05) {
            self.backgroundColor = #colorLiteral(red: 0.6157805324, green: 0.6158866882, blue: 0.6157665849, alpha: 1)
        }
        UIView.animate(withDuration: 0.35) {
            self.layer.backgroundColor = bgc
        }
    }
    
    func standardButtonFormatting() {
        self.backgroundColor = #colorLiteral(red: 0.2764866352, green: 0.3470229506, blue: 0.4352231026, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.2771260142, green: 0.3437626958, blue: 0.4359292388, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
    
    func generateRandomNumbers(quantity: Int) -> [CGFloat] {
        var randomNumberArray = [CGFloat]()
        for _ in 1...quantity {
            let randomNumber = CGFloat(arc4random_uniform(255))
            randomNumberArray.append(randomNumber)
        }
        return randomNumberArray
    }
    
}

@IBDesignable class customButton: UIButton {
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}


public extension Array where Element: UIButton {
    func colorScheme_Standard() {
        for element in self {
            element.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            element.titleLabel?.textColor = #colorLiteral(red: 0.2771260142, green: 0.3437626958, blue: 0.4359292388, alpha: 1)
            element.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            //element.layer.borderWidth = 0.0
            element.layer.cornerRadius = CGFloat(corner)
        }
    }
    func colorScheme_Dark() {
        for element in self {
            element.backgroundColor = #colorLiteral(red: 0.2771260142, green: 0.3437626958, blue: 0.4359292388, alpha: 1)
            element.titleLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            element.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            //element.layer.borderWidth = 0.0
            element.layer.cornerRadius = CGFloat(corner)
        }
    }
}


