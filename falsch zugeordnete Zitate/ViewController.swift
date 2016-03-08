//
//  ViewController.swift
//  falsch zugeordnete Zitate
//
//  Created by Paul Huebner on 05.03.16.
//  Copyright © 2016 Cappricornr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var quote = QuoteManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.quote.getCurrentQuote()
            dispatch_async(dispatch_get_main_queue()) {
                self.updateLabels()
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func tappedButtonLeft(sender: AnyObject) {
        quote.previousQuote()
        updateLabels()
    }
    
    @IBAction func tappedButtonRight(sender: AnyObject) {
        quote.nextQuote()
        updateLabels()
    }
    
    @IBAction func tappedButtonSettings(sender: AnyObject) {
        print("open settings")
    }
    
    func updateLabels() {
        quoteLabel.text = "\"\(quote.parser.getQuote(quote.count).getQuote)\""
        authorLabel.text = "- \(quote.parser.getQuote(quote.count).getAuthor) -"
        quote.saveCurrentQuote(quote.count)
    }
}