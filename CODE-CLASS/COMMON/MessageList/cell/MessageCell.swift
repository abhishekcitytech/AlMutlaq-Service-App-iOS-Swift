//
//  MessageCell.swift
//  AlMutlaqRealEstate
//
//  Created by Sabnam Nasrin on 19/12/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblSubject: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var lblMessage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
