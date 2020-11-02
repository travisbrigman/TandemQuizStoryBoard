//
//  ResultsViewController.swift
//  TandemQuizStoryBoard
//
//  Created by Travis Brigman on 11/1/20.
//  Copyright © 2020 Travis Brigman. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var noCorrect = 0
    var total = 0
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblResults:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

         // Set the results
               lblResults.text = "You got \(noCorrect) out of \(total) correct"
               
               // Calculate the percentage of quesitons you got right
               var percentRight = Double(noCorrect) / Double(total)
               percentRight *= 100
               
               // Based on the percentage of questions you got right present the user with different message
               var title = ""
               if(percentRight < 40) {
                   title = "You've Got Room To Improve!"
               } else if(percentRight < 70) {
                   title = "Keep Trying!"
               } else {
                   title = "Good Job!"
               }
               lblTitle.text = title

           }

           override func didReceiveMemoryWarning() {
               super.didReceiveMemoryWarning()
               // Dispose of any resources that can be recreated.
           }
           
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


