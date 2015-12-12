//
//  AGTLibraryTableViewController.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 12/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import UIKit

class AGTLibraryTableViewController: UITableViewController {

    var model : AGTLibrary?
    
    private  func decodeJSON() ->[AGTBook]?{
        
        var result : [AGTBook]? = nil
        // Obtener la url del fichero
        // Leemos el fichero JSON a un NSDATA (esto puede salir mal)
        // Lo parseamos
        do{
            if let url = NSURL(string: "https://t.co/K9ziV0z3SJ"),
                data = NSData(contentsOfURL: url),
                booksArray = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray{
                    // Todo es fabuloso!!!
                    result = decode(books: booksArray)
            }
            
        }catch{
            // Error al parsear el JSON
            print("la cagamos, en vez de un JSON, me mandaron un camisón del Dávalos")
            
        }
        
        return result;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let books = decodeJSON(){
            model = AGTLibrary(arrayofBooks: books)
            
        }else{
            fatalError("Se jodió el invento, no hubo forma de parsear los personajes")
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath)


        return cell
    }

}
