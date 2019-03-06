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
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLinkTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setItemDetails(currentAlbum:Album?) {
        if currentAlbum != nil {
            self.albumLabel.text = currentAlbum?.name
            self.setAttributedTextColor(leadingText: "Artist : ", trailingText: currentAlbum?.artist)
            self.albumLinkTextView.text = currentAlbum?.url
        }
    }
    
    func setAttributedTextColor(leadingText:String?,trailingText:String?) {
        
        if leadingText != nil && trailingText != nil {
            
            let normalColor:UIColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appTextColor, alpha: 0.7)
            
            let highlightedColor:UIColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appTextColor, alpha: 1.0)
            
            let attributesForLeading = [NSAttributedString.Key.font:UIConstant.Fonts.FONT_HELVETICA_REGULAR(14.0),
                                        NSAttributedString.Key.foregroundColor:normalColor] as [NSAttributedString.Key : Any]
            
            let leadingString : NSMutableAttributedString = NSMutableAttributedString(string: leadingText!, attributes: attributesForLeading)
            
            let attributesForTrailing = [NSAttributedString.Key.font:UIConstant.Fonts.FONT_HELVETICA_REGULAR(14.0),
                                         NSAttributedString.Key.foregroundColor:highlightedColor] as [NSAttributedString.Key : Any]
            
            let trailingString : NSMutableAttributedString = NSMutableAttributedString(string: trailingText!, attributes: attributesForTrailing)
            
            let combination = NSMutableAttributedString()
            combination.append(leadingString)
            combination.append(trailingString)
            
            self.artistLabel.attributedText = combination
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
}
