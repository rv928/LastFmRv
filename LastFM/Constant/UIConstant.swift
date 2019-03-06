//
//  UIConstant.swift
//  LastFM
//


import Foundation
import UIKit

class UIConstant  {

    static let appColor = "#FF6666"
    static let appTextColor = "#000000"
    static let navTextColor = "#FFFFFF"

    struct ProgressHUD {
        static let bgColor = "#FFFFFF"
        static let TextColor = "#A9A9A9"
    }
    
    struct Images {
        static let searchIcon = "icon-search"
        static let noImageSmall = "no-img-small"
        static let noImageMedium = "no-img-medium"
        static let noImageLarge = "no-img-large"
        static let backIcon = "icon-back"
    }
    
    struct Fonts {
        
        static func FONT_HELVETICA_BOLD(_ _size:CGFloat) -> UIFont {
            let font: UIFont = UIFont(name: "Helvetica-Bold", size: _size)!
            return font
        }
        
        static func FONT_HELVETICA_REGULAR(_ _size:CGFloat) -> UIFont {
            let font: UIFont = UIFont(name: "Helvetica", size: _size)!
            return font
        }
    }
}
