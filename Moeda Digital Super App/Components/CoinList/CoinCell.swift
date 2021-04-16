//
//  TelaTableViewCell.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 14/04/2021.
//

import UIKit

class CoinCell: UITableViewCell {
	
	@IBOutlet weak var coinNameLabel: UILabel!
	@IBOutlet weak var coinIDLabel: UILabel!
	@IBOutlet weak var coinValueLabel: UILabel!
	@IBOutlet weak var coinIconImageView: UIImageView!
	@IBOutlet weak var coinsFavoriteStarImageView: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
