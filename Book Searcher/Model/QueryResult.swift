//
//  Book.swift
//  Book Searcher
//
//  Created by Mustafo on 16/03/22.
//

import Foundation

//   let book = try? newJSONDecoder().decode(Book.self, from: jsonData)

// MARK: - Book
struct QueryResult: Codable {
    let items: [Book]
}

// MARK: - Item
struct Book: Codable {
    let id, etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
}



// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher, publishedDate, volumeInfoDescription: String?
    let pageCount: Int?
    let printType: PrintType?
    let categories: [String]?
    let maturityRating: MaturityRating?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let imageLinks: ImageLinks?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
    let subtitle: String?

    enum CodingKeys: String, CodingKey {
        case title, authors, publisher, publishedDate
        case volumeInfoDescription = "description"
        case pageCount, printType, categories, maturityRating, allowAnonLogging, contentVersion, imageLinks, previewLink, infoLink, canonicalVolumeLink, subtitle
    }
    
    var smallImageLink: URL? {
        guard let imageLinks = imageLinks else {
            return nil
        }
        var components = URLComponents(string: imageLinks.smallThumbnail)
        components?.scheme = "https"
        return components?.url
    }
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}


enum MaturityRating: String, Codable {
    case notMature = "NOT_MATURE"
}

enum PrintType: String, Codable {
    case book = "BOOK"
}

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func bookTask(with url: URL, completionHandler: @escaping (QueryResult?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
