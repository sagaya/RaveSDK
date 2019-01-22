//
//  SaveCardCell.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 10/10/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import UIKit

class SaveCardCell: UITableViewCell {
    @IBOutlet weak var maskCardLabel: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var contentContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
