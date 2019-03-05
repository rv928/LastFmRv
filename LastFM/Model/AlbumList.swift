//
//  AlbumList.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct AlbumResultList : Codable {
    let results : AlbumResults?
    
    enum CodingKeys: String, CodingKey {
        
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent(AlbumResults.self, forKey: .results)
    }
    
}


struct AlbumOpensearchQuery : Codable {
    let text : String?
    let role : String?
    let searchTerms : String?
    let startPage : String?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "#text"
        case role = "role"
        case searchTerms = "searchTerms"
        case startPage = "startPage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        searchTerms = try values.decodeIfPresent(String.self, forKey: .searchTerms)
        startPage = try values.decodeIfPresent(String.self, forKey: .startPage)
    }
    
}


struct AlbumResults : Codable {
    let opensearchQuery : AlbumOpensearchQuery?
    let opensearchtotalResults : String?
    let opensearchstartIndex : String?
    let opensearchitemsPerPage : String?
    let albummatches : Albummatches?
    let currentattr : Albumattr?
    
    enum CodingKeys: String, CodingKey {
        
        case opensearchQuery = "opensearch:Query"
        case opensearchtotalResults = "opensearch:totalResults"
        case opensearchstartIndex = "opensearch:startIndex"
        case opensearchitemsPerPage = "opensearch:itemsPerPage"
        case albummatches = "albummatches"
        case currentattr = "@attr"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        opensearchQuery = try values.decodeIfPresent(AlbumOpensearchQuery.self, forKey: .opensearchQuery)
        opensearchtotalResults = try values.decodeIfPresent(String.self, forKey: .opensearchtotalResults)
        opensearchstartIndex = try values.decodeIfPresent(String.self, forKey: .opensearchstartIndex)
        opensearchitemsPerPage = try values.decodeIfPresent(String.self, forKey: .opensearchitemsPerPage)
        albummatches = try values.decodeIfPresent(Albummatches.self, forKey: .albummatches)
        currentattr = try values.decodeIfPresent(Albumattr.self, forKey: .currentattr)
    }
    
}



struct Albummatches : Codable {
    let album : [Album]?
    
    enum CodingKeys: String, CodingKey {
        
        case album = "album"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        album = try values.decodeIfPresent([Album].self, forKey: .album)
    }
    
}


struct Album : Codable {
    let name : String?
    let artist : String?
    let url : String?
    let image : [AlbumImage]?
    let streamable : String?
    let mbid : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case artist = "artist"
        case url = "url"
        case image = "image"
        case streamable = "streamable"
        case mbid = "mbid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        artist = try values.decodeIfPresent(String.self, forKey: .artist)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        image = try values.decodeIfPresent([AlbumImage].self, forKey: .image)
        streamable = try values.decodeIfPresent(String.self, forKey: .streamable)
        mbid = try values.decodeIfPresent(String.self, forKey: .mbid)
    }
}


struct AlbumImage : Codable {
    let text : String?
    let size : String?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "#text"
        case size = "size"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        size = try values.decodeIfPresent(String.self, forKey: .size)
    }
    
}


struct Albumattr : Codable {
    let afor : String?
    
    enum CodingKeys: String, CodingKey {
        
        case afor = "for"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        afor = try values.decodeIfPresent(String.self, forKey: .afor)
    }
    
}
