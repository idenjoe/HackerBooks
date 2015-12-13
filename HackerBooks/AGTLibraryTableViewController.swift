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
        self.title = "Library"
        // configuring splitviewcontroller
        if let books = decodeJSON(){
            var uniqueTags = [AGTTag]()
            for book in books{
                for tag in book.tags{
                    if !uniqueTags.contains(tag){
                        uniqueTags.append(tag)
                    }
                }
            }
            model = AGTLibrary(arrayofBooks: books, arrayOfTags: uniqueTags)
        }else{
            fatalError("Se jodió el invento, no hubo forma de parsear los libros")
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let countTags = model?.countTags{
            return countTags
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let tag = model?.tagAtIndex(section){
            return model!.bookCountForTag(tag.name)
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath)
        let tagSelected = model?.tagAtIndex(indexPath.section)
        let selectedBook = model?.bookAtIndex(indexPath.row, tag: tagSelected!)
        
        cell.textLabel?.text = selectedBook?.title
        cell.detailTextLabel?.text = selectedBook?.authors

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let tagSelected = model?.tagAtIndex(section){
            return tagSelected.name
        }
        
        return nil
    }

}
