//
//  RedViewController.swift
//  T38
//
//  Created by elmo on 5/18/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setFormatting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var keyLabelsLeft: [UILabel]!
    @IBOutlet var valueLabelsRight: [UILabel]!
    
    func setFormatting() {
        for label in keyLabelsLeft {
            label.adjustsFontSizeToFitWidth = true
        }
        for label in valueLabelsRight {
            label.adjustsFontSizeToFitWidth = true
        }}
    
}
