//
//  BooksAPIManager.swift
//  Book Searcher
//
//  Created by Mustafo on 16/03/22.
//

import Foundation

/*
 API endpoint: https://www.googleapis.com/books/v1/volumes?q=<your_query_string>
 Example: https://www.googleapis.com/books/v1/volumes?q=programming
 */

protocol BooksAPI {
    func makeRequest(for query: String,completion: @escaping(QueryResult?)-> Void)
}

class BooksAPIManager: BooksAPI {
    private let urlPath = "https://www.googleapis.com/books/v1/volumes?q="
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    
    static let shared = BooksAPIManager()
    
    //MARK: TO DO
//    enum BooksAPIError: LocalizedError {
//        case invalidURL
//        case missingQuery
//        case parsingError
//
//        var errorDescription: String? {
//            switch self {
//            case .invalidURL:
//               return "Invalid URL!"
//            case .missingQuery:
//                return "Missing query"
//            case .parsingError:
//                return "Couldn't parse"
//            }
//        }
//    }
    
    public func makeRequest(for query: String,completion: @escaping(QueryResult?)-> Void) {
        
        if query.isEmpty {
            completion(nil)
            return
        }
        
        guard let url = generateURL(for: query) else {
            completion(nil)
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            guard let data = data else {
                print("DATA NIL")
                return
            }
            if let queryResult = try? JSONDecoder().decode(QueryResult.self, from: data) {
                completion(queryResult)
                print("Count: \(queryResult.items.count)")
            } else {
                print(data)
                completion(nil)
            }
        }
        
        dataTask?.resume()
    }
    
    private func generateURL(for query: String)-> URL? {
        guard var components = URLComponents(string: urlPath) else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        return components.url
    }
    
}
