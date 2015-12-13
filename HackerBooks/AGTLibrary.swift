//
//  AGTLibrary.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 12/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import Foundation

class AGTLibrary : NSObject {
    
    //MARK: - Properties
    private var books : [AGTBook]
    
    private var arrayOfTags: [AGTTag]?
    private var tags : [AGTTag]?{
        get{
            if let arrayTags = arrayOfTags{
                // ÑAPA
                var tagsOrdered = arrayTags.sort { $0.0.name.lowercaseString < $0.1.name.lowercaseString }
                let favoriteTag = AGTTag(name: "Favorite")
                if tagsOrdered.contains(favoriteTag){
                    if let position = tagsOrdered.indexOf(favoriteTag){
                        tagsOrdered.removeAtIndex(position)
                        tagsOrdered.insert(favoriteTag, atIndex: 0)
                    }
                }
                return tagsOrdered
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
        super.init()
        tags = arrayOfTags
        subsCribeNotificationModel()
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
    
    func subsCribeNotificationModel(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "favoriteChanged:", name: "FavoriteChanged", object: nil)
    }
    
    func unsubscribeNotificationModel(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    func favoriteChanged(notification: NSNotification) {
        let book = notification.object as? AGTBook
        if let favorite = book?.isFavorite{
            if favorite{
                // Añadir a favoritos
                arrayOfTags?.insert(AGTTag(name: "Favorite"), atIndex: 0)
            }else{
                // Eliminar de favoritos
                arrayOfTags?.removeAtIndex(0)
            }
        }
    }
    
    deinit{
        unsubscribeNotificationModel()
    }
}