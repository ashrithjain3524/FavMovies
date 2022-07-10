//
//  Favourite_MoviesUITests.swift
//  Favourite MoviesUITests
//
//  Created by Ashrith Jain on 09/07/22.
//

import XCTest

class Favourite_MoviesUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testTableSwipe() throws {
        //app.tables.cells.containing(.staticText, identifier:"Spider-Man: No Way Home").element.tap()
        let tablesQuery = app.tables
        let spoderCell = tablesQuery.cells.containing(.staticText, identifier:"Spider-Man: No Way Home").element
        if spoderCell.exists{
            XCTAssert(spoderCell.exists)
            spoderCell.swipeUp()
            XCTAssert(spoderCell.exists)
        }
        
    }
    
    func testTableTap() throws {
        let tablesQuery = app.tables
        let spoderCell = tablesQuery.cells.containing(.staticText, identifier:"Spider-Man: No Way Home").element
        
        if spoderCell.exists{
            spoderCell.tap()
            XCTAssert(app.navigationBars["Movie Detail"].exists)
        }
    }
    
    func testSearchBar() throws {
        let searchField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element
        let tablesQuery = app.tables
        XCTAssert(searchField.exists)
        XCTAssert(tablesQuery.cells.count > 0)
        
    }
}
