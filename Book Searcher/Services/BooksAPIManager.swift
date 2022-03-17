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

class BooksAPIManager {
    private let urlPath = "https://www.googleapis.com/books/v1/volumes?q="
    
    let defaultSession = URLSession(configuration: .default)
    
    static let shared = BooksAPIManager()
    
    enum BooksAPIError: LocalizedError {
        case invalidURL
        case missingQuery
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
               return "Invalid URL!"
            case .missingQuery:
                return "Missing query"
            }
        }
    }
    
    public func makeRequest(for query: String,completion: @escaping(Result<QueryResult,Error>)-> Void) {
        
        guard let url = generateURL(for: query) else {
            print("URL INVALID")
            completion(.failure(BooksAPIError.invalidURL))
            return
        }
        
        let dataTask = defaultSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("DATA NIL")
                return
            }
            if let book = try? JSONDecoder().decode(QueryResult.self, from: data) {
                completion(.success(book))
                print("Count: \(book.items.count)")
            } else {
                print("COULDN'T PARSE")
                print(data)
            }
        }
        
        dataTask.resume()
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
