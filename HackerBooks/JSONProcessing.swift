//
//  JSONProcessing.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 12/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import UIKit

enum JSONKeys: String{
    case authors = "authors"
    case imageURL  = "image_url"
    case pdfURL = "pdf_url"
    case tags = "tags"
    case title = "title"
}

//MARK: - Aliases
typealias JSONObject        = AnyObject
typealias JSONDictionary    = [String:JSONObject]
typealias JSONArray         = [JSONDictionary]

//MARK: - Errors
enum JSONProcessingError : ErrorType{
    case WrongURLFormatForJSONResource
    case ResourcePointedByURLNotReachable
    case JSONParsingError
    case WrongJSONFormat
}

//MARK - Structs

//MARK: - Decoding
func decode(book json: JSONDictionary) throws -> AGTBook{
    
    // Nos metemos en el mundo imaginario de Yupi donde todo funciona y nada es nil
    guard let authorsString = json[JSONKeys.authors.rawValue] as? String else{
            throw JSONProcessingError.WrongJSONFormat
    }
    
    guard let imageURLString = json[JSONKeys.imageURL.rawValue] as? String,
        imageURL = NSURL(string: imageURLString) else{
            throw JSONProcessingError.WrongURLFormatForJSONResource
    }
    
    guard let pdfURLString = json[JSONKeys.pdfURL.rawValue] as? String,
        pdfURL = NSURL(string: pdfURLString) else{
            throw JSONProcessingError.WrongURLFormatForJSONResource
    }
    
    guard let tagsStrings = json[JSONKeys.tags.rawValue] as? String else{
        
        throw JSONProcessingError.WrongJSONFormat
    }
    
    guard let title = json[JSONKeys.title.rawValue] as? String else{
        throw JSONProcessingError.WrongJSONFormat
    }
    
    let authors = authorsString.componentsSeparatedByString(",")
    let tagsStringsArray = tagsStrings.componentsSeparatedByString(",")
    
    var tags = [AGTTag]()
    for eachTagString in tagsStringsArray{
        let newTag = AGTTag(name: eachTagString)
        tags.append(newTag)
    }
    
    return AGTBook(title: title, author: authors, tags: tags, imageURL: imageURL, pdfURL: pdfURL, isFavorite: false)
}

func decode(books json: JSONArray) -> [AGTBook]{
    
    var results = [AGTBook]()
    
    do{
        // Patearse todo el JSONArray
        for dict in json{
            // JSONDict que veo, JSONDict que convierto en StrictStarWarsCharacter
            print(dict)
            let s = try decode(book: dict)
            
            // pal saco!
            results.append(s)
        }
    }catch{
        fatalError("Ahora sí que la jodimos")
    }
    // Devuelvo el array de StrictStarWarsCharacters
    return results
    
}

//MARK: - Initialization

extension AGTBook{
    // Un init que acepta los parámetros empaquetados en un
    // StrictStarWarsCharacter
    convenience init(book c: AGTBook){
        
        self.init(title : c.title,
            author : c.author,
            tags : c.tags,
            imageURL : c.imageURL,
            pdfURL : c.pdfURL,
            isFavorite : c.isFavorite)
    }
}


extension AGTLibrary{
    
    convenience init(characters cs: [AGTBook]){
        
        // Patearse el array [StrictStarWarsCharacter]
        var chars = [AGTBook]()
        for each in cs{
            // Pa cada uno que encuentre, lo transofrmo en un personaje
            let c = AGTBook(book: each)
            // Lo encasqueto en un array
            chars.append(c)
        }
        // le paso el array y el marrón a mi init designado
        self.init(arrayofBooks: chars)
    }
}








