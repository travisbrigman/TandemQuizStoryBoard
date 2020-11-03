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
  
   
       


    @objc func buttonAction0() {
        checkAnswer(ansString: currentQuestion?.incorrect[0] ?? "error")
   }
     @objc func buttonAction1() {
         checkAnswer(ansString: currentQuestion?.incorrect[1] ?? "error")
    }
     @objc func buttonAction2() {
         checkAnswer(ansString: currentQuestion?.incorrect[2] ?? "error")
    }
     @objc func buttonAction3() {
         checkAnswer(ansString: currentQuestion?.correct ?? "error")
    }
    
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
       // answer2.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = questions[0]
        
        setQuestion()

    }
    

    // Set labels and buttons for the current question
    func setQuestion() {
       // answer2.isHidden = false
        let incorrectAnswers = currentQuestion?.incorrect.count
        
        question.text = currentQuestion!.question
        
        let button0 = UIButton(frame: CGRect(x: 85, y: 265, width: 200, height: 60))
        button0.setTitle(currentQuestion!.incorrect[0], for: .normal)
        button0.setTitleColor(.systemBlue, for: .normal)
        button0.addTarget(self, action: #selector(buttonAction0), for: .touchUpInside)
        self.view.addSubview(button0)
        
        //answer0.setTitle(currentQuestion!.incorrect[0], for: .normal)
        
        let button1 = UIButton(frame: CGRect(x: 85, y: 285, width: 200, height: 60))
        button1.setTitle(currentQuestion!.incorrect[1], for: .normal)
        button1.setTitleColor(.systemBlue, for: .normal)
        button1.addTarget(self, action: #selector(buttonAction1), for: .touchUpInside)
        self.view.addSubview(button1)
        
        //answer1.setTitle(currentQuestion!.incorrect[1], for: .normal)
        
        if let incorrectAnswers = incorrectAnswers {
            
            let button2 = UIButton(frame: CGRect(x: 85, y: 305, width: 200, height: 60))
            
            if incorrectAnswers > 2 {
                
                button2.setTitle(currentQuestion!.incorrect[2], for: .normal)
                button2.setTitleColor(.systemBlue, for: .normal)
                button2.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
                self.view.addSubview(button2)
                //answer2.setTitle(currentQuestion!.incorrect[2], for: .normal)
            } else {
                button2.setTitle("", for: .normal)
                button2.isHidden = true
            }
            
            let button3 = UIButton(frame: CGRect(x: 85, y: 325, width: 200, height: 60))
            button3.setTitle(currentQuestion!.correct, for: .normal)
            button3.setTitleColor(.systemBlue, for: .normal)
            button3.addTarget(self, action: #selector(buttonAction3), for: .touchUpInside)
            self.view.addSubview(button3)
            //answer3.setTitle(currentQuestion!.correct, for: .normal)
            
        }
        
        progress.text = "\(currentQuestionPos + 1) / \(questions.count)"
    }
    
    // Submit an answer
//    @IBAction func submitAnswer0(_ sender: Any) {
//        checkAnswer(ansString: currentQuestion?.incorrect[0] ?? "error")
//    }
//
//    @IBAction func submitAnswer1(_ sender: Any) {
//        checkAnswer(ansString: currentQuestion?.incorrect[1] ?? "error")
//    }
//
//    @IBAction func submitAnswer2(_ sender: Any) {
//        checkAnswer(ansString: currentQuestion?.incorrect[2] ?? "error")
//    }
//    @IBAction func submitAnswer3(_ sender: Any) {
//        checkAnswer(ansString: currentQuestion?.correct ?? "error")
//    }
    
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

