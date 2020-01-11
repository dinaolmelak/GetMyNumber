//
//  PlayingNumberCell.swift
//  GetMyNumber
//
//  Created by Center for Innovation on 1/7/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit

class PlayingNumberCell: UITableViewCell {

    @IBOutlet weak var guessNumLabel: UILabel!
    @IBOutlet weak var groupNumLabel: UILabel!
    @IBOutlet weak var orderNumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setGroupAndOrder(Group group: String, Order order: String){
        groupNumLabel.text = group
        orderNumLabel.text = order
    }
}
