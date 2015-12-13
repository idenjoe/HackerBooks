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
    private var _name: String? = nil
    var name : String{
        set{
            self._name = newValue
        }
        get {
            if let name = _name{
                return name.lowercaseString.capitalizedString
            }
            
            return ""
        }
    }
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

extension AGTTag: CustomStringConvertible{
    
    var description: String{
        
        get{
            return "<\(self.dynamicType): \(name)>"
        }
    }
}