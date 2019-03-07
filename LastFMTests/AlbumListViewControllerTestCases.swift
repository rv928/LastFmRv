//
//  AlbumListViewControllerTestCases.swift
//  LastFMTests
//
//  Created by Admin on 07/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
@testable import LastFM

class AlbumListViewControllerTestCases: XCTestCase {

    var controller: AlbumListViewController!
    var tableView: UITableView!
    var delegate: UITableViewDelegate!
    var groupListArray:Array<Group> = Array()
    
    override func setUp() {
       
        guard let nav = UIStoryboard(name: "Album", bundle: Bundle(for: AlbumListViewController.self)).instantiateInitialViewController() as? UINavigationController
            else {
                return XCTFail("Could not instantiate ViewController from Album storyboard")
        }
        controller = nav.topViewController as? AlbumListViewController
        controller.loadViewIfNeeded()
        tableView = controller.albumListTableView
        delegate = tableView.delegate
    }

    func testTableViewHasAlbumCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumListCell")
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'AlbumListCell'")
    }
    
    func testTableViewHasArtistCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistListCell")
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'ArtistListCell'")
    }
    
    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === controller,
                      "Controller should be delegate for the table view")
    }

    func testTableViewIsCellIsAlbum() {
        var albumDict:Dictionary<String,Any>  = Dictionary()
        albumDict[ResponseConstant.groupType] = GroupType.album.rawValue
        albumDict[ResponseConstant.groupObject] = nil
        let albumGroup:Group = Group(dictionary: albumDict)
        self.groupListArray.append(albumGroup)
        
        let currentGroup:Group = self.groupListArray[0]
        XCTAssertTrue(currentGroup.groupType == GroupType.album.rawValue,
                          "cell is Album")
    }
    
    func testTableViewIsCellIsArtist() {
        var albumDict:Dictionary<String,Any>  = Dictionary()
        albumDict[ResponseConstant.groupType] = GroupType.artist.rawValue
        albumDict[ResponseConstant.groupObject] = nil
        let albumGroup:Group = Group(dictionary: albumDict)
        self.groupListArray.append(albumGroup)
        
        let currentGroup:Group = self.groupListArray[0]
        XCTAssertTrue(currentGroup.groupType == GroupType.artist.rawValue,
                      "cell is Artist")
    }
    
    func testForWSToGetAlbumList() {
        XCTAssertNoThrow(AlbumManager.album.getAlbumList(vc: nil, paramDict: nil))
    }
    
    func testForWSToGetArtistList() {
        XCTAssertNoThrow(AlbumManager.album.getArtistList(vc: nil, paramDict: nil))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
