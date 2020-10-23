//
//  TableViewCell.swift
//  Bar Charts
//
//  Created by MAK on 10/23/20.
//  Copyright © 2020 MAK. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Day: UILabel!
    @IBOutlet weak var spentMony: UILabel!
    @IBOutlet weak var note: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
