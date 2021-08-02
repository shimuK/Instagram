//
//  CmntTableViewCell.swift
//  Instagram
//
//  Created by 志村　圭 on 2021/08/02.
//

import UIKit

class CmntTableViewCell: UITableViewCell {

    @IBOutlet weak var cmntLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
