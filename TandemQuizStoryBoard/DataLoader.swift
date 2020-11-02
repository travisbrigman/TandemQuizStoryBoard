//
//  DataLoader.swift
//  TandemQuiz
//
//  Created by Travis Brigman on 10/30/20.
//  Copyright © 2020 Travis Brigman. All rights reserved.
//

import Foundation


public class DataLoader {
    @Published var questions = [Question]()
    
    init() {
        load()
    }
    
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "Apprentice_TandemFor400_Data", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Question].self, from: data)
                
                self.questions = dataFromJson
            } catch {
                print(error)
            }
        }
    }
}

