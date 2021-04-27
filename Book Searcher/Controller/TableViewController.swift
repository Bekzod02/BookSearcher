//
//  ViewController.swift
//  Book Searcher
//
//  Created by Bekzod Khaitboev on 4/24/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemArray: [String] = ["Hello", "Welcome"]
    var bookManager = BookManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bookManager.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableOfBooks", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
}


extension TableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchedBook = searchBar.text {
            bookManager.fetchBookName(name: searchedBook)
        } else {
            print("Could not find this book")
        }
    }
    
}

extension TableViewController: BookManagerDelegate {
    func didUpdateBook(book: BookModel) {
        DispatchQueue.main.async {
            self.itemArray.append(book.bookName)
            self.tableView.reloadData()
        }
    }
}
