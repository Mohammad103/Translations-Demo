//
//  WordsMatchingViewModelTests.swift
//  Translations DemoTests
//
//  Created by Mohammad Shaker on 7/21/19.
//  Copyright © 2019 Mohammad Shaker. All rights reserved.
//

import XCTest
@testable import Translations_Demo

class WordsMatchingViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testInit() {
        let viewModel = WordsMatchingViewModel()
        XCTAssertNotNil(viewModel)
    }

    func testWordsGeneration() {
        let viewModel = WordsMatchingViewModel()
        _ = viewModel.englishWord()
        for _ in 0 ..< 5 {
            _ = viewModel.nextWordSpanishTranslation()
            if viewModel.isWordsMatched() {
                return
            }
        }
        XCTFail("No word matched!")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
