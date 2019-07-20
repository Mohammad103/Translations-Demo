//
//  WordsMatchingViewModel.swift
//  Translations Demo
//
//  Created by Mohammad Shaker on 7/20/19.
//  Copyright © 2019 Mohammad Shaker. All rights reserved.
//

import Foundation

protocol WordsMatchingViewModelDelegate: AnyObject {
    func wordsUpdatedSuccessfully()
    func failedLoadingWords(errorMessage: String)
}


class WordsMatchingViewModel {
    
    weak var delegate: WordsMatchingViewModelDelegate?
    
    private var words: [Word] = []
    private var selectedIndex: Int = -1
    private var selectedWord: Word?
    private var wordsToChooseFrom: [Word] = []
    
    
    init() {
        loadWords()
        delegate?.wordsUpdatedSuccessfully()
    }
    
    func loadWords() {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let wordsDic = jsonResult as? [[String: Any]] {
                    words = Word.parseJSON(dictionary: wordsDic)
                }
            } catch {
                delegate?.failedLoadingWords(errorMessage: "Error happened while trying load words data.")
            }
        }
    }
    
    
    // Datasource methods
    
    private func prepareWordsForNewGame() {
        selectedIndex = -1
        wordsToChooseFrom = []
        
        // Pick random word
        if let randomWord = words.randomElement() {
            selectedWord = randomWord
            wordsToChooseFrom.append(randomWord)
        }
        
        // Pick 4 random words
        for _ in 0 ..< 4 {
            if let randomWord = words.randomElement() {
                wordsToChooseFrom.append(randomWord)
            }
        }
        
        wordsToChooseFrom.shuffle()
    }
    
    func englishWord() -> String? {
        prepareWordsForNewGame()
        return selectedWord?.englishText
    }
    
    private func incrementSelectedWordIndex() {
        selectedIndex = selectedIndex + 1
        if selectedIndex >= wordsToChooseFrom.count {
            selectedIndex = 0
        }
    }
    
    func nextWordSpanishTranslation() -> String? {
        incrementSelectedWordIndex()
        if selectedIndex < 0 || selectedIndex >= wordsToChooseFrom.count {
            return nil
        }
        
        return wordsToChooseFrom[selectedIndex].spanishText
    }
    
    func isWordsMatched() -> Bool {
        if selectedWord?.englishText == wordsToChooseFrom[selectedIndex].englishText && selectedWord?.spanishText == wordsToChooseFrom[selectedIndex].spanishText {
            return true
        }
        return false
    }
}
