//
//  ViewController.swift
//  TandemQuizStoryBoard
//
//  Created by Travis Brigman on 10/31/20.
//  Copyright © 2020 Travis Brigman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        viewDidLoad()
    }
    
    let questions = DataLoader().questions.shuffled().prefix(10)
  
   
    
    
    var currentQuestion: Question?
    var currentQuestionPos = 0
    
    var noCorrect = 0
    
    @IBOutlet var question: UILabel!
    
    @IBOutlet var answer0: UIButton!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var progress: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        answer2.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestion = questions[0]
        
        setQuestion()
    }
    

    // Set labels and buttons for the current question
    func setQuestion() {
        answer2.isHidden = false
        let incorrectAnswers = currentQuestion?.incorrect.count
        
        question.text = currentQuestion!.question
        answer0.setTitle(currentQuestion!.incorrect[0], for: .normal)
        answer1.setTitle(currentQuestion!.incorrect[1], for: .normal)
        if let incorrectAnswers = incorrectAnswers {
            
            if incorrectAnswers > 2 {
                answer2.setTitle(currentQuestion!.incorrect[2], for: .normal)
            } else {
                answer2.setTitle("", for: .normal)
                answer2.isHidden = true
            }
            answer3.setTitle(currentQuestion!.correct, for: .normal)
            
        }
        
        progress.text = "\(currentQuestionPos + 1) / \(questions.count)"
    }
    
    // Submit an answer
    @IBAction func submitAnswer0(_ sender: Any) {
        checkAnswer(ansString: currentQuestion?.incorrect[0] ?? "error")
    }
    
    @IBAction func submitAnswer1(_ sender: Any) {
        checkAnswer(ansString: currentQuestion?.incorrect[1] ?? "error")
    }
    
    @IBAction func submitAnswer2(_ sender: Any) {
        checkAnswer(ansString: currentQuestion?.incorrect[2] ?? "error")
    }
    @IBAction func submitAnswer3(_ sender: Any) {
        checkAnswer(ansString: currentQuestion?.correct ?? "error")
    }
    
    // Check if an answer is correct then load the next question
    func checkAnswer(ansString: String) {
        if(ansString == currentQuestion!.correct) {
            noCorrect += 1
        }
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        // Show next question
        if(currentQuestionPos + 1 < questions.count) {
            currentQuestionPos += 1
            currentQuestion = questions[currentQuestionPos]
            setQuestion()
            // If there are no more questions show the results
        } else {
            performSegue(withIdentifier: "sgShowResults", sender: nil)
        }
    }
    
    // Before we move to the results screen pass the how many we got correct, and the total number of questions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sgShowResults") {
            let vc = segue.destination as! ResultsViewController
            vc.noCorrect = noCorrect
            vc.total = questions.count
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

