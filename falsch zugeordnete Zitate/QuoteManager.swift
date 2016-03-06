//
//  QuoteManager.swift
//  Falsche Zitate
//
//  Created by Paul Huebner on 06.03.16.
//  Copyright © 2016 Paul Huebner. All rights reserved.
//

import Foundation

class QuoteManager: XMLParserDelegate {
    
    private var quotes = [Quote]()
    private var count = 0
    let bundleURL = NSBundle.mainBundle().bundleURL
    //let kURL = NSURL(string: "./quotefiles/quotes.xml")
    
    var parser : XMLParser
    
    var getCount: Int {
        get {
            return count
        }
    }
    
    init(){
        for var i=0; i<=365; i++ {
            quotes.append(Quote(numOfQuote: i))
        }
        //let dataFolderURL = bundleURL.URLByAppendingPathComponent("quotefiles")
        let fileURL = bundleURL.URLByAppendingPathComponent("quotes.xml")
        parser = XMLParser(url: fileURL)
        parser.parse {
            //tableviewreloaddate hm, was hier wohl hinkommt?
        }
        //here is a problem=====================
        
        //let klinger = parser.objects
        //print("===========")
        //print(klinger)
        
        //Er hatte dann hier:
        //parser.objects[indexPath.row]["author"]
        //parser.objects[indexPath.row]["text"]
    }
    
    func nextQuote() -> String{
        self.count++
        count = outOfRange(count)
        saveCurrentQuote(count)
        return getCurrentQuote()
    }
    
    func previousQuote() -> String{
        self.count--
        count = outOfRange(count)
        saveCurrentQuote(count)
        return getCurrentQuote()
    }
    
    func outOfRange(count:Int) -> Int {
        if count < 0{
            return 365
        } else if count > 365 {
            return 0
        } else {
            return count
        }
    }
    func getCurrentQuote() -> String {
        if let savedValue = NSUserDefaults.standardUserDefaults().valueForKey("savedValue") as? Int{
            count = savedValue
        } else {
            count = 0
        }
        return "\(quotes.count)"
    }
    
    func saveCurrentQuote(value: Int) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: "savedValue")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func XMLParserError(parser: XMLParser, error: String) {
        print("Error")
    }
}