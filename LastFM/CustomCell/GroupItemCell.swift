//
//  GroupItemCell.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class GroupItemCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setItemDetails(currentAlbum:Album?,currentArtist:Artist?) {
        if currentAlbum != nil {
            self.itemNameLabel.text = currentAlbum?.name
        }
        else {
            self.itemNameLabel.text = currentArtist?.name
        }
    }
}
