//
//  DetailViewController.swift
//  Book Searcher
//
//  Created by Bekzod Khaitboev on 4/27/21.
//

import UIKit

class DetailViewController: UIViewController {

    var bookManager = BookManager()
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorsNameLabel: UILabel!
    @IBOutlet weak var decriptionText: UILabel!
    @IBOutlet weak var thumbnsailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
}

