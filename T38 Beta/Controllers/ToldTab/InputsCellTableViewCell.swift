//
//  InputsCellTableViewCell.swift
//  T38
//
//  Created by Matthew Elmore on 4/24/19.
//  Copyright © 2019 elmo. All rights reserved.
//

import UIKit

class InputsCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var backroundCellView: UIView!

}
