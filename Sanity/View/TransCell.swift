//
//  TransCell.swift
//  Sanity
//
//  Created by Eliseo Monzon on 10/15/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class TransCell: UITableViewCell {
    @IBOutlet weak var onLabel: UILabel!
    @IBOutlet weak var moneySignLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onLabel.text = NSLocalizedString("onLabelTag", comment: "tag for onLabel")
        moneySignLabel.text = NSLocalizedString("moneySignLabelTag", comment: "tag for moneySignLabel")
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
