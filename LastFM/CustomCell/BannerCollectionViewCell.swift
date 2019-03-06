//
//  BannerCollectionViewCell.swift
//  LastFM
//
//  Created by Admin on 06/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setBannerCellDetails(currentImage:ArtInfoImage?) {
        var imageURL:String = ""
        if currentImage is ArtInfoImage {
            imageURL = (currentImage as! ArtInfoImage).text ?? ""
        }
        let url = URL(string:imageURL)
        bannerImageView.kf.indicatorType = .activity
        bannerImageView.kf.setImage(with: url)
    }
}
