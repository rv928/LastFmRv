//
//  GroupList.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


class Group {
    
    var groupType:Int?
    var groupObject:Any?
    
    init(dictionary: Dictionary<String,Any>) {
        
        if dictionary.isEmpty == false {
            groupType = dictionary[ResponseConstant.groupType] as? Int
            groupObject = dictionary[ResponseConstant.groupObject]
        }
    }
}
