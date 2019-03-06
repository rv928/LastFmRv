//
//  TagIDConstant.swift
//  LastFM
//


import Foundation
import UIKit

class TagIDConstant  {

    struct storyBoardIDs {
    
        static let storyboard = UIStoryboard(name: "Album", bundle: nil)
        
        static let kAlbumListViewController   = "AlbumListViewController"
        static let kAlbumDetailViewController = "AlbumDetailViewController"
    }

    struct cellIDs {
        static let AlbumListCell = "AlbumListCell"
        static let ArtistListCell = "ArtistListCell"
        static let BannerCollectionViewCell = "BannerCollectionViewCell"
        static let SubArtistCell = "SubArtistCell"
    }
    
    struct nibs {
        static let GroupHeaderView = "GroupHeaderView"
    }
    
    struct Tags {
        static let kGradientView = 1000
    }
}
