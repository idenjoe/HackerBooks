//
//  AGTBook.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 12/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import Foundation

class AGTBook {
    
    //MARK: - Properties
    let title : String
    let author : [String]
    private var arrayOfTags : [AGTTag]
    let imageURL : NSURL
    let pdfURL : NSURL
    var isFavorite : Bool{
        didSet{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
                if self.isFavorite {
                    self.arrayOfTags.insert(AGTTag(name: "Favorite"), atIndex: 0)
                }else{
                    self.arrayOfTags.removeAtIndex(0)
                }
                NSNotificationCenter.defaultCenter().postNotificationName("FavoriteChanged",object: self)
            }
        }
    }
    
    var tags: [AGTTag]{
        get{
            return arrayOfTags
        }
    }
    
    
    var authors : String{
        get{
            return author.joinWithSeparator(", ")
        }
    }
    
    //MARK: - Initializers
    init(title : String,
        author : [String],
        tags : [AGTTag],
        imageURL : NSURL,
        pdfURL : NSURL,
        isFavorite : Bool){
            self.title = title
            self.author = author
            self.arrayOfTags = tags
            self.imageURL = imageURL
            self.pdfURL = pdfURL
            self.isFavorite = isFavorite
    }
}

extension AGTBook: CustomStringConvertible{
    
    var description: String{
        
        get{
            return "<\(self.dynamicType): \(title)>"
        }
    }
}
