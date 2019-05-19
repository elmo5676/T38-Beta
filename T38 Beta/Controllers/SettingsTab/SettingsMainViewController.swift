//
//  SettingsMainViewController.swift
//  T38
//
//  Created by elmo on 5/18/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit

class SettingsMainViewController: UIViewController {
    override func viewDidLoad() {
        self.currentDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "toldSettingsViewController")
        self.currentDetailViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.currentDetailViewController!)
        self.addSubview(subView: self.currentDetailViewController!.view, toView: self.detailContainerView)
        super.viewDidLoad()
    }
    
    @IBOutlet weak var detailContainerView: UIView!
    weak var currentDetailViewController: UIViewController?

    @IBOutlet weak var toldSettingsButtonOutlet: UIButton!
    @IBAction func toldSettingsButtonButton(_ sender: UIButton!) {
        sender.showPressed()
        changeChildViewTo("toldSettingsViewController")
    }
    @IBOutlet weak var toldDefaultsButtonOutlet: UIButton!
    @IBAction func toldDefaultsButton(_ sender: UIButton) {
        sender.showPressed()
        changeChildViewTo("toldDefaultsViewController")
    }
    
    @IBOutlet weak var notesButtonOutlet: UIButton!
    @IBAction func notesButton(_ sender: UIButton) {
        sender.showPressed()
        changeChildViewTo("notesViewController")
    }
    @IBOutlet weak var assumptionsButtonButtonOutlet: UIButton!
    @IBAction func assumptionsButton(_ sender: UIButton) {
        sender.showPressed()
        changeChildViewTo("assumptionsViewController")
    }
    
    @IBOutlet weak var howToViewControllerButtonOutlet: UIButton!
    @IBAction func howToViewControllerButton(_ sender: UIButton) {
        sender.showPressed()
        changeChildViewTo("howToViewController")
    }
    @IBOutlet weak var aboutThisAppViewController: UIButton!
    @IBAction func aboutThisAppViewController(_ sender: UIButton) {
        sender.showPressed()
        changeChildViewTo("aboutThisAppViewController")
    }

    

    
    //Copy and Past for additional child container views
//    @IBOutlet weak var <#nameOfNewChildView#>ButtonOutlet: UIButton!
//    @IBAction func <#nameOfNewChildView#>Button(_ sender: UIButton!) {
//        changeChildViewTo("<#childViewControllerId_FromStoryboardInspector#>")
//    }
    
    
    
    
    
    func changeChildViewTo(_ identifier: String) {
        //For currentDetailView
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.cycleFromViewController(oldViewController: self.currentDetailViewController!, toViewController: newViewController!)
        self.currentDetailViewController = newViewController
    }
 
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParent: nil)
        self.addChild(newViewController)
        self.addSubview(subView: newViewController.view, toView: self.detailContainerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.0, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },
                       completion: { finished in
                        oldViewController.view.removeFromSuperview()
                        oldViewController.removeFromParent()
                        newViewController.didMove(toParent: self)
        })
    }

    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
}
