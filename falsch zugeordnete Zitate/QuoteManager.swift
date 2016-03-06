//
//  QuoteManager.swift
//  Falsche Zitate
//
//  Created by Paul Huebner on 06.03.16.
//  Copyright © 2016 Paul Huebner. All rights reserved.
//

import Foundation

class QuoteManager {
    
    private var quotes = [Quote]()
    private var count = 0
    
    var getCount: Int {
        get {
            return count
        }
    }
    
    init(){
        for var i=0; i<=365; i++ {
            quotes.append(Quote(numOfQuote: i))
        }
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
        return "\"Luki mach hinne, damit hier was vernünftiges drin steht xD \(count)\""
    }
    
    func saveCurrentQuote(value: Int) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: "savedValue")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}