//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import XCTest

final class MarvelAppUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testHeroListLoads() {
        let grid = app.scrollViews.firstMatch
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "Hero grid should be visible")
    }
    
    func testSearchHero() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        
        searchField.tap()
        searchField.typeText("Spider-Man")
        
        // Expect some cell to appear
        let firstCell = app.scrollViews.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
    }
    
    func testHeroDetailNavigation() {
        let scrollViewsQuery = XCUIApplication().scrollViews
        scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .staticText)["3-D Man"].children(matching: .image).element.tap()
        
        let elementsQuery = scrollViewsQuery.otherElements
        let comicsText = elementsQuery.staticTexts["Comics"]
        let seriesText = elementsQuery.staticTexts["Series"]
        XCTAssertTrue(comicsText.waitForExistence(timeout: 5))
        XCTAssertTrue(seriesText.waitForExistence(timeout: 5))
        
    }
    
    func testPagination() {
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.waitForExistence(timeout: 5), "Hero list did not appear")
        XCTAssertTrue(scrollView.staticTexts.matching(identifier: "heroGridItem").firstMatch.waitForExistence(timeout: 5))
        let initialCount = scrollView.staticTexts.matching(identifier: "heroGridItem").count
        for _ in 0..<5 {
            scrollView.swipeUp()
        }
        let finalCount = scrollView.staticTexts.matching(identifier: "heroGridItem").count
        XCTAssertTrue(finalCount > initialCount, "Expected more heroes to load after swiping.")
    }
}
