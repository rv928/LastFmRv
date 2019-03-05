//
//  LMAPIManager.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let api = LMAPIManager.shared

struct LMAPIResponse {
    let code: Int
    let body: Any?
    let jsonString: String?
}



class LMAPIManager:NSObject {
    
    static let shared = LMAPIManager()
    
    var manager : Alamofire.SessionManager!
    
    private var defaultHeaders: [String: String] {
        get {
            var headers: [String: String] = [String: String]()
            
            headers[requestConstants.kAccept] = requestConstants.kAcceptType
            headers[requestConstants.kContent] = requestConstants.kContentType
            
            return headers
        }
    }
    
    var backgroundCompletionHandler: (() -> Void)? {
        get {
            return manager?.backgroundCompletionHandler
        }
        set {
            manager?.backgroundCompletionHandler = newValue
        }
    }
    
    
    fileprivate override init() {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.admin.lastfm")
        configuration.timeoutIntervalForRequest = 2000 // seconds
        //configuration.timeoutIntervalForResource = 2000
        self.manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    
    func request(url: String, method: HTTPMethod, headers: [String: String]? = nil, parameters: Any? = nil, completionHandler: ((LMAPIResponse) -> Void)? = nil) {
        
        SharedClass.sharedInstance.hasConnectivity(completion: { (checkConnection:String?) -> Void in
            
            if  checkConnection == "Not reachable" {
                print("Internet connection FAILED")
                completionHandler?(LMAPIResponse(code: 403, body: ErrorManager.onerror.networkError, jsonString: ""))
                return
            }
        })
        
        var apiHeaders = defaultHeaders
        if let dict = headers {
            for key in dict.keys {
                apiHeaders[key] = dict[key]
            }
        }
        
        // let manager = Alamofire.SessionManager.default
        //   manager.session.configuration.timeoutIntervalForRequest = 10
        //   manager.session.configuration.timeoutIntervalForResource = 10
        manager.session.configuration.httpMaximumConnectionsPerHost = 10
        manager.delegate.taskWillPerformHTTPRedirection = nil
        
        var dataRequest: DataRequest?
        
        print("====================================================================================",method,Date())
        print("====================================================================================",headers as Any)
        
        
        if method == .get || method == .delete  {
            if parameters != nil && method == .delete {
                
                if let body = parameters {
                    var reqst = try? URLRequest(url: url, method: method, headers: apiHeaders)
                    reqst?.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                    reqst?.setValue(requestConstants.kContentType, forHTTPHeaderField: requestConstants.kContent)
                    print("====================================================================================",method,reqst as Any,Date())
                    
                    if let value = reqst {
                        // dataRequest = Alamofire.request(value).validate(contentType: [requestConstants.kContentType])
                        dataRequest = Alamofire.request(value).validate()
                    }
                }
                
            }else{
                print("====================================================================================",method,Date())
                
                // dataRequest = manager.request(url, method: method, parameters: (parameters as? [String: Any]), encoding: URLEncoding.default, headers: apiHeaders).validate(contentType: [requestConstants.kContentType])
                
                dataRequest = manager.request(url, method: method, parameters: (parameters as? [String: Any]), encoding: URLEncoding.default, headers: apiHeaders).validate()
                
            }
        }
        else {
            if let body = parameters {
                var reqst = try? URLRequest(url: url, method: method, headers: apiHeaders)
                reqst?.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                print("======= %@",reqst?.description ?? "")
                if let value = reqst {
                    dataRequest = Alamofire.request(value)
                }
            }
            else {
                // dataRequest = manager.request(url, method: method, parameters: (parameters as? [String: Any]), encoding: URLEncoding.default, headers: apiHeaders).validate(contentType: [requestConstants.kContentType])
                dataRequest = manager.request(url, method: method, parameters: (parameters as? [String: Any]), encoding: URLEncoding.default, headers: apiHeaders).validate()
            }
        }
        
        dataRequest?.responseJSON { response in
            print("====================================================================================%@",method,Date())
            print("Request url => ", url)
            if let requestHeaders = headers {
                let headerData = try? JSONSerialization.data(withJSONObject: requestHeaders, options: .prettyPrinted)
                if let data = headerData, let json = String(data: data, encoding: .utf8) {
                    print("Request headers => ", json)
                }
            }
            
            if let requestBody = parameters {
                let bodyData = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
                if let data = bodyData, let json = String(data: data, encoding: .utf8) {
                    print("Request body => ", json)
                }
            }
            
            let statusCode: Int = (response.response?.statusCode ?? 444)
            print("Status code => ", String(format: "%d", statusCode))
            var jsonString:String = ""
            if let data = response.data, let json = String(data: data, encoding: .utf8) {
                print("Response body => ", json)
                jsonString = json
            }
            print("====================================================================================")
            
            switch response.result {
            case .success:
                completionHandler?(LMAPIResponse(code: statusCode, body: response.result.value, jsonString: jsonString))
            case .failure(let error):
                let unkownError = LMAPIError.UnknownError(LMError(title: Constant.APP_NAME, description: error.localizedDescription))
                completionHandler?(LMAPIResponse(code: statusCode, body: unkownError, jsonString: ""))
            }
        }
    }
   
    
}
