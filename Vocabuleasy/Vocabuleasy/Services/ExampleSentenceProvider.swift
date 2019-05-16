//
//  ExampleProvider.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/11/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

protocol ExampleSentenceProvider {
    static var shared: ExampleSentenceProvider { get }
    
    func getExampleSentence(for word: String, onCompletion:  @escaping (Result<[String], ExampleSentenceFetchError>) -> Void)
}

enum ExampleSentenceFetchError: Error {
    case malformedURL, invalidRequest, networkError, unexpectedResponse
}

class APIExampleSentenceProvider: ExampleSentenceProvider {
    
    private init() {}
    
    private(set) static var shared: ExampleSentenceProvider = APIExampleSentenceProvider()
    
    func getExampleSentence(for word: String, onCompletion:  @escaping (Result<[String], ExampleSentenceFetchError>) -> Void) {
        guard let url = apiURL else {
            onCompletion(.failure(.malformedURL))
            return
        }
        var request = URLRequest(url: url)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        let body = RequestBody(lang: "eng", word: word)
        request.httpBody = try? JSONEncoder().encode(body)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            guard let data = data, err == nil else {
                onCompletion(.failure(.networkError))
                print(err!)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let body = try decoder.decode(ResponseBody.self, from: data)
                let sentences = body.sentences
                
                DispatchQueue.main.async {
                    onCompletion(.success(sentences))
                }
            } catch {
                onCompletion(.failure(.unexpectedResponse))
                print(error)
            }
                
            
        }
        task.resume()
    }
    
    var apiURL = URL(string: "http://10.0.0.224:5000/sentences")
    
    struct RequestBody: Codable {
        let lang: String
        let word: String
    }
    
    struct ResponseBody: Codable {
        let sentences: [String]
    }
    
}
