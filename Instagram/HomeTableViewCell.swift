//
//  HomeTableViewCell.swift
//  Instagram
//
//  Created by Thomas Clifford on 3/7/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var captionView: UILabel!
    @IBOutlet weak var pictureView: PFImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
