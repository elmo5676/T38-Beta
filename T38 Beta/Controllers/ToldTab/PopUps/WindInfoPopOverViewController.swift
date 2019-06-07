//
//  WindInfoPopOverViewController.swift
//  T38
//
//  Created by elmo on 6/7/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit

class WindInfoPopOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setFormatting(views: windColors)

    }
    @IBOutlet weak var dismissButton: UIBarButtonItem!
    @IBAction func dismissButton(_ sender: UIBarButtonItem) {
       presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let fittedSize = mainStackView?.sizeThatFits(UIView.layoutFittingCompressedSize) {
            preferredContentSize = CGSize(width: fittedSize.width + 30, height: fittedSize.height + 50)
        }
    }
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet var windColors: [UIView]!
    
    func setFormatting(views: [UIView]){
        for view in views {
            view.layer.cornerRadius = 5
            view.layer.borderWidth = 2
            view.layer.borderColor = #colorLiteral(red: 0.1743554771, green: 0.2159466445, blue: 0.2749094963, alpha: 1)
        }
    }
 

}
