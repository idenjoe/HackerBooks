//
//  AGTLibrary.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 12/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import Foundation

class AGTLibrary {
    
    //MARK: - Properties
    private var books : [AGTBook]
    
    private var arrayOfTags: [AGTTag]?
    private var tags : [AGTTag]?{
        get{
            if let arrayTags = arrayOfTags{
                return arrayTags.sort { $0.0.name.lowercaseString < $0.1.name.lowercaseString }
            }
            
            return nil
        }
        set{
            if let newTags = newValue {
                arrayOfTags = newTags
            }
        }
    }
    
    //MARK - Initializers
    init(arrayofBooks : [AGTBook], arrayOfTags: [AGTTag]){
        // Initi the dictcionary
        books = arrayofBooks
        tags = arrayOfTags
    }
    
    var booksCount: Int{
        get{
            return books.count
        }
    }
    
    var countTags: Int{
        get{
            if let tags = tags{
                return tags.count
            }
            return 0
        }
    }
    
    func bookCountForTag(tag: String) -> Int{
        if let books = booksForTag(tag){
            return books.count
        }
        
        return 0
    }
    
    func booksForTag(tag: String) -> [AGTBook]?{
        var booksForTag = [AGTBook]()
        for book in books{
            if book.tags.contains(AGTTag(name: tag)){
                booksForTag.append(book)
            }
        }
        
        booksForTag = booksForTag.sort { $0.0.title.lowercaseString < $0.1.title.lowercaseString }
        
        return booksForTag
    }
    
    func bookAtIndex(index: Int, tag: AGTTag) -> AGTBook?{
        if let tagBooks = self.booksForTag(tag.name){
            return tagBooks[index]
        }
        
        return nil
    }
    
    func tagAtIndex(raw: Int) -> AGTTag?{
        if let tags = tags{
            return tags[raw]
        }
        
        return nil
    }
}