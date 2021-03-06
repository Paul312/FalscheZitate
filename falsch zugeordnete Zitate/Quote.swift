//
//  Quote.swift
//  falsch zugeordnete Zitate
//
//  Created by Paul Huebner on 05.03.16.
//  Copyright © 2016 Cappricorn. All rights reserved.
//

import Foundation

class Quote {
    private var numOfQuote = 0
    private var quote = ""
    private var author = ""
    
    var quoteNumber: Int {
        get {
            return self.numOfQuote
        } set {
            if quoteNumber >= 0 && quoteNumber <= 365 {
                self.numOfQuote = quoteNumber
            }
        }
    }
    
    var getQuote: String {
        return self.quote
    }
    
    var getAuthor: String {
        return self.author
    }
    
    init(numOfQuote: Int, quote: String, author: String) {
        self.numOfQuote = numOfQuote
        self.quote = quote
        self.author = author
    }
}