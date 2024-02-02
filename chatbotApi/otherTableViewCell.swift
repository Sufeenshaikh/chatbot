//
//  otherTableViewCell.swift
//  chatbotApi
//
//  Created by Rohit Dhakad on 02/11/23.
//

//
//  otherTableViewCell.swift
//  messenger
//
//  Created by Rohit Dhakad on 05/10/23.
//

import UIKit

class otherTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    
    @IBOutlet var otherMsgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 12.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

