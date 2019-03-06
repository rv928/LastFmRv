//
//  BorderTextField.swift
//  LastFM


import UIKit

class SearchBorderTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setBorderAndColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBorderAndColor()
    }
   
    
    func setBorderAndColor() {
        
        let borderColor = (SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)).cgColor
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.autocapitalizationType = .sentences

        let leftImageViewSearch:UIImageView = UIImageView(frame: CGRect(x: 12, y: 2, width: 16, height: 16))
        leftImageViewSearch.image = UIImage(named: UIConstant.Images.searchIcon)
        leftImageViewSearch.image = leftImageViewSearch.image?.tint(with: SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0))
        let viewSearch = UIView(frame : CGRect(x: 0, y: 0, width: 40, height: 20))
        viewSearch.addSubview(leftImageViewSearch)
        
        self.leftView = viewSearch
        self.leftViewMode = .always
        self.backgroundColor = .clear

        self.textColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appTextColor, alpha: 1.0)
        self.clearButtonMode = .whileEditing
        self.autocorrectionType = .no
    }
}
