//
//  ViewController.swift
//  Book Searcher
//
//  Created by Bekzod Khaitboev on 4/24/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemArray: [String] = []
    var authorName: [String] = []
    var thumbnailURL: String = ""
    var descriptionText: String = ""
    
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
        cell.detailTextLabel?.text = authorName[indexPath.row]
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
            self.authorName.append(contentsOf: book.bookAuthor ?? ["Could not find the name of Author"])
            self.descriptionText.append(book.descriptionName ?? "There is no desciption ")
            self.thumbnailURL.append(book.thumbnailImage!)
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        DispatchQueue.main.async {
            detailVC?.bookNameLabel.text = self.itemArray[0]
            detailVC?.authorsNameLabel.text = self.authorName[0]
            detailVC?.decriptionText.text = self.descriptionText
            let urlString = self.thumbnailURL
            let url = URL(string: urlString)
            detailVC?.thumbnsailsImage.downloaded(from: url!)
        }
    }

}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

