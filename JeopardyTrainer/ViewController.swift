//
//  ViewController.swift
//  JeopardyTrainer
//
//  Created by Isabelle Smyth on 12/8/19.
//  Copyright © 2019 Isabelle Smyth. All rights reserved.
//
//
import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    //var totalQuestionsSeen: Int = 0
    //var answersCorrect: Int = 0
    //var score: Int = 0
    
    @IBOutlet weak var answerCorrectlyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var totalQuestionsLabel: UILabel!
    @IBOutlet var category0Buttons: [UIButton]!
    @IBOutlet weak var category0Label: UILabel!
    
    var clueNumberToShow = 0
    var categories: Categories!
    var clues = Clues()
    var currentCategories = Categories()
   // var clueNumberToShow = 0
    var selectedCategoryNumber = 0
    var totalQuestionsSeen = 0
    var answersCorrect = 0 {
        didSet {
            answerCorrectlyLabel.text = "\(answersCorrect)"
        }
    }
    
    var score = 0 {
        didSet {
            if score < 0 {
                scoreLabel.textColor = .red
            } else {
                scoreLabel.textColor = .systemBlue
            }
            scoreLabel.text = "$\(score)"
        }
    }

  override func viewDidLoad() {
        super.viewDidLoad()
    categories = Categories()
    loadCategories()
    
    }

    
    func loadCategories() {
        categories.categoryArray = []
        currentCategories.categoryArray = []
        categories.getData {
            print("doneeee")
    self.currentCategories.categoryArray.append(self.categories.categoryArray.randomElement()!)
    self.category0Label.text = self.currentCategories.categoryArray[0].title
            self.loadClues()
}
}
    
    func loadClues() {
        for button in category0Buttons {
            button.isEnabled = true
            button.backgroundColor = .systemBlue
        }
        
        self.clues.clueArray = []
        self.clues.id = self.currentCategories.categoryArray[0].id
        self.clues.getData {
            //print("got the clues!")
            for i in 0..<self.category0Buttons.count {
                self.category0Buttons[i].setTitle("$\(self.clues.clueArray[i].value)", for: .normal)
                
            }
        }
    }
     @IBAction func loadButtonPressed(_ sender: UIBarButtonItem) {
        print("this is \(currentCategories.categoryArray[0].title)")
        loadCategories()
    }

    @IBAction func category0ButtonPressed(_ sender: UIButton) {
        clueNumberToShow = sender.tag
        totalQuestionsSeen += 1
        totalQuestionsLabel.text = "\(totalQuestionsSeen)"
        selectedCategoryNumber = 0
        sender.isEnabled = false
        sender.backgroundColor = .lightGray
        sender.setTitle("", for: .normal)
        performSegue(withIdentifier: "PresentQuestion", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentQuestion" {
            let destination = segue.destination as! QuestionsViewController
            destination.clue = clues.clueArray[clueNumberToShow]
            destination.categoryTitle = self.currentCategories.categoryArray[selectedCategoryNumber].title
        }
    }
    
    @IBAction func segueAfterYesPressed(segue: UIStoryboardSegue) {
       answersCorrect += 1
        score = score + clues.clueArray[clueNumberToShow].value
    }
    
    @IBAction func segueAfterNoPressed(segue: UIStoryboardSegue) {
        score = score - clues.clueArray[clueNumberToShow].value
    }
    
}
