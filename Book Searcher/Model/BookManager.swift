//
//  BookManager.swift
//  Book Searcher
//
//  Created by Bekzod Khaitboev on 4/24/21.
//

import UIKit

protocol BookManagerDelegate {
    func didUpdateBook(book: BookModel) 
    func didFailWithError(error: Error)
}

struct BookManager {
    let bookURL = "https://www.googleapis.com/books/v1/volumes"
    
    func fetchBookName(name: String)  {
        let urlString = "\(bookURL)?q=\(name)"
        performRequest(with: urlString)
    }
    
    var delegate: BookManagerDelegate?
    
    
    func performRequest(with urlString: String)  {
        if let url = URL(string: urlString) {
            
        let sessison = URLSession(configuration: .default)
        
        let task = sessison.dataTask(with: url) { (data, response, error) in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data {
                if let book = parseJSON(bookData: safeData) {
                    self.delegate?.didUpdateBook(book: book)
                }
            }
        }
    
            task.resume()
    }
    
}

    func parseJSON(bookData: Data) -> BookModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BookData.self, from: bookData)
            let title = decodedData.items[0].volumeInfo.title
            let author = decodedData.items[0].volumeInfo.authors
            let thumbnail = decodedData.items[0].volumeInfo.imageLinks.thumbnail
            let description = decodedData.items[0].volumeInfo.description
            let book = BookModel(bookName: title, bookAuthor: author, thumbnailImage: thumbnail, descriptionName: description)
            return book
        } catch {
            print(error)
            return nil
        }
        
    }
}
