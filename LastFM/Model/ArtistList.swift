//
//  ArtistList.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


struct ArtistResultList : Codable {
    let results : ArtistResults?
    
    enum CodingKeys: String, CodingKey {
        
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent(ArtistResults.self, forKey: .results)
    }
}



struct ArtistResults : Codable {
    let opensearchQuery : ArtistOpensearchQuery?
    let opensearchtotalResults : String?
    let opensearchstartIndex : String?
    let opensearchitemsPerPage : String?
    let artistmatches : Artistmatches?
    let artisitattr : Artistattr?
    
    enum CodingKeys: String, CodingKey {
        
        case opensearchQuery = "opensearch:Query"
        case opensearchtotalResults = "opensearch:totalResults"
        case opensearchstartIndex = "opensearch:startIndex"
        case opensearchitemsPerPage = "opensearch:itemsPerPage"
        case artistmatches = "artistmatches"
        case artisitattr = "@attr"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        opensearchQuery = try values.decodeIfPresent(ArtistOpensearchQuery.self, forKey: .opensearchQuery)
        opensearchtotalResults = try values.decodeIfPresent(String.self, forKey: .opensearchtotalResults)
        opensearchstartIndex = try values.decodeIfPresent(String.self, forKey: .opensearchstartIndex)
        opensearchitemsPerPage = try values.decodeIfPresent(String.self, forKey: .opensearchitemsPerPage)
        artistmatches = try values.decodeIfPresent(Artistmatches.self, forKey: .artistmatches)
        artisitattr = try values.decodeIfPresent(Artistattr.self, forKey: .artisitattr)
    }
}


struct ArtistOpensearchQuery : Codable {
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


struct Artistmatches : Codable {
    let artist : [Artist]?
    
    enum CodingKeys: String, CodingKey {
        
        case artist = "artist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artist = try values.decodeIfPresent([Artist].self, forKey: .artist)
    }
    
}


struct Artist : Codable {
    let name : String?
    let listeners : String?
    let mbid : String?
    let url : String?
    let streamable : String?
    let image : [ArtistImage]?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case listeners = "listeners"
        case mbid = "mbid"
        case url = "url"
        case streamable = "streamable"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        listeners = try values.decodeIfPresent(String.self, forKey: .listeners)
        mbid = try values.decodeIfPresent(String.self, forKey: .mbid)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        streamable = try values.decodeIfPresent(String.self, forKey: .streamable)
        image = try values.decodeIfPresent([ArtistImage].self, forKey: .image)
    }
}

struct ArtistImage : Codable {
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



struct Artistattr : Codable {
    let arfor : String?
    
    enum CodingKeys: String, CodingKey {
        
        case arfor = "for"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        arfor = try values.decodeIfPresent(String.self, forKey: .arfor)
    }
    
}
