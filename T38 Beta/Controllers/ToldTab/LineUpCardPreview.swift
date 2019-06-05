//
//  LineUpCardPreview.swift
//  T38 Beta
//
//  Created by Matthew Elmore on 6/4/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import UIKit
import WebKit

class LineUpCardPreview: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadPage(html: lineUpCardHtml)
    }

    var lineUpCardHtml = ""
    
    @IBOutlet weak var lineUpCardPreview: WKWebView!
    @IBAction func backBarButton(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func printBarButton(_ sender: UIBarButtonItem) {
        HTMLHandler().exportHTMLContentToPDF(HTMLContent: lineUpCardHtml, view: self)
    }
    
    
    func loadPage(html: String) {
        lineUpCardPreview.loadHTMLString(html, baseURL: nil)
    }
    
    
}
