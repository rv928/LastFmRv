//
//  URLConstant.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


//HostURL

let k_APIHost     = "http://ws.audioscrobbler.com/2.0/"

let k_APIAlbumSearch = "?method=album.search"
let k_APIArtistSearch = "?method=artist.search"

let k_APIAuthKey     = "ad9c4f3897cc062810fa322c07a7d052"

//http://ws.audioscrobbler.com/2.0/?method=album.search&album=believe&api_key=ad9c4f3897cc062810fa322c07a7d052&format=json


struct requestConstants {
    
    static let kGET  = "GET"
    static let kPUT  = "PUT"
    static let kPOST = "POST"
    
    static let kApplicationHeader        =  "application/x-www-form-urlencoded"
    static let kContent                  =  "Content-type"
    static let kJSONContent              =  "application/json; charset=UTF-8"
    static let kAccept                   =  "Accept"
    static let kAcceptType               =  "application/json"
    static let kContentLength            =  "Content-Length"
    static let kauthorization            =  "Authorization"
    static let kContentType              =  "application/json"
}
