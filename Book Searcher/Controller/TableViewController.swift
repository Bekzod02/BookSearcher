//
//  ViewController.swift
//  Book Searcher
//
//  Created by Bekzod Khaitboev on 4/24/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemArray: [String] = []
    
    var bookManager = BookManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
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
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue,
      sender: Any?) {

        let detailVC = segue.destination as? DetailViewController
        DispatchQueue.main.async {
            detailVC?.bookNameLabel.text = self.itemArray[0]
        }
    }

}
