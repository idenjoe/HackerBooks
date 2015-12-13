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
    
    @IBOutlet weak var favIconButton: DOFavoriteButton!
    var book : AGTBook?{
        didSet{
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book"
        if (book != nil){
            updateUI()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        noBookView?.hidden = true
        if let title = book?.title{
            titleLabel?.text = title
        }
        
        if let authors = book?.authors{
            authorsLabel?.text = authors
        }
        
        var tagsNames = [String]()
        if let tags = book?.tags{
            for tag in tags{
                tagsNames.append(tag.name)
            }
            
            let unifiedTagString = tagsNames.joinWithSeparator(", ")
            
            tagsLabel?.text = unifiedTagString
        }
        if  bookImageView != nil{
            if let imageURL = book?.imageURL {
                let stringURL = "\(imageURL)"
                ImageLoader.sharedLoader.imageForUrl(stringURL, completionHandler:{(image: UIImage?, url: String) in
                    self.bookImageView.image = image
                })
            }
        }
        
        if let isFavorite = book?.isFavorite{
            if favIconButton != nil {
                favIconButton.selected = isFavorite
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPDF"{
            let pdfController = segue.destinationViewController as? AGTSimplePDFViewController
            if let pdfURL = book?.pdfURL{
                pdfController?.pdfURL = pdfURL
            }
        }
    }
    
    @IBAction func favIconTapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            book?.isFavorite = false
        }else{
            sender.select()
            book?.isFavorite = true
        }
    }
}
