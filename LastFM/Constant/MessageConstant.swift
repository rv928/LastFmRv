//
//  MessageConstant.swift
//  LastFM

import UIKit

class MessageConstant {

    struct validationMessage {
     
        static let OPERATIONAL_ERROR = "Server is not responding.  Please try again later."
        static let NO_CONTENT = "No Content Found."
    }
    
    struct commonMessage {
        static let tokenExpire = "The access token provided has been expired"
        static let authError   = "You are not authorized."
        static let alreadyExistMessage = "This record already exists"
        static let interConn   = "Make sure your device is connected to the internet"
    }
    
    struct commonButtonTitle {
        static let ok = "OK"
        static let yes = "Yes"
        static let no = "No"
        static let delete = "Delete"
        static let restore = "Restore"
        static let cancel = "Cancel"
        static let noThanks = "No Thanks"
    }
}

