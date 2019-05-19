//
//  AlwaysPopupSeque.swift
//  T38
//
//  Created by elmo on 6/8/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import Foundation
import UIKit

class AlwaysPopupSegue : UIStoryboardSegue, UIPopoverPresentationControllerDelegate
{
    override init(identifier: String?, source: UIViewController, destination: UIViewController)
    {
        super.init(identifier: identifier, source: source, destination: destination)
        destination.modalPresentationStyle = UIModalPresentationStyle.popover
        destination.popoverPresentationController!.delegate = self
        
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
