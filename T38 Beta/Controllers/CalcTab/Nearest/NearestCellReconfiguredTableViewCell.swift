//
//  NearestCellReconfiguredTableViewCell.swift
//  T38
//
//  Created by Matthew Elmore on 4/26/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

class NearestCellReconfiguredTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    @IBOutlet weak var icaoLabel: UILabel!
    @IBOutlet weak var airfieldName: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet var allLabels: [UILabel]!
    
    
}

