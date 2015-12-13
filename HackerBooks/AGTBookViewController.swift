//
//  AGTBookViewController.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 12/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import UIKit

class AGTBookViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var noBookView: UIView!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    var book : AGTBook?{
        didSet{
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        self.noBookView.hidden = true
        if let title = book?.title{
            self.titleLabel.text = title
        }
        
        if let authors = book?.authors{
            self.authorsLabel.text = authors
        }
        
        var tagsNames = [String]()
        if let tags = book?.tags{
            for tag in tags{
                tagsNames.append(tag.name)
            }
            
            let unifiedTagString = tagsNames.joinWithSeparator(", ")
            
            self.tagsLabel.text = unifiedTagString
        }
    }
}
