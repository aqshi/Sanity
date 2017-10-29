//
//  TransCell.swift
//  Sanity
//
//  Created by Eliseo Monzon on 10/15/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class TransCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}
