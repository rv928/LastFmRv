//
//  ErrorManager.swift
//  LastFM
//


import Foundation

struct LMError {
    let title: String
    let description: String
}

enum LMAPIError : Error {
    case AuthenticationError(LMError)
    case UnknownError(LMError)
    case NoDataFound(LMError)
    case AlreadyExists(LMError)
}

class ErrorManager {
    
    static let onerror : ErrorManager = {
        let instance = ErrorManager()
        return instance
    }()
    
    var authenticationError: LMAPIError {
        get {
            return LMAPIError.AuthenticationError(LMError(title:Constant.APP_NAME, description: MessageConstant.commonMessage.tokenExpire))
        }
    }
    
    var accessDeniedError: LMAPIError {
        get {
            return LMAPIError.UnknownError(LMError(title: Constant.APP_NAME, description: MessageConstant.commonMessage.authError))
        }
    }
    var noDataFound: LMAPIError {
        get {
            return LMAPIError.NoDataFound((LMError(title: Constant.APP_NAME, description: MessageConstant.commonMessage.authError)))
        }
    }

    var unKnownError: LMAPIError {
        get {
            return LMAPIError.UnknownError(LMError(title: Constant.APP_NAME, description: MessageConstant.commonMessage.authError))
        }
    }

    var alreadyExistsError: LMAPIError {
        get {
            return LMAPIError.AuthenticationError(LMError(title:Constant.APP_NAME, description: MessageConstant.commonMessage.alreadyExistMessage))
        }
    }
    
    var networkError: LMAPIError {
        get {
            DispatchQueue.main.async {
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            return LMAPIError.UnknownError(LMError(title: Constant.APP_NAME, description: MessageConstant.commonMessage.interConn))
        }
    }
    
   
}
