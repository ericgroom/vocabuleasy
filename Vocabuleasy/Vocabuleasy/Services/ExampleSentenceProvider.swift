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
    
    func getExampleSentence(for word: String, lang: String, onCompletion:  @escaping (Result<[String], ExampleSentenceFetchError>) -> Void)
}

enum ExampleSentenceFetchError: LocalizedError, CustomStringConvertible {
    case malformedURL, invalidRequest, networkError, unexpectedResponse
    
    var description: String {
        switch self {
        case .malformedURL:
            return "Incorrect URL format"
        case .invalidRequest:
            return "Server rejected request"
        case .networkError:
            return "Unable to connect to server"
        case .unexpectedResponse:
            return "Unexpected server response"
        }
    }
}

class APIExampleSentenceProvider: ExampleSentenceProvider {
    
    private init() {}
    
    private(set) static var shared: ExampleSentenceProvider = APIExampleSentenceProvider()
    
    func getExampleSentence(for word: String, lang: String, onCompletion:  @escaping (Result<[String], ExampleSentenceFetchError>) -> Void) {
        guard let url = apiURL else {
            onCompletion(.failure(.malformedURL))
            return
        }
        var request = URLRequest(url: url)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        let body = RequestBody(lang: lang, word: word)
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
                
                onCompletion(.success(sentences))
                
            } catch {
                onCompletion(.failure(.unexpectedResponse))
                print(error)
            }
                
            
        }
        task.resume()
    }
    
    var apiURL = URL(string: Network.sentencesEndpoint)
    
    struct RequestBody: Codable {
        let lang: String
        let word: String
    }
    
    struct ResponseBody: Codable {
        let sentences: [String]
    }
    
}
