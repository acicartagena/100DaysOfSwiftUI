//
//  Questions.swift
//  MultiplicationTables
//
//  Created by Angela Cartagena on 23/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

struct Questions {

    struct Question {
        let description: String
        let answer: Int
    }

    enum Count {
        case number(Int)
        case all

        var text: String {
            switch self {
            case let .number(count): return "\(count)"
            case .all: return "all"
            }
        }

        static var validOptions: [Count] {
            return [.number(5), .number(10), .number(20), .all]
        }
    }

    let questions: [Question]

    init(upTo: Int, count: Count) {
        var tempQuestions: [Question] = []
        for i in 1...upTo {
            for j in 1...12 {
                let question = Question(description: "\(i) x \(j)", answer: i*j)
                tempQuestions.append(question)
            }
        }

        switch count {
        case let .number(questionCount):
            questions = Array(tempQuestions.shuffled().prefix(questionCount))
        case .all:
            questions = tempQuestions.shuffled()
        }
    }
}
