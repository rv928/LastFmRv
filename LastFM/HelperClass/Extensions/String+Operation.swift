//
//  String+Operation.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var isBlank:Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString.isEmpty
    }
}


extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
