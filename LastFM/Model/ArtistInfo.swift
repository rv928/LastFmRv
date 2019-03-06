//
//  ArtistInfo.swift
//  LastFM
//
//  Created by Admin on 06/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct ArtistInfo : Codable {
    let artist : ArtistI?
    
    enum CodingKeys: String, CodingKey {
        
        case artist = "artist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artist = try values.decodeIfPresent(ArtistI.self, forKey: .artist)
    }
}


struct ArtistI : Codable {
    let name : String?
    let mbid : String?
    let url : String?
    let image : [ArtInfoImage]?
    let streamable : String?
    let ontour : String?
    let stats : Stats?
    let similar : Similar?
    let tags : Tags?
    let bio : Bio?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case mbid = "mbid"
        case url = "url"
        case image = "image"
        case streamable = "streamable"
        case ontour = "ontour"
        case stats = "stats"
        case similar = "similar"
        case tags = "tags"
        case bio = "bio"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mbid = try values.decodeIfPresent(String.self, forKey: .mbid)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        image = try values.decodeIfPresent([ArtInfoImage].self, forKey: .image)
        streamable = try values.decodeIfPresent(String.self, forKey: .streamable)
        ontour = try values.decodeIfPresent(String.self, forKey: .ontour)
        stats = try values.decodeIfPresent(Stats.self, forKey: .stats)
        similar = try values.decodeIfPresent(Similar.self, forKey: .similar)
        tags = try values.decodeIfPresent(Tags.self, forKey: .tags)
        bio = try values.decodeIfPresent(Bio.self, forKey: .bio)
    }
}


struct ArtInfoImage : Codable {
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


struct Stats : Codable {
    let listeners : String?
    let playcount : String?
    
    enum CodingKeys: String, CodingKey {
        
        case listeners = "listeners"
        case playcount = "playcount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        listeners = try values.decodeIfPresent(String.self, forKey: .listeners)
        playcount = try values.decodeIfPresent(String.self, forKey: .playcount)
    }
    
}


struct Similar : Codable {
    let artist : [Artist]?
    
    enum CodingKeys: String, CodingKey {
        
        case artist = "artist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artist = try values.decodeIfPresent([Artist].self, forKey: .artist)
    }
    
}


struct Tags : Codable {
    let tag : [Tag]?
    
    enum CodingKeys: String, CodingKey {
        
        case tag = "tag"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag = try values.decodeIfPresent([Tag].self, forKey: .tag)
    }
    
}


struct Tag : Codable {
    let name : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}


struct Bio : Codable {
    let links : Links?
    let published : String?
    let summary : String?
    let content : String?
    
    enum CodingKeys: String, CodingKey {
        
        case links = "links"
        case published = "published"
        case summary = "summary"
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        content = try values.decodeIfPresent(String.self, forKey: .content)
    }
    
}


struct Links : Codable {
    let link : Link?
    
    enum CodingKeys: String, CodingKey {
        
        case link = "link"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        link = try values.decodeIfPresent(Link.self, forKey: .link)
    }
    
}


struct Link : Codable {
    let text : String?
    let rel : String?
    let href : String?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "#text"
        case rel = "rel"
        case href = "href"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        rel = try values.decodeIfPresent(String.self, forKey: .rel)
        href = try values.decodeIfPresent(String.self, forKey: .href)
    }
    
}
