//
//  WordTests.swift
//  Translations DemoTests
//
//  Created by Mohammad Shaker on 7/21/19.
//  Copyright © 2019 Mohammad Shaker. All rights reserved.
//

import XCTest
@testable import Translations_Demo

class WordTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testInit() {
        let word = Word(englishText: "ball", spanishText: "balón")
        XCTAssertNotNil(word)
        
        XCTAssertNotNil(word.englishText)
        XCTAssertEqual(word.englishText, "ball")
        
        XCTAssertNotNil(word.spanishText)
        XCTAssertEqual(word.spanishText, "balón")
    }
    
    func testInitWithDictionary() {
        let word = Word(dictionary: ["text_eng": "ball", "text_spa": "balón"])
        XCTAssertNotNil(word)
        
        XCTAssertNotNil(word.englishText)
        XCTAssertEqual(word.englishText, "ball")
        
        XCTAssertNotNil(word.spanishText)
        XCTAssertEqual(word.spanishText, "balón")
    }
    
    func testInitArrayWithDictionary() {
        let wordsDict = [["text_eng": "ball", "text_spa": "balón"], ["text_eng": "Monday", "text_spa": "lunes"]]
        let words = Word.parseJSON(dictionary: wordsDict)
        XCTAssertNotNil(words)
        XCTAssertEqual(words.count, 2)
        
        
        let ballWord = words[0]
        XCTAssertNotNil(ballWord)
        
        XCTAssertNotNil(ballWord.englishText)
        XCTAssertEqual(ballWord.englishText, "ball")
        
        XCTAssertNotNil(ballWord.spanishText)
        XCTAssertEqual(ballWord.spanishText, "balón")
        
        
        let mondayWord = words[1]
        XCTAssertNotNil(mondayWord)
        
        XCTAssertNotNil(mondayWord.englishText)
        XCTAssertEqual(mondayWord.englishText, "Monday")
        
        XCTAssertNotNil(mondayWord.spanishText)
        XCTAssertEqual(mondayWord.spanishText, "lunes")
    }
    
    func testEqualWords() {
        let word1 = Word(englishText: "ball", spanishText: "balón")
        let word2 = Word(englishText: "ball", spanishText: "balón")
        
        XCTAssertNotNil(word1)
        XCTAssertNotNil(word2)
        XCTAssertTrue(word1 == word2)
    }
    
    func testNotEqualWords() {
        let word1 = Word(englishText: "ball", spanishText: "balón")
        let word2 = Word(englishText: "ball1", spanishText: "balón")
        
        XCTAssertNotNil(word1)
        XCTAssertNotNil(word2)
        XCTAssertFalse(word1 == word2)
    }
    
    func testNotEqualWords2() {
        let word1 = Word(englishText: "ball", spanishText: "balón")
        let word2 = Word(englishText: "ball", spanishText: "balón2")
        
        XCTAssertNotNil(word1)
        XCTAssertNotNil(word2)
        XCTAssertFalse(word1 == word2)
    }
    
    func testNotEqualWords3() {
        let word1 = Word(englishText: "ball", spanishText: "balón")
        let word2 = Word(englishText: "ball2", spanishText: "balón2")
        
        XCTAssertNotNil(word1)
        XCTAssertNotNil(word2)
        XCTAssertFalse(word1 == word2)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
