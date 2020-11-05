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
    
    override func viewWillDisappear(_ animated: Bool) {
        //button2.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = questions[0]
        setQuestion()
        configureStackView()
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        addButtonsToStackView()
        setStackViewConstraints()
        
    }
    
    let button0 = UIButton(type: .roundedRect)
    let button1 = UIButton(type: .roundedRect)
    let button2 = UIButton(type: .roundedRect)
    let button3 = UIButton(type: .roundedRect)
    
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
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    // Set labels and buttons for the current question
    func setQuestion() {
        //button2.isHidden = false
        let incorrectAnswers = currentQuestion?.incorrect.count
        
        question.text = currentQuestion!.question
        
        // button0.setTitle(currentQuestion!.incorrect[0], for: .normal)
        // button0.setTitleColor(.systemBlue, for: .normal)
        // button0.addTarget(self, action: #selector(buttonAction0), for: .touchUpInside)
        // self.view.addSubview(button0)
        
        //button1.frame(forAlignmentRect: CGRect(x: 85, y: yAxis[1], width: 200, height: 60))
        //button1.setTitle(currentQuestion!.incorrect[1], for: .normal)
        //button1.setTitleColor(.systemBlue, for: .normal)
        //button1.addTarget(self, action: #selector(buttonAction1), for: .touchUpInside)
        //self.view.addSubview(button1)
        
        if let incorrectAnswers = incorrectAnswers {
            
            if incorrectAnswers > 2 {
                //button2.frame(forAlignmentRect: CGRect(x: 85, y: yAxis[2], width: 200, height: 60))
                //button2.setTitle(currentQuestion!.incorrect[2], for: .normal)
                //button2.setTitleColor(.systemBlue, for: .normal)
                //button2.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
                //self.view.addSubview(button2)
                
            } else {
                //button2.setTitle("", for: .normal)
                //button2.isHidden = true
            }
            
            //button3.frame(forAlignmentRect: CGRect(x: 85, y: yAxis[3], width: 200, height: 60))
            //button3.setTitle(currentQuestion!.correct, for: .normal)
            //button3.setTitleColor(.systemBlue, for: .normal)
            //button3.addTarget(self, action: #selector(buttonAction3), for: .touchUpInside)
            //self.view.addSubview(button3)
            
        }
        
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

