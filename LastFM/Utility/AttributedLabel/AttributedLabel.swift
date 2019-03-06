//
//  AttributedLabel.swift
//  LastFM
//
//  Created by Admin on 06/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class AttributedLabel: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setAttributedTextColor(leadingText: nil,trailingText: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAttributedTextColor(leadingText: nil,trailingText: nil)
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
            
            self.attributedText = combination
        }
    }
}
