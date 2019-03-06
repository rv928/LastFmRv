//
//  AlbumListCell.swift
//  LastFM
//
//  Created by Admin on 06/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {
    
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: AttributedLabel!
    @IBOutlet weak var albumLinkTextView: UITextView!
    @IBOutlet weak var albumImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setAlbumDetails(currentAlbum:Album?) {
        if currentAlbum != nil {
            self.albumLabel.text = currentAlbum?.name
            self.artistLabel.setAttributedTextColor(leadingText: "Artist : ", trailingText: currentAlbum?.artist)
            self.albumLinkTextView.text = currentAlbum?.url
            var currentImage:AlbumImage?
            
            if currentAlbum?.image?.count ?? 0 > 0 {
                for(index,_) in currentAlbum!.image!.enumerated() {
                    let currentObj:AlbumImage = currentAlbum!.image![index]
                    if currentObj.size == ImageSizeType.small.rawValue {
                        currentImage = currentObj
                        break
                    }
                }
                if currentImage != nil {
                    let url = URL(string:currentImage?.text ?? "")
                    albumImageView.kf.indicatorType = .activity
                    albumImageView.kf.setImage(with: url)
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
