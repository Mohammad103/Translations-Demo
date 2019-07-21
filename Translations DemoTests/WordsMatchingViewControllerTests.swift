//
//  WordsMatchingViewControllerTests.swift
//  Translations DemoTests
//
//  Created by Mohammad Shaker on 7/21/19.
//  Copyright © 2019 Mohammad Shaker. All rights reserved.
//

import XCTest
@testable import Translations_Demo

class WordsMatchingViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testInit() {
        guard let controller = UIStoryboard(name: "WordsMatching", bundle: nil).instantiateViewController(withIdentifier: "WordsMatchingViewController") as? WordsMatchingViewController else {
            return XCTFail("Could not instantiate WordsMatchingViewController from WordsMatching storyboard")
        }
        XCTAssertNotNil(controller)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
