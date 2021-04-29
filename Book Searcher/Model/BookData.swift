//
//  BookData.swift
//  Book Searcher
//
//  Created by Bekzod Khaitboev on 4/24/21.
//

import Foundation

struct BookData: Codable {
    var items: [Items]
}

struct Items: Codable {
    var volumeInfo: Title
}

struct Title: Codable {
    var title: String
    //var imageLinks: Thumbnail
    //var authors: [String]
    
}

//struct Thumbnail: Codable {
//    var thumbnail: String
//}
//items[0].volumeInfo.title
//items[0].volumeInfo.imageLinks.thumbnail
//items[8].volumeInfo.authors
//items[7].volumeInfo.authors

