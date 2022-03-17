//
//  Book_SearcherTests.swift
//  Book SearcherTests
//
//  Created by Mustafo on 17/03/22.
//

import XCTest
@testable import Book_Searcher

class Book_SearcherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_BooksAPIProtocol_shouldGetData() {
        //Given
        let booksAPIManager: BooksAPI = BooksAPIManager()
        
        //When
        booksAPIManager.makeRequest(for: "Programming") { result in
            //Then
            XCTAssertNotNil(result)
        }
    }
    
}
