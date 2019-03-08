//
//  AlbumDetailViewController.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

struct ArtistInfoCellHeight {
    static let cellHeight = 260
    static let similarCellHeight = 90
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
    @IBOutlet weak var artistTagView: TagListView!
    @IBOutlet weak var tagViewHeightConst: NSLayoutConstraint!
    
    //Bio View
    @IBOutlet weak var bioView: UIView!
    @IBOutlet weak var publishedDateLabel: AttributedLabel!
    @IBOutlet weak var summaryValueTextView: UITextView!
    @IBOutlet weak var contentValueTextView: UITextView!
    @IBOutlet weak var summaryViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeightConst: NSLayoutConstraint!

    var objAlbum:Album?
    var objArtist:Artist?
    var albumbannerArray:Array<ArtInfoImage> = Array()
    var artistInfo:ArtistInfo?
    var similarArtistArray:Array<ArtistI> = Array()
    var tagListArray:Array<Tag> = Array()
    
    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    

    // MARK:- UI Methods
    
    func setupUI() {
        self.registerNibs()
        self.setupNavigationBar()
        self.setUpArtistTagViewUI()
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
        
        let nibSimilar = UINib(nibName: TagIDConstant.cellIDs.SubArtistCell, bundle: nil)
        similarTableView.register(nibSimilar, forCellReuseIdentifier: TagIDConstant.cellIDs.SubArtistCell)
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
                
                SharedClass.sharedInstance.showProgressHUD(false)

                if result == nil {
                    return
                }
                
                self.artistInfo = result
                //print(self.artistInfo?.artist?.bio)
                self.setUpArtistbasicInfo()
                self.fillSimilarArtists()
                self.fillArtistTags()
                self.fillBioInfoView()
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
    
    //**********To fill up artist basic info *************
    
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
    
    
    //**********To Show Similar Artist TableView *************

    
    func fillSimilarArtists() {
        self.similarArtistArray = self.artistInfo!.artist!.similar!.artist!
        self.similarTableView.reloadData()
        self.similarViewHeightConst.constant = self.similarTableView.contentSize.height
    }
    
    //**********To Show Artist Tags *************
    
    func fillArtistTags() {
        self.tagListArray = self.artistInfo!.artist!.tags!.tag!
        self.calculateArtistTagViewHeight()
    }
    
    //**********To Setup Artist TagView *************

    func setUpArtistTagViewUI() {
        artistTagView.textFont = UIConstant.Fonts.FONT_HELVETICA_REGULAR(16.0)
        artistTagView.shadowRadius = 0
        artistTagView.shadowOpacity = 0
        artistTagView.cornerRadius = 5
        artistTagView.tagBackgroundColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.tagBgColor, alpha: 1.0)
        artistTagView.borderColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.tagTextColor, alpha: 1.0)
        artistTagView.enableRemoveButton = false
        artistTagView.delegate = self
    }
    
    
    //**********To Caleculate Artist TagViewHeight *************

    func calculateArtistTagViewHeight() {
        
        for (index,_) in self.tagListArray.enumerated() {
            let currentTag:Tag = self.tagListArray[index]
            self.artistTagView.addTag(currentTag.name!)
        }
        
        if self.tagListArray.count == 0 {
            self.tagViewHeightConst.constant = 0
            tagMainView.isHidden = true
        }
        else {
            tagMainView.isHidden = false
            self.tagViewHeightConst.constant = artistTagView.intrinsicContentSize.height + 70.0
        }
    }
    
    
    //**********To Show Artist Bio  *************
    
    func fillBioInfoView() {
        self.publishedDateLabel.setAttributedTextColor(leadingText: "Published : ", trailingText: self.artistInfo!.artist!.bio!.published!)
        self.summaryValueTextView.attributedText = (self.artistInfo!.artist!.bio!.summary!).html2AttributedString
        self.summaryViewHeightConst.constant = self.summaryValueTextView.contentSize.height
        
        self.contentValueTextView.attributedText = (self.artistInfo!.artist!.bio!.content!).html2AttributedString
        self.contentViewHeightConst.constant = self.contentValueTextView.contentSize.height
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
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(ArtistInfoCellHeight.cellHeight))
    }
}


// MARK:- UITableView Delegate Methods

extension AlbumDetailViewController:UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.similarArtistArray.count
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(ArtistInfoCellHeight.similarCellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.SubArtistCell, for: indexPath) as! SubArtistCell
        cell.setArtistDetails(currentArtist: self.similarArtistArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK:- TagView Delegate Methods

extension AlbumDetailViewController:TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print(title)
        print(tagView.title)
        let currentTag = self.tagListArray.filter{($0.name == title)}.first
        if currentTag != nil {
            UIApplication.shared.open((URL(string: currentTag!.url!))!, options: [:])
        }
    }
}

// MARK:- TextView Delegate Methods

extension AlbumDetailViewController:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
}
