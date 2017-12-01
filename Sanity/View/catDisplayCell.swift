//
//  catDisplayCell.swift
//  Sanity
//
//  Created by Eliseo Monzon on 10/15/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class catDisplayCell: UITableViewCell {
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        remainingLabel.text = NSLocalizedString("catDisplayCellRemainingTag", comment: "Tag for remaining label")
        spentLabel.text = NSLocalizedString("catDisplayCellSpentTag", comment: "Tag for spent label")
        limitLabel.text = NSLocalizedString("catDisplayCellLimitTag", comment: "Tag for limit label")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var remaining: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var progress: UILabel!
    
}
