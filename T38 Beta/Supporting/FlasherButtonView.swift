//
//  FlasherButtonView.swift
//  T38
//
//  Created by Matthew Elmore on 5/15/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

class FlasherButtonView: UIView {
    
    func setInitFormatting(cornerRadius: CGFloat,
                           borderWidth: CGFloat,
                           borderColor: CGColor,
                           mainButtonOutlet: UIButton?,
                           firstTitleLabel: UILabel?,
                           secondTitleLabel: UILabel?) {
        self.clipsToBounds = true
        mainButtonOutlet?.clipsToBounds = true
        firstTitleLabel?.clipsToBounds = true
        secondTitleLabel?.clipsToBounds = true

        mainButtonOutlet?.layer.cornerRadius = cornerRadius
        mainButtonOutlet?.layer.borderWidth = borderWidth
        mainButtonOutlet?.layer.borderColor = borderColor
        firstTitleLabel?.layer.cornerRadius = cornerRadius
        firstTitleLabel?.layer.borderWidth = borderWidth
        firstTitleLabel?.layer.borderColor = borderColor
        secondTitleLabel?.layer.cornerRadius = cornerRadius
        secondTitleLabel?.layer.borderWidth = borderWidth
        secondTitleLabel?.layer.borderColor = borderColor
    }
    
    func flash(_ flash: Bool,
               initTitle: String,
               tranTitle: String,
               initColor: UIColor,
               tranColor: UIColor,
               mainButtonOutlet: UIButton?,
               firstTitleLabel: UILabel?,
               secondTitleLabel: UILabel?) {
        
        switch flash {
        case true:
            self.isHidden = false
            mainButtonOutlet?.backgroundColor = initColor
            mainButtonOutlet?.isHidden = false
            mainButtonOutlet?.isEnabled = true
            firstTitleLabel?.text = initTitle
            secondTitleLabel?.text = tranTitle
            firstTitleLabel?.alpha = 1
            secondTitleLabel?.alpha = 0
            mainButtonOutlet?.backgroundColor = tranColor
            
            UIView.animateKeyframes(withDuration: 0.5,
                                    delay: 0,
                                    options: [.autoreverse, .repeat, .allowUserInteraction],
                                    animations: {animateAlert()})
            
            func animateAlert() {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    firstTitleLabel?.alpha = 0
                    mainButtonOutlet?.backgroundColor = initColor
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    secondTitleLabel?.alpha = 1
                    mainButtonOutlet?.backgroundColor = tranColor
                }
            }
            
            
            
        case false:
            self.isHidden = true
        }
        
    }
    
    
    
}
