//
//  TagIDConstant.swift
//  LastFM
//


import Foundation
import UIKit

class TagIDConstant  {

    struct storyBoardIDs {
    
        static let storyboard = UIStoryboard(name: "Album", bundle: nil)
        
        static let kIden_LoginVC            = "LoginViewController"
        
    }

    struct cellIDs {
        static let AlbumListCell = "AlbumListCell"
        static let ArtistListCell = "ArtistListCell"
    }
    
    struct nibs {
        static let GroupHeaderView = "GroupHeaderView"
    }
    
    struct Tags {
        static let kGradientView = 1000
    }
}
