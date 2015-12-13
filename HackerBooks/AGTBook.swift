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
    let tags : [AGTTag]
    let imageURL : NSURL
    let pdfURL : NSURL
    let isFavorite : Bool
    
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
            self.tags = tags
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
