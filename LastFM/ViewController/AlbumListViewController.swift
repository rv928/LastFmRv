//
//  AlbumListViewController.swift
//  LastFM
//
//  Created by Admin on 05/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

let SEARCH_ALBUM_TEXT_COUNT = 6

struct AlbumListCellHeight {
    static let cellHeight = 100
}

class AlbumListViewController: UIViewController {

    ///Properties : -
    
    @IBOutlet weak var albumListTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var pageIndex:Int = 1
    var isPaging : Bool? = false
    var groupListArray:Array<Group> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.registerNibs()
    }
    
    
    func registerNibs() {
        let headerNib = UINib.init(nibName: TagIDConstant.nibs.GroupHeaderView, bundle: Bundle.main)
        albumListTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: TagIDConstant.nibs.GroupHeaderView)
        
        let nib = UINib(nibName: TagIDConstant.cellIDs.GroupItemCell, bundle: nil)
        albumListTableView.register(nib, forCellReuseIdentifier: TagIDConstant.cellIDs.GroupItemCell)
       // albumListTableView.rowHeight = UITableView.automaticDimension
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
                var albumDict:Dictionary<String,Any> = Dictionary()
                albumDict[ResponseConstant.groupType] = GroupType.album.rawValue
                albumDict[ResponseConstant.groupObject] = resultList?.results?.albummatches
                let albumGroup:Group = Group(dictionary: albumDict)
                self.groupListArray.append(albumGroup)
                SharedClass.sharedInstance.hideActivityIndicatorFromTableFooter(table: self.albumListTableView)
                
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
                var artistDict:Dictionary<String,Any> = Dictionary()
                artistDict[ResponseConstant.groupType] = GroupType.artist.rawValue
                artistDict[ResponseConstant.groupObject] = resultList?.results?.artistmatches
                let artistGroup:Group = Group(dictionary: artistDict)
                self.groupListArray.append(artistGroup)
            SharedClass.sharedInstance.hideActivityIndicatorFromTableFooter(table: self.albumListTableView)
                
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
                   // dictNotificationList.removeAll()
                   // self.albumListTableView.reloadData()
                    self.callWSToAlbumList(searchString: updatedTextString)
                }
            }
        }
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        self.callWebService(searchText: "")
        return true
    }
}


// MARK:- UITableView Delegate Methods

extension AlbumListViewController:UITableViewDelegate,UITableViewDataSource {
    
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
            let currentItemList:Albummatches = currentGroup.groupObject as! Albummatches
            return currentItemList.album?.count ?? 0
        }
        else {
            let currentItemList:Artistmatches = currentGroup.groupObject as! Artistmatches
            return currentItemList.artist?.count ?? 0
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
       return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.GroupItemCell, for: indexPath) as! GroupItemCell
       
        let currentGroup:Group = self.groupListArray[indexPath.section]
        
        if currentGroup.groupType == GroupType.album.rawValue {
            let currentItemList:Albummatches = currentGroup.groupObject as! Albummatches
            cell.setItemDetails(currentAlbum: currentItemList.album?[indexPath.row], currentArtist: nil)
        }
        else {
            let currentItemList:Artistmatches = currentGroup.groupObject as! Artistmatches
            cell.setItemDetails(currentAlbum: nil, currentArtist: currentItemList.artist?[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
