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
    
    func test_HeroListLoads() {
        let grid = app.scrollViews.firstMatch
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "Hero grid should be visible")
    }
    
    func test_SearchHero_FindsMatches() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        
        searchField.tap()
        searchField.typeText("Abomination")
        
        // Expect some cell to appear
        let firstCell = app.scrollViews.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
    }
    
    func test_SearchHero_NoMatches_EmptyState() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        
        searchField.tap()
        searchField.typeText("Spider")
        XCTAssertTrue(app.staticTexts["No Results for “Spider”"].waitForExistence(timeout: 5))
    }
    
    func testHeroDetailNavigation() {
        let scrollViewsQuery = XCUIApplication().scrollViews
        scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .image).matching(identifier: "heroGridItem").element(boundBy: 0).tap()
        let elementsQuery = scrollViewsQuery.otherElements
        XCTAssertFalse(elementsQuery.staticTexts["Description"].waitForExistence(timeout: 5))
        XCTAssertTrue(elementsQuery.staticTexts["Comics"].waitForExistence(timeout: 5))
        XCTAssertTrue(elementsQuery.staticTexts["Series"].waitForExistence(timeout: 5))
    }
    
    func testPagination() {
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.waitForExistence(timeout: 5), "Hero list did not appear")
        XCTAssertTrue(scrollView.staticTexts.matching(identifier: "heroGridItem").firstMatch.waitForExistence(timeout: 5))
        let initialCount = scrollView.staticTexts.matching(identifier: "heroGridItem").count
        for _ in 0..<3 {
            scrollView.swipeUp()
        }
        let finalCount = scrollView.staticTexts.matching(identifier: "heroGridItem").count
        XCTAssertTrue(finalCount > initialCount, "Expected more heroes to load after swiping.")
    }
}
