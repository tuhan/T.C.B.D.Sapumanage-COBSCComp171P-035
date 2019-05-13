//
//  HomeworkTableViewCell.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/13/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class HomeworkTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var homeworkTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
