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
