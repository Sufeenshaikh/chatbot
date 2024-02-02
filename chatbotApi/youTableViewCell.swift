//
//  youTableViewCell.swift
//  messenger
//
//  Created by Rohit Dhakad on 04/10/23.
//

import UIKit

class youTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    
    @IBOutlet var youMsgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 12.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
