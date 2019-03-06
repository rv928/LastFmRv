//
//  AlbumListViewController.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

let SEARCH_ALBUM_TEXT_COUNT = 3

struct AlbumListCellHeight {
    static let cellHeight = 100
    static let sectionHeight = 44
}

class AlbumListViewController: UIViewController {

    ///Properties : -
    
    @IBOutlet weak var albumListTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var pageIndex:Int = 1
    var isPaging : Bool? = false
    var groupListArray:Array<Group> = Array()
    var albumArray:Array<Album> = Array()
    var artistArray:Array<Artist> = Array()
    var albumCount:Int =  0
    var artistCount:Int =  0

    
    // MARK:- ViewLifeCycle Methods

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
    }
    
    
    // MARK:- UI Methods

    
    func setupUI() {
        self.registerNibs()
        self.setupNavigationBar()
        self.isPaging = false
        self.albumListTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.navTextColor, alpha: 1.0)]
        self.title = "Albums"
    }
    
    func registerNibs() {
        let headerNib = UINib.init(nibName: TagIDConstant.nibs.GroupHeaderView, bundle: Bundle.main)
        albumListTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: TagIDConstant.nibs.GroupHeaderView)
        
        let nib1 = UINib(nibName: TagIDConstant.cellIDs.AlbumListCell, bundle: nil)
        albumListTableView.register(nib1, forCellReuseIdentifier: TagIDConstant.cellIDs.AlbumListCell)
        
        let nib2 = UINib(nibName: TagIDConstant.cellIDs.ArtistListCell, bundle: nil)
        albumListTableView.register(nib2, forCellReuseIdentifier: TagIDConstant.cellIDs.ArtistListCell)
       //ev albumListTableView.rowHeight = UITableView.automaticDimension
       // albumListTableView.estimatedRowHeight = CGFloat(ADDBookingSize.cellheight)
        albumListTableView.tableFooterView = UIView()
    }
    

    //********************
    // MARK:- WebService Methods
    //********************
    
    func callWSToAlbumList(searchString:String?) {
        
        SharedClass.sharedInstance.cancelAllRequest()
        SharedClass.sharedInstance.setActivityIndicatorToTableFooter(table: self.albumListTableView)
        
        var inputDict:Dictionary<String,Any> = Dictionary()
        
        if(searchString?.isBlank == false){
            inputDict[RequestConstant.searchalbum] = searchString
        }
        inputDict[RequestConstant.pageNo] = pageIndex
        inputDict[RequestConstant.pagelimit] = RequestConstant.kPageSize
        
        AlbumManager.album.getAlbumList(vc: self, paramDict: inputDict, onSuccess: { [] (resultList) in
            
            DispatchQueue.main.async { [] in
                if resultList == nil {
                    return
                }
                self.albumCount = Int(resultList!.results!.opensearchtotalResults!) ?? 0
                
                var albumDict:Dictionary<String,Any> = Dictionary()
                SharedClass.sharedInstance.hideActivityIndicatorFromTableFooter(table: self.albumListTableView)

                if self.isPaging == true {
                    self.albumArray = self.albumArray + resultList!.results!.albummatches!.album!
                    for(index,_) in self.groupListArray.enumerated() {
                        let currentGroup:Group = self.groupListArray[index]
                        if currentGroup.groupType == GroupType.album.rawValue {
                            currentGroup.groupObject = self.albumArray
                        }
                    }
                }
                else {
                    albumDict[ResponseConstant.groupType] = GroupType.album.rawValue
                    self.albumArray = resultList!.results!.albummatches!.album!
                    albumDict[ResponseConstant.groupObject] = self.albumArray
                    let albumGroup:Group = Group(dictionary: albumDict)
                    self.groupListArray.append(albumGroup)
                }
                
                self.albumListTableView.reloadData()
                self.callWSToArtistList(searchString: searchString!)
            }
        }, onError: { (apiError) in
            
            DispatchQueue.main.async { [] in
                
                SharedClass.sharedInstance.hideActivityIndicatorFromTableFooter(table: (self.albumListTableView)!)
                
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

    
    func callWSToArtistList(searchString:String?) {
        
       // SharedClass.sharedInstance.cancelAllRequest()
         SharedClass.sharedInstance.setActivityIndicatorToTableFooter(table: self.albumListTableView)
        
        var inputDict:Dictionary<String,Any> = Dictionary()
        
        if(searchString?.isBlank == false){
            inputDict[RequestConstant.searchartist] = searchString
        }
        inputDict[RequestConstant.pageNo] = pageIndex
        inputDict[RequestConstant.pagelimit] = RequestConstant.kPageSize
        
        AlbumManager.album.getArtistList(vc: self, paramDict: inputDict, onSuccess: { [] (resultList) in
            
            DispatchQueue.main.async { [] in
                if resultList == nil {
                    return
                }
                self.artistCount = Int(resultList!.results!.opensearchtotalResults!) ?? 0

            SharedClass.sharedInstance.hideActivityIndicatorFromTableFooter(table: self.albumListTableView)
                
                var artistDict:Dictionary<String,Any> = Dictionary()
                SharedClass.sharedInstance.hideActivityIndicatorFromTableFooter(table: self.albumListTableView)
                
                if self.isPaging == true {
                    self.artistArray = self.artistArray + resultList!.results!.artistmatches!.artist!
                    for(index,_) in self.groupListArray.enumerated() {
                        let currentGroup:Group = self.groupListArray[index]
                        if currentGroup.groupType == GroupType.artist.rawValue {
                            currentGroup.groupObject = self.artistArray
                        }
                    }
                }
                else {
                    artistDict[ResponseConstant.groupType] = GroupType.artist.rawValue
                    self.artistArray = resultList!.results!.artistmatches!.artist!
                    artistDict[ResponseConstant.groupObject] = self.artistArray
                    let albumGroup:Group = Group(dictionary: artistDict)
                    self.groupListArray.append(albumGroup)
                }
                
              self.albumListTableView.reloadData()
            }
        }, onError: { (apiError) in
            
            DispatchQueue.main.async { [] in
                
                 SharedClass.sharedInstance.hideActivityIndicatorFromTableFooter(table: (self.albumListTableView)!)
                
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
}


// MARK:- UITextfield Delegate Methods

extension AlbumListViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if( textField == searchTextField) {
            
            if let text = textField.text {
                
                let updatedTextString = text.replacingCharacters(in: Range(range, in: text)!,with: string)
                
                if updatedTextString.count == 0 || updatedTextString.count >= SEARCH_ALBUM_TEXT_COUNT {
                    self.isPaging = false
                    pageIndex = 1
                   self.groupListArray.removeAll()
                   self.albumListTableView.reloadData()
                   self.callWSToAlbumList(searchString: updatedTextString)
                }
            }
        }
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.groupListArray.removeAll()
        self.albumArray.removeAll()
        self.artistArray.removeAll()
        self.albumCount = 0
        self.artistCount = 0
        self.albumListTableView.reloadData()
      //  self.callWSToAlbumList(searchString: updatedTextString)
        return true
    }
}


// MARK:- UITableView Delegate Methods

extension AlbumListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        if self.groupListArray.count > 0 {
            if (self.groupListArray.count) > 0 {
                tableView.backgroundView = nil
                return self.groupListArray.count
            }
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let currentGroup:Group = self.groupListArray[section]
        
        if currentGroup.groupType == GroupType.album.rawValue {
            let albumArray:Array<Album> = currentGroup.groupObject as! Array<Album>
            return albumArray.count
        }
        else {
            let artistArray:Array<Artist> = currentGroup.groupObject as! Array<Artist>
            return artistArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TagIDConstant.nibs.GroupHeaderView) as? GroupHeaderView ?? GroupHeaderView(reuseIdentifier: TagIDConstant.nibs.GroupHeaderView)
            let currentGroup:Group = self.groupListArray[section]

            if currentGroup.groupType == GroupType.album.rawValue {
                headerView.headerLabel.text = "Albums"
            }
            else {
                headerView.headerLabel.text = "Artists"
            }
            return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return CGFloat(AlbumListCellHeight.sectionHeight)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return CGFloat(AlbumListCellHeight.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentGroup:Group = self.groupListArray[indexPath.section]
        
        if currentGroup.groupType == GroupType.album.rawValue {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.AlbumListCell, for: indexPath) as! AlbumListCell
            let albumArray:Array<Album> = currentGroup.groupObject as! Array<Album>
            cell.setItemDetails(currentAlbum:albumArray[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.ArtistListCell, for: indexPath) as! ArtistListCell
            let artistArray:Array<Artist> = currentGroup.groupObject as! Array<Artist>
            cell.setArtistDetails(currentArtist: artistArray[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


extension AlbumListViewController:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.groupListArray.count == 0 {
            return
        }
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight = Double(abs(diffHeight - frameHeight));
        var offset:Int = 0
        offset = Int(ceil(Double(albumCount+artistCount/RequestConstant.kPageSize)))
        if pullHeight <= 1.0 && pageIndex <= offset {
            print("load more trigger")
            pageIndex = pageIndex + 1
            isPaging = true
            self.callWSToAlbumList(searchString: searchTextField.text)
        }
    }
}
