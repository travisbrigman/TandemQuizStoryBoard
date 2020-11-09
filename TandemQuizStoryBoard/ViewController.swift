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
    
    var stackView = UIStackView()
    
    let questions = DataLoader().questions.shuffled().prefix(10)
    
    var currentQuestion: Question?
    var currentQuestionPos = 0
    var noCorrect = 0
    
    @IBOutlet var question: UILabel!
    @IBOutlet var progress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = questions[0]
        currentQuestionPos = 0
        noCorrect = 0
        setQuestion()
        configureStackView()
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        addButtonsToStackView()
        setStackViewConstraints()
        
    }
    
    let button0 = CustomButton()
    let button1 = CustomButton()
    let button2 = CustomButton()
    let button3 = CustomButton()
    
    
    
    func addButtonsToStackView() {
        var allAnswers = currentQuestion?.incorrect
        allAnswers?.append(currentQuestion?.correct ?? "no right answer")
        allAnswers?.shuffle()
        
        var buttonArray = [button0, button1, button2, button3]
        
        if let allAnswers = allAnswers {
            var incrementer = 0
            
            if allAnswers.count < 4 {
                buttonArray.removeLast()
            }
            
            for button in buttonArray {
                button.setTitle(allAnswers[incrementer], for: .normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                stackView.addArrangedSubview(button)
                incrementer+=1
            }
        }
    }
    
    func removeButtonsFromStackView() {
        let buttonArray = [button0, button1, button2, button3]
        for button in buttonArray {
            button.setTitle("", for: .normal)
            stackView.removeArrangedSubview(button)
        }
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: progress.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    // Set labels and buttons for the current question
    func setQuestion() {
        question.text = currentQuestion!.question
        progress.text = "\(currentQuestionPos + 1) / \(questions.count)"
    }
    
    // Submit an answer
    @objc func buttonAction(sender: UIButton!) {
       let touchedAnswer = sender.titleLabel?.text
        checkAnswer(ansString: touchedAnswer ?? "error")
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
            removeButtonsFromStackView()
            setQuestion()
            configureStackView()
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

