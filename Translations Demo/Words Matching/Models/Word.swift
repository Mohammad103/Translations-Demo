//
//  Word.swift
//  Translations Demo
//
//  Created by Mohammad Shaker on 7/20/19.
//  Copyright © 2019 Mohammad Shaker. All rights reserved.
//

import UIKit

struct Word {
    var englishText: String?
    var spanishText: String?
    
    init() {}
    
    init(englishText: String?, spanishText: String?) {
        self.englishText = englishText
        self.spanishText = spanishText
    }
    
    init(dictionary: [String: Any]) {
        englishText = dictionary["text_eng"] as? String
        spanishText = dictionary["text_spa"] as? String
    }
    
    
    // Class Methods
    
    static func parseJSON(dictionary: [[String: Any]]) -> [Word] {
        var words: [Word] = []
        for wordDict in dictionary {
            words.append(Word(dictionary: wordDict))
        }
        return words
    }
}
