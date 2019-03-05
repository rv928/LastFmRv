//
//  ResponseConstant.swift
//  CohesionIB
//


import Foundation


class ResponseConstant  {
    
    //general
    static let responsecode = "code"
    static let data = "data"
    static let message = "msg"
    static let params = "params"
    
    static let groupType = "groupType"
    static let groupObject = "groupObject"
}

enum GroupType:Int {
    case album = 1
    case artist = 2
}

//Global null check

func ifnull(value : Any?) -> String? {
    if value is NSNull || value == nil {
        return ""
    } else {
        return value as? String
    }
}
