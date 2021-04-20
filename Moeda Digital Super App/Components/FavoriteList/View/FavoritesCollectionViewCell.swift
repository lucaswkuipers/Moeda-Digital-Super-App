//
//  FavoritesCollectionViewCell.swift
//  Moeda Digital Super App
//
//  Created by Tabata Sabrina Sutili on 19/04/21.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameCoin: UILabel!
    @IBOutlet weak var siglaCoin: UILabel!
    @IBOutlet weak var priceCoin: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
	@IBOutlet weak var cellBackgroundImage: UIView!
	
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

