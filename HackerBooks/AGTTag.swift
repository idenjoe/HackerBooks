//
//  AGTTag.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 12/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import Foundation

class AGTTag : Hashable, Comparable {
    //MARK - Properties
    var name : String
    var hashValue : Int{
        get{
            return name.hashValue
        }
    }
    
    //MARK: - Initializers
    
    init(name: String){
        self.name = name
    }
    
    var proxyForSorting : String{
        get{
            return "A\(name)"
        }
    }
}

func ==(lhs: AGTTag, rhs: AGTTag) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

func <(lhs: AGTTag, rhs: AGTTag) -> Bool{
    
    return (lhs.proxyForSorting < rhs.proxyForSorting)
}