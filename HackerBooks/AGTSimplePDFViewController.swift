//
//  AGTSimplePDFViewController.swift
//  HackerBooks
//
//  Created by José Manuel Rodríguez Moreno on 12/12/15.
//  Copyright © 2015 Idenjoe.es. All rights reserved.
//

import UIKit

class AGTSimplePDFViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!
    var pdfURL : NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if webview != nil {
            updateUI()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subsCribeNotificationModel()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeNotificationModel()
    }
    
    func subsCribeNotificationModel(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bookChanged:", name: "BookChanged", object: nil)
    }
    
    func unsubscribeNotificationModel(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func updateUI(){
        if pdfURL != nil{
            let urlRequest = NSURLRequest(URL: pdfURL!)
            webview.loadRequest(urlRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bookChanged(notification: NSNotification){
        updateUI()
    }
}
