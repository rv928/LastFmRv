//
//  AlbumDetailViewController.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

struct BannerCollectionCellHeight {
    static let cellHeight = 260
}

class AlbumDetailViewController: UIViewController {

    ///Properties : -
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bannerCollectioView: UICollectionView!
    @IBOutlet weak var subLabel: AttributedLabel!
    @IBOutlet weak var albumLinkTextView: UITextView!
    var objAlbum:Album?
    var objArtist:Artist?
    var albumbannerArray:Array<Any> = Array()
    var artistbannerArray:Array<ArtistImage> = Array()
    
    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    

    // MARK:- UI Methods
    
    func setupUI() {
        self.registerNibs()
        self.setupNavigationBar()
        
        if self.objAlbum != nil {
            self.subLabel.setAttributedTextColor(leadingText: "Artist : ", trailingText: objAlbum?.artist)
            self.albumLinkTextView.text = objAlbum?.url
           // albumbannerArray = self.objAlbum!.image!
            var currentImage:AlbumImage?

            if objAlbum?.image?.count ?? 0 > 0 {
                for(index,_) in objAlbum!.image!.enumerated() {
                    let currentObj:AlbumImage = objAlbum!.image![index]
                    if currentObj.size == ImageSizeType.large.rawValue {
                        currentImage = currentObj
                        break
                    }
                }
            }
            
            if currentImage != nil {
                self.albumbannerArray.removeAll()
                self.albumbannerArray.append(currentImage!)
            }
        }
        else {
            self.subLabel.setAttributedTextColor(leadingText: "Listeners : ", trailingText: objArtist?.listeners)
            self.albumLinkTextView.text = objArtist?.url
           // albumbannerArray = self.objArtist!.image!
            var currentImage:ArtistImage?

            if objArtist?.image?.count ?? 0 > 0 {
                for(index,_) in objArtist!.image!.enumerated() {
                    let currentObj:ArtistImage = objArtist!.image![index]
                    if currentObj.size == ImageSizeType.large.rawValue {
                        currentImage = currentObj
                        break
                    }
                }
            }
            if currentImage != nil {
                self.albumbannerArray.removeAll()
                self.albumbannerArray.append(currentImage!)
            }
        }

        self.pageControl.numberOfPages = albumbannerArray.count
        self.pageControl.currentPage = 0
        
        self.bannerCollectioView.reloadData()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.navTextColor, alpha: 1.0)]
        
        if self.objAlbum != nil {
            self.title = objAlbum?.name!
        }
        else {
            self.title = objArtist?.name!
        }
        
    }
   
    func registerNibs() {
        let nib3 = UINib(nibName: TagIDConstant.cellIDs.BannerCollectionViewCell, bundle: nil)
        bannerCollectioView.register(nib3, forCellWithReuseIdentifier: TagIDConstant.cellIDs.BannerCollectionViewCell)
    }
    
}


// MARK:- UICollectionView Delegates Methods

extension AlbumDetailViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albumbannerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagIDConstant.cellIDs.BannerCollectionViewCell, for: indexPath as IndexPath) as! BannerCollectionViewCell
        let objAlbumImage:Any = self.albumbannerArray[indexPath.row]
        cell.setBannerCellDetails(currentImage: objAlbumImage)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(BannerCollectionCellHeight.cellHeight))
    }
}
