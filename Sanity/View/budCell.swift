//
//  budCell.swift
//  Sanity
//
//  Created by Eliseo Monzon on 10/15/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class budCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        remainingTitle.text = NSLocalizedString("remainingLabelTag", comment: "Tag for remaining text")
        totalLimitTitle.text = NSLocalizedString("totalLimitLabelTag", comment: "Tag for total limit")
        resetTitle.text = NSLocalizedString("resetLabelTag", comment: "Tag for reset label")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var dateReset: UILabel!
    @IBOutlet weak var budName: UILabel!
    @IBOutlet weak var remaining: UILabel!
    @IBOutlet weak var limit: UILabel!
    @IBOutlet weak var remainingTitle: UILabel!
    @IBOutlet weak var totalLimitTitle: UILabel!
    @IBOutlet weak var resetTitle: UILabel!
}
