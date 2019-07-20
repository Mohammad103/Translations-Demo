//
//  WordsMatchingViewController.swift
//  Translations Demo
//
//  Created by Mohammad Shaker on 7/20/19.
//  Copyright © 2019 Mohammad Shaker. All rights reserved.
//

import UIKit
import CountdownLabel
import JRMFloatingAnimation

class WordsMatchingViewController: UIViewController {

    @IBOutlet weak var englishTextLabel: UILabel!
    @IBOutlet weak var spanishTextButton: UIButton!
    @IBOutlet weak var timerLabel: CountdownLabel!
    
    private var viewModel = WordsMatchingViewModel()
    private var floatingAnimationView: JRMFloatingAnimationView!
    private var floatingAnimationTimer: Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.animationType = .Evaporate
        timerLabel.countdownDelegate = self
        
        viewModel.delegate = self
        wordsUpdatedSuccessfully()
    }
    
    private func setNextSpanishTranslation() {
        DispatchQueue.main.async { [unowned self] in
            self.spanishTextButton.setTitle(self.viewModel.nextWordSpanishTranslation(), for: .normal)
            self.timerLabel.setCountDownTime(minutes: TimeInterval(5))
            self.timerLabel.start()
        }
    }
    
    private func handleWrongAnswer() {
        let animationDuration = 0.5
        spanishTextButton.shake(duration: animationDuration, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) { [unowned self] in
            self.setNextSpanishTranslation()
        }
    }
    
    @objc private func animateFloatingAnimationView() {
        floatingAnimationView.animate()
    }
    
    private func handleRightAnswer() {
        floatingAnimationView = JRMFloatingAnimationView(starting: CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height + 100))
        floatingAnimationView.startingPointWidth = view.frame.size.width
        floatingAnimationView.animationWidth = 75
        floatingAnimationView.maxFloatObjectSize = 75
        floatingAnimationView.minFloatObjectSize = 75
        floatingAnimationView.animationDuration = 3.0
        floatingAnimationView.maxAnimationHeight = floatingAnimationView.maxAnimationHeight - 64
        floatingAnimationView.minAnimationHeight = floatingAnimationView.maxAnimationHeight
        floatingAnimationView.removeOnCompletion = true
        floatingAnimationView.add(UIImage(named: "blue_balloon"))
        view.addSubview(floatingAnimationView)
        floatingAnimationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateFloatingAnimationView), userInfo: nil, repeats: true)
        
        
        let alertController = UIAlertController(title: nil, message: "Matched! Next word?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [unowned self] (action) in
            self.floatingAnimationTimer.invalidate()
            self.floatingAnimationTimer = nil
            self.floatingAnimationView.removeFromSuperview()
            self.floatingAnimationView = nil
            self.wordsUpdatedSuccessfully()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func spanishTextButtonTapped() {
        timerLabel.cancel()
        if viewModel.isWordsMatched() {
            handleRightAnswer()
        } else {
            handleWrongAnswer()
        }
    }
}


extension WordsMatchingViewController: WordsMatchingViewModelDelegate {
    func wordsUpdatedSuccessfully() {
        englishTextLabel.text = viewModel.englishWord()
        setNextSpanishTranslation()
    }
    
    func failedLoadingWords(errorMessage: String) {
        let alertController = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


extension WordsMatchingViewController: CountdownLabelDelegate {
    func countdownFinished() {
        print("countdownFinished")
        setNextSpanishTranslation()
    }
}
