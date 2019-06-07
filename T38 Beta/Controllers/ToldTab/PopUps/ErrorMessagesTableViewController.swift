//
//  ErrorMessagesTableViewController.swift
//  T38
//
//  Created by Matthew Elmore on 4/2/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

class ErrorMessagesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(errorMessages)
    }
    
    var errorMessages: [String] = []
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return errorMessages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "errorMessageCell", for: indexPath)
        cell.detailTextLabel?.text = "\(errorMessages[indexPath.row])"
        cell.textLabel?.text = "\(errorMessages[indexPath.row])"
        return cell
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
   
    

}
