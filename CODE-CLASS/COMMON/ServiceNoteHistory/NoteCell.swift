//
//  NoteCell.swift
//  AlMutlaqRealEstate
//
//  Created by Sabnam Nasrin on 28/11/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet var lblSlottime: UILabel!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var lbl4: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sizeToFit()
        layoutIfNeeded()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
