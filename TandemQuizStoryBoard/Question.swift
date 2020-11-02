//
//  Question.swift
//  TandemQuiz
//
//  Created by Travis Brigman on 10/30/20.
//  Copyright © 2020 Travis Brigman. All rights reserved.
//

import Foundation

struct Question: Codable {
    var question: String
    var correct: String
    var incorrect: [String]
    
}
