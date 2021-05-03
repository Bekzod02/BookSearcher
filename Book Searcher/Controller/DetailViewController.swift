//
//  DetailViewController.swift
//  Book Searcher
//
//  Created by Bekzod Khaitboev on 4/27/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorsNameLabel: UILabel!
    @IBOutlet weak var decriptionText: UILabel!
    @IBOutlet weak var thumbnsailsImage: UIImageView!
    var book: BookModel?
    
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookNameLabel.text = book?.bookName
        authorsNameLabel.text = "By: \(book?.bookAuthor?[0] ?? "Unknown")"
        decriptionText.text = book?.descriptionName ?? "No Description"
        let urlString = (book?.thumbnailImage)!
        let url = URL(string: urlString)!
        thumbnsailsImage.downloaded(from: url)
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


