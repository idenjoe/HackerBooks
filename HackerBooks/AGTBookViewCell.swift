//
//  AGTBookViewCell.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 13/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import UIKit

class AGTBookViewCell: UITableViewCell {
    var book : AGTBook?
    
    @IBOutlet weak var bookCellImageView: UIImageView!
    @IBOutlet weak var favIconButton: DOFavoriteButton!
    @IBOutlet weak var titleBookLabel: UILabel!
    @IBOutlet weak var authorsBookLabel: UILabel!
    
    override func awakeFromNib() {
        subscribeBookNotification()
    }
    
    deinit{
        unsubscribeBookNotification()
    }
    
    func subscribeBookNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "favoriteChanged:", name: "FavoriteChanged", object: nil)
    }
    
    func unsubscribeBookNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func favoriteChanged(notification: NSNotification){
        if let favorite = book?.isFavorite{
            if favorite{
                dispatch_async(dispatch_get_main_queue(), {
                    
                    // DO SOMETHING ON THE MAINTHREAD
                    self.favIconButton.select()
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.favIconButton.deselect()
                })
            }
        }
    }
}
