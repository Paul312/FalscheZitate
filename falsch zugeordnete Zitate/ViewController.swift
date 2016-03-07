//
//  ViewController.swift
//  falsch zugeordnete Zitate
//
//  Created by Paul Huebner on 05.03.16.
//  Copyright © 2016 Paul Huebner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var quote = QuoteManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateQuoteLabel()
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBAction func tappedButtonLeft(sender: AnyObject) {
        quote.previousQuote()
        updateQuoteLabel()
    }
    
    @IBAction func tappedButtonRight(sender: AnyObject) {
        quote.nextQuote()
        updateQuoteLabel()
    }
    
    @IBAction func tappedButtonSettings(sender: AnyObject) {
        print("open settings")
    }
    
    func updateQuoteLabel(){
        quoteLabel.text = quote.parser.getQuote(quote.count).getQuote
    }
}