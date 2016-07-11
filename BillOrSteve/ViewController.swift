//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var steveButton: UIButton!
    @IBOutlet weak var billButton: UIButton!
    
    var triviaFactDict: [String: [String]] = [:]
    var currentFactDisplayed: (String, String) = ("","")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    
    func resetGame() {
        createFacts()
        showFact()
    }
    
    func createFacts() {
        let steveFacts = [
            "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
            "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
            "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
            "He was a pescetarian, meaning he ate no meat except for fish."]
        let billFacts = [
            "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
            "He scored 1590 (out of 1600) on his SATs.",
            "His foundation spends more on global health each year than the United Nation's World Health Organization.",
            "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
            "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."]
        triviaFactDict.updateValue(steveFacts, forKey: "Steve Jobs")
        triviaFactDict.updateValue(billFacts, forKey: "Bill Gates")
    }
    
    func getRandomFact() -> (String, String)? {
        let personSelected = randomPerson()
        let triviaFacts = triviaFactDict[personSelected]
        guard let triviaStuff = triviaFacts where !triviaStuff.isEmpty else { return nil }
        let randomFactIndex = randomNumberFromZeroTo(triviaStuff.count)
        let selectedTrivia = triviaFactDict[personSelected]?.removeAtIndex(randomFactIndex)
        return (personSelected, selectedTrivia!)
    }
    
    func randomNumberFromZeroTo(number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
    func showFact() {
        let factToDisplay = getRandomFact()
        if let factToDisplay = factToDisplay {
            factLabel.text = factToDisplay.1
            currentFactDisplayed = factToDisplay
        }
    }
    
    @IBAction func steveTapped(sender: AnyObject) {
        if currentFactDisplayed.0 == "Steve Jobs" {
            updateScoreLabel()
        }
        showFact()
    }
    
    @IBAction func billTapped(sender: AnyObject) {
        if currentFactDisplayed.0 == "Bill Gates" {
            updateScoreLabel()
        }
        showFact()
    }
    
    func updateScoreLabel() {
        guard let score = scoreLabel.text else {
            return
        }
        
        guard let currentScore = Int(score) else {
            return
        }
        
        let newScore = currentScore + 1
        scoreLabel.text = "\(newScore)"
    }
    
}
