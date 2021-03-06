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
            let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let writePath = documents.stringByAppendingString("/books.json")
            
            let firstLaunch = !NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
            let fileExist = NSFileManager.defaultManager().fileExistsAtPath(writePath)
            if firstLaunch {
                if let url = NSURL(string: "https://t.co/K9ziV0z3SJ"),
                    data = NSData(contentsOfURL: url),
                    booksArray = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray{
                        saveData(data)
                        // Todo es fabuloso!!!
                        result = decode(books: booksArray)
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
                }
            }
            else if fileExist {
                result = try loadJSONLocally()
            }else{
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "FirstLaunch")
            }
        }catch{
            // Error al parsear el JSON
            fatalError()
        }
        
        return result;
        
    }
    
    func saveData(data: NSData){
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        let writePath = NSURL(fileURLWithPath: documents).URLByAppendingPathComponent("books.json")
        data.writeToURL(writePath, atomically: false)
    }
    
    func loadJSONLocally() throws -> [AGTBook]?{
        do{
            let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let writePath = NSURL(fileURLWithPath: documents).URLByAppendingPathComponent("books.json")
            if let data = NSData(contentsOfURL: writePath),
                booksArray = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray{
                    // Todo es fabuloso!!!
                    return decode(books: booksArray)
            }
        }catch{
            fatalError()
        }
        
        
        return nil
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
    
    override func viewWillAppear(animated: Bool) {
        subsCribeNotificationModel()
        self.tableView.reloadData()
    }
    
    func subsCribeNotificationModel(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "favoriteChanged:", name: "FavoriteChanged", object: nil)
    }
    
    func unsubscribeNotificationModel(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath) as? AGTBookViewCell
        let tagSelected = model?.tagAtIndex(indexPath.section)
        let selectedBook = model?.bookAtIndex(indexPath.row, tag: tagSelected!)
        
        cell!.titleBookLabel.text = selectedBook?.title
        cell!.authorsBookLabel.text = selectedBook?.authors
        if let isFavorite = selectedBook?.isFavorite{
            if isFavorite{
                cell!.favIconButton.select()
            }else{
                cell!.favIconButton.deselect()
            }
        }
        
        if let imageURL = selectedBook?.imageURL {
            let stringURL = "\(imageURL)"
            ImageLoader.sharedLoader.imageForUrl(stringURL, completionHandler:{(image: UIImage?, url: String) in
                cell!.bookCellImageView.image = image
            })
        }
        
        cell!.book = selectedBook

        return cell!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let tagSelected = model?.tagAtIndex(section){
            return tagSelected.name
        }
        
        return nil
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (self.splitViewController?.viewControllers.count > 1) {
            let detailVC = self.splitViewController!.viewControllers[1] as? UINavigationController
            if detailVC?.viewControllers.count > 1{
                if let viewControllers = detailVC?.viewControllers{
                    let pdfController = viewControllers.last as? AGTSimplePDFViewController
                    let bookController = viewControllers.first as? AGTBookViewController
                    let cell = sender as? AGTBookViewCell
                    pdfController?.pdfURL = cell?.book?.pdfURL
                    bookController?.book = cell?.book
                NSNotificationCenter.defaultCenter().postNotificationName("BookChanged", object: nil)
                }
                return false
            }
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showBook"){
            print(sender)
            let ip = self.tableView.indexPathForSelectedRow
            let selectedTag = model?.tagAtIndex((ip?.section)!)
            let selectedBook = model?.bookAtIndex((ip?.row)!, tag: selectedTag!)
            let detailNavVC = segue.destinationViewController as? UINavigationController
            let bookVC = detailNavVC?.viewControllers.first as? AGTBookViewController
            bookVC?.book = selectedBook
        }
    }
    
    func favoriteChanged(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
    }
    
    deinit{
        unsubscribeNotificationModel()
    }

}
