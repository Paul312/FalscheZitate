//
//  QuoteManager.swift
//  Falsche Zitate
//
//  Created by Paul Huebner on 06.03.16.
//  Copyright © 2016 Cappricorn. All rights reserved.
//

import Foundation

class QuoteManager: XMLParserDelegate {
    
    var count = 0
    let bundleURL = NSBundle.mainBundle().bundleURL
    
    var parser : XMLParser
    
    var getCount: Int {
        get {
            return count
        }
    }
    
    init() {
        let fileURL = bundleURL.URLByAppendingPathComponent("quotes.xml")
        parser = XMLParser(url: fileURL)
        parser.parse {
            //nothing
        }
    }
    
    func nextQuote() {
        self.count++
        count = outOfRange(count)
        saveCurrentQuote(count)
    }
    
    func previousQuote() {
        self.count--
        count = outOfRange(count)
        saveCurrentQuote(count)
    }
    
    func outOfRange(count:Int) -> Int {
        if count < 0 {
            return 364
        } else if count > 364 {
            return 0
        } else {
            return count
        }
    }
    
    func getCurrentQuote() {
        if let savedValue = NSUserDefaults.standardUserDefaults().valueForKey("savedValue") as? Int {
            count = savedValue
        } else {
            count = 0
        }
    }
    
    func saveCurrentQuote(value: Int) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: "savedValue")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func XMLParserError(parser: XMLParser, error: String) {
        print("Error")
    }
}