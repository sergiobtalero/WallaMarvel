import XCTest

class WallaMarvelUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testLoadHeroes() {
        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5), "Hero grid should be visible")
    }
    
    func testSearchHero() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        
        searchField.tap()
        searchField.typeText("Bomb")
        
        // Expect some cell to appear
        let firstCell = app.tables.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
    }
    
    func testHeroDetailNavigation() {
        let tableQueries = XCUIApplication().tables
        tableQueries.cells.firstMatch.tap()
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let comicsText = elementsQuery.staticTexts["Comics"]
        XCTAssertTrue(comicsText.waitForExistence(timeout: 5))
    }
}
