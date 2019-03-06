//
//  AlbumManager.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//


import Foundation
import UIKit

class AlbumManager {
    
    static let album = AlbumManager()
    
    
    // MARK:- get Album List
    func getAlbumList(vc:UIViewController?,paramDict:Dictionary<String,Any>,onSuccess: ((AlbumResultList?) -> Void)? = nil, onError: ((LMAPIError) -> Void)? = nil) {
        
        //http://ws.audioscrobbler.com/2.0/?method=album.search&album=believe&api_key=ad9c4f3897cc062810fa322c07a7d052&format=json
        var finalDict:Dictionary<String,Any> = Dictionary()
        finalDict = paramDict
        finalDict[RequestConstant.apiKey] = k_APIAuthKey
        finalDict[RequestConstant.jsonformat] = "json"
        let url = String(format: "%@%@", k_APIHost,k_APIAlbumSearch)
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        api.request(url: urlString!, method: .get,parameters: finalDict) { response in
            
            if response.code == 200 {
                //                SharedClass.sharedInstance.showProgressHUD(false)
                
                var objResultList:AlbumResultList?
                
                var authInfo: Dictionary<String,Any> = Dictionary()
                authInfo[ResponseConstant.responsecode] = response.code
                
                if (response.body as? Dictionary<String,Any>) != nil {
                    
                    if let jsonData = response.jsonString?.data(using: .utf8) {
                        if let resultList = try? JSONDecoder().decode(AlbumResultList.self, from: jsonData){
                            objResultList = resultList
                        }
                    }
                }
                onSuccess!(objResultList)
            }
            else if response.code == 204 {
                onError!(ErrorManager.onerror.noDataFound)
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            else if response.code == 401 {
                if let data = response.body as? Dictionary<String,Any> {
                    let message:String = data[ResponseConstant.message] as! String
                    //                    SharedClass.sharedInstance.showProgressHUD(false)
                    SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:message, buttonTitle: MessageConstant.commonButtonTitle.ok)
                }
                else {
                    SharedClass.sharedInstance.showProgressHUD(false)
                    SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: MessageConstant.commonButtonTitle.ok)
                }
            }
            else if response.code == 444 {
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            else {
                SharedClass.sharedInstance.showProgressHUD(false)
                onError!(ErrorManager.onerror.unKnownError)
                
                SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: MessageConstant.commonButtonTitle.ok)
            }
        }
    }
    
    
    // MARK:- get Artist List
    
    func getArtistList(vc:UIViewController?,paramDict:Dictionary<String,Any>,onSuccess: ((ArtistResultList?) -> Void)? = nil, onError: ((LMAPIError) -> Void)? = nil) {
        
        //http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=believe&api_key=ad9c4f3897cc062810fa322c07a7d052&format=json
        
        var finalDict:Dictionary<String,Any> = Dictionary()
        finalDict = paramDict
        finalDict[RequestConstant.apiKey] = k_APIAuthKey
        finalDict[RequestConstant.jsonformat] = "json"
        let url = String(format: "%@%@", k_APIHost,k_APIArtistSearch)
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        api.request(url: urlString!, method: .get,parameters: finalDict) { response in
            
            if response.code == 200 {
                //                SharedClass.sharedInstance.showProgressHUD(false)
                
                var objResultList:ArtistResultList?
                
                var authInfo: Dictionary<String,Any> = Dictionary()
                authInfo[ResponseConstant.responsecode] = response.code
                
                if (response.body as? Dictionary<String,Any>) != nil {
                    
                    if let jsonData = response.jsonString?.data(using: .utf8) {
                        if let resultList = try? JSONDecoder().decode(ArtistResultList.self, from: jsonData){
                            objResultList = resultList
                        }
                    }
                }
                onSuccess!(objResultList)
            }
            else if response.code == 204 {
                onError!(ErrorManager.onerror.noDataFound)
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            else if response.code == 401 {
                if let data = response.body as? Dictionary<String,Any> {
                    let message:String = data[ResponseConstant.message] as! String
                    //                    SharedClass.sharedInstance.showProgressHUD(false)
                    SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:message, buttonTitle: MessageConstant.commonButtonTitle.ok)
                }
                else {
                    SharedClass.sharedInstance.showProgressHUD(false)
                    SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: MessageConstant.commonButtonTitle.ok)
                }
            }
            else if response.code == 444 {
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            else {
                SharedClass.sharedInstance.showProgressHUD(false)
                onError!(ErrorManager.onerror.unKnownError)
                
                SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: MessageConstant.commonButtonTitle.ok)
            }
        }
        
    }
    
    
    // MARK:- Get Artist Info
    
    func getArtistInfo(vc:UIViewController?,paramDict:Dictionary<String,Any>,onSuccess: ((ArtistInfo?) -> Void)? = nil, onError: ((LMAPIError) -> Void)? = nil) {
        
        //http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=Disturbed&api_key=ad9c4f3897cc062810fa322c07a7d052&format=json
        
        var finalDict:Dictionary<String,Any> = Dictionary()
        finalDict = paramDict
        finalDict[RequestConstant.apiKey] = k_APIAuthKey
        finalDict[RequestConstant.jsonformat] = "json"
        let url = String(format: "%@%@", k_APIHost,k_APIArtistInfo)
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        api.request(url: urlString!, method: .get,parameters: finalDict) { response in
            
            if response.code == 200 {
                //                SharedClass.sharedInstance.showProgressHUD(false)
                
                var objArtistInfo:ArtistInfo?
                
                var authInfo: Dictionary<String,Any> = Dictionary()
                authInfo[ResponseConstant.responsecode] = response.code
                
                if (response.body as? Dictionary<String,Any>) != nil {
                    
                    if let jsonData = response.jsonString?.data(using: .utf8) {
                        if let result = try? JSONDecoder().decode(ArtistInfo.self, from: jsonData){
                            objArtistInfo = result
                        }
                    }
                }
                onSuccess!(objArtistInfo)
            }
            else if response.code == 204 {
                onError!(ErrorManager.onerror.noDataFound)
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            else if response.code == 401 {
                if let data = response.body as? Dictionary<String,Any> {
                    let message:String = data[ResponseConstant.message] as! String
                    //                    SharedClass.sharedInstance.showProgressHUD(false)
                    SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:message, buttonTitle: MessageConstant.commonButtonTitle.ok)
                }
                else {
                    SharedClass.sharedInstance.showProgressHUD(false)
                    SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: MessageConstant.commonButtonTitle.ok)
                }
            }
            else if response.code == 444 {
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            else {
                SharedClass.sharedInstance.showProgressHUD(false)
                onError!(ErrorManager.onerror.unKnownError)
                
                SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: MessageConstant.commonButtonTitle.ok)
            }
        }
        
    }
}



