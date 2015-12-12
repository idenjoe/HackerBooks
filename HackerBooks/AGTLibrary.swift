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
    private var books : [AGTTag:[AGTBook]]
    
    //MARK - Initializers
    init(arrayofBooks : [AGTBook]){
        // Initi the dictcionary
        books = Dictionary<AGTTag, Array<AGTBook>>()
        
        for eachBook in arrayofBooks{
            for eachTag in eachBook.tags{
                books[eachTag]?.append(eachBook)
            }
        }
    }
    
    var booksCount: Int{
        get{
            var count = 0
            for tag in books.keys{
                if let booksOnTag = books[tag]{
                    count += booksOnTag.count
                }
            }
            return count
        }
    }
    
    func bookCountForTag(tag: AGTTag) -> Int{
        if let tagBooks = self.books[tag]{
            return tagBooks.count
        }
        
        return 0
    }
    
    func booksForTag(tag: AGTTag) -> [AGTBook]?{
        return self.books[tag]
    }
    
    func booksAtIndex(index: Int, tag: AGTTag) -> AGTBook?{
        if let tagBooks = self.booksForTag(tag){
            return tagBooks[index]
        }
        
        return nil
    }
}