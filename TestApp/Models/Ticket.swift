//
//  Ticket.swift
//  TestApp
//
//  Created by Nikita Teplyakov on 28/05/2019.
//  Copyright © 2019 VZLET. All rights reserved.
//

import Foundation

struct Ticket {
    
    let competence: Competence
    let question: String
    let answer: String
    
    var questionFirstLetter: String {
        return question.first?.uppercased() ?? "?"
    }
    var sentences: [String] {
        return answer.components(separatedBy: "¶").map { answer -> String in
            answer.replacingOccurrences(of: "\n", with: "")
        }
    }
    
    init(competence: Competence, question: String, answer: String) {
        self.competence = competence
        self.question = question
        self.answer = answer
    }
}
