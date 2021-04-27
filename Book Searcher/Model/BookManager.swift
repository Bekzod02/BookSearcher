//
//  BookManager.swift
//  Book Searcher
//
//  Created by Bekzod Khaitboev on 4/24/21.
//

import UIKit

protocol BookManagerDelegate {
    func didUpdateBook(book: BookModel)
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
                print(error!)
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
            //let thumbnail = decodedData.items[0].volumeInfo.imageLinks.thumbnail
            //let author = decodedData.items[7].volumeInfo.authors[0]
            print(title)
            let book = BookModel(bookName: title)
            return book
        } catch {
            print(error)
            return nil
        }
        
    }
}
