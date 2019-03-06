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
    
    //Banner View
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bannerCollectioView: UICollectionView!
  
    
    //Artist Basic Info
    @IBOutlet weak var artbasicInfoView: UIView!
    @IBOutlet weak var subLabel: AttributedLabel!
    @IBOutlet weak var albumLinkTextView: UITextView!
    @IBOutlet weak var listenerCountLabel: AttributedLabel!
    @IBOutlet weak var playCountLabel: AttributedLabel!
    
    //Similar Artists
    @IBOutlet weak var similarArtistView: UIView!
    @IBOutlet weak var similarTableView: UITableView!
    @IBOutlet weak var similarViewHeightConst: NSLayoutConstraint!
    
    //TagView
    @IBOutlet weak var tagMainView: UIView!
    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var tagViewHeightConst: NSLayoutConstraint!
    
    //Bio View
    @IBOutlet weak var bioView: UIView!
    @IBOutlet weak var publishedDateLabel: AttributedLabel!
    @IBOutlet weak var summaryValueLabel: UILabel!
    
    var objAlbum:Album?
    var objArtist:Artist?
    var albumbannerArray:Array<ArtInfoImage> = Array()
    var artistInfo:ArtistInfo?
    var similarArtistArray:Array<Artist> = Array()
    
    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    

    // MARK:- UI Methods
    
    func setupUI() {
        self.registerNibs()
        self.setupNavigationBar()
        /*
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
        */
        
        if self.objAlbum != nil {
            self.callWSToArtistInfo(artistName: self.objAlbum?.artist)
        }
        else {
            self.callWSToArtistInfo(artistName: self.objArtist?.name)
        }
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
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named:UIConstant.Images.backIcon), for: .normal)
        button.addTarget(self, action: #selector(self.backClicked), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
   
    @objc func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerNibs() {
        let nib3 = UINib(nibName: TagIDConstant.cellIDs.BannerCollectionViewCell, bundle: nil)
        bannerCollectioView.register(nib3, forCellWithReuseIdentifier: TagIDConstant.cellIDs.BannerCollectionViewCell)
    }
    
    //********************
    // MARK:- WebService Methods
    //********************
    
    func callWSToArtistInfo(artistName:String?) {
        
       SharedClass.sharedInstance.showProgressHUD(true)
        
        var inputDict:Dictionary<String,Any> = Dictionary()
        inputDict[RequestConstant.artistName] = artistName
        
        AlbumManager.album.getArtistInfo(vc: self, paramDict: inputDict, onSuccess: { [] (result) in
            
            DispatchQueue.main.async { [] in
                if result == nil {
                    return
                }
                self.artistInfo = result
                //print(self.artistInfo?.artist?.bio)
                self.setUpArtistbasicInfo()
            }
        }, onError: { (apiError) in
            
            DispatchQueue.main.async { [] in
                
                SharedClass.sharedInstance.showProgressHUD(false)
                switch apiError {
                case .AuthenticationError( _):
                    break
                case .UnknownError( _):
                    break
                case .NoDataFound(_):
                    break
                case .AlreadyExists(_):
                    break
                }
            }
        })
    }
    
    
    func setUpArtistbasicInfo() {
        self.subLabel.setAttributedTextColor(leadingText: "Artist : ", trailingText: self.artistInfo?.artist?.name)
        self.albumLinkTextView.text = self.artistInfo?.artist?.url

        var currentImage:ArtInfoImage?
        
        if self.artistInfo!.artist!.image?.count ?? 0 > 0 {
            for(index,_) in self.artistInfo!.artist!.image!.enumerated() {
                let currentObj:ArtInfoImage = self.artistInfo!.artist!.image![index]
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
        self.bannerCollectioView.reloadData()
        
        self.listenerCountLabel.setAttributedTextColor(leadingText: "Listeners : ", trailingText: self.artistInfo!.artist!.stats!.listeners)

        self.playCountLabel.setAttributedTextColor(leadingText: "PlayCount : ", trailingText: self.artistInfo!.artist!.stats!.playcount)

    }
    
    
    func fillSimilarArtists() {
       // self.similarArtistArray = self.artistInfo?.artist?.similar?.artist
    }
}


// MARK:- UICollectionView Delegates Methods

extension AlbumDetailViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albumbannerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagIDConstant.cellIDs.BannerCollectionViewCell, for: indexPath as IndexPath) as! BannerCollectionViewCell
        let objAlbumImage:ArtInfoImage = self.albumbannerArray[indexPath.row]
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


// MARK:- UITableView Delegate Methods
/*
extension AlbumDetailViewController:UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.similarArtistArray.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(AlbumListCellHeight.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.SubArtistCell, for: indexPath) as! SubArtistCell
        cell.setArtistDetails(currentArtist: self.similarArtistArray[indexPath.row])
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
}

*/
