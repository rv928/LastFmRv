//
//  ArtistListCell.swift
//  LastFM
//
//  Created by Admin on 06/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ArtistListCell: UITableViewCell {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var listenerCountLabel: AttributedLabel!
    @IBOutlet weak var artistLinkTextView: UITextView!
    @IBOutlet weak var artistImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setArtistDetails(currentArtist:Artist?) {
        if currentArtist != nil {
            self.artistLabel.text = currentArtist?.name
            self.listenerCountLabel.setAttributedTextColor(leadingText: "Listeners : ", trailingText: currentArtist?.listeners)
            self.artistLinkTextView.text = currentArtist?.url
            var currentImage:ArtistImage?

            if currentArtist?.image?.count ?? 0 > 0 {
                for(index,_) in currentArtist!.image!.enumerated() {
                    let currentObj:ArtistImage = currentArtist!.image![index]
                    if currentObj.size == ImageSizeType.small.rawValue {
                        currentImage = currentObj
                        break
                    }
                }
                if currentImage != nil {
                    let url = URL(string:currentImage?.text ?? "")
                    artistImageView.kf.indicatorType = .activity
                    artistImageView.kf.setImage(with: url)
                }
                else {
                    imageView?.image = UIImage(named: UIConstant.Images.noImageSmall)
                }
            }
            else {
                imageView?.image = UIImage(named: UIConstant.Images.noImageSmall)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
}
