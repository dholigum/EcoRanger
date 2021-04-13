//
//  CreditPopUpTableViewCell.swift
//  EcoRanger
//
//  Created by Samlo Berutu on 12/04/21.
//

import UIKit

class CreditPopUpTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var creditTitel: UILabel!
    @IBOutlet weak var creditLink: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
