//
//  AlbumDetailTestCase.swift
//  LastFMTests
//
//  Created by Admin on 08/03/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
@testable import LastFM

class AlbumDetailTestCase: XCTestCase {

    var controller: AlbumDetailViewController!
    var tableView: UITableView!
    var delegate: UITableViewDelegate!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let vc = UIStoryboard(name: "Album", bundle: Bundle(for: AlbumDetailViewController.self)).instantiateViewController(withIdentifier: "AlbumDetailViewController") as? AlbumDetailViewController
            else {
                return XCTFail("Could not instantiate ViewController from Album storyboard")
        }
        vc.loadViewIfNeeded()
        controller = vc
        tableView = controller.similarTableView
        delegate = tableView.delegate
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testForArtistInfoDetails() {
        XCTAssertNoThrow(controller.callWSToArtistInfo(artistName: nil))
    }

    func testTableViewHasSimilarArtistcells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubArtistCell")
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'SubArtistCell'")
    }
    
    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === controller,
                      "Controller should be delegate for the table view")
    }
    
    func testForSimilarArtistCellDetails() {
        let cell:SubArtistCell = tableView.dequeueReusableCell(withIdentifier: "SubArtistCell") as! SubArtistCell
        XCTAssertNoThrow(cell.setArtistDetails(currentArtist: nil))
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
