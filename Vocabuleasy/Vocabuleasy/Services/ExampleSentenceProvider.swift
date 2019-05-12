//
//  ExampleProvider.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/11/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

protocol ExampleSentenceProvider {
    func getExampleSentence(for word: String, onCompletion: (String) -> Void)
}

class TestExampleSentenceProvider: ExampleSentenceProvider {
    private init() {}
    static var shared = TestExampleSentenceProvider()
    
    func getExampleSentence(for word: String, onCompletion: (String) -> Void) {
        onCompletion("\(word) foo bar")
    }
}
