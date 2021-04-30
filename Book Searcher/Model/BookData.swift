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
    var volumeInfo: Info
}

struct Info: Codable {
    var title: String
    var authors: [String]?
    var imageLinks: ImageLinks
    
}


struct ImageLinks: Codable {
    var thumbnail: String?
    
}


//items[0].volumeInfo.imageLinks.thumbnail
