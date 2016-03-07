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
        
        updateLabels()
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
    
    func updateLabels(){
        quoteLabel.text = "\"quote.parser.getQuote(quote.count).getQuote\""
        authorLabel.text = "- \(quote.parser.getQuote(quote.count).getAuthor) -"
    }
}