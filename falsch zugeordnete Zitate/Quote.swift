//
//  Quote.swift
//  falsch zugeordnete Zitate
//
//  Created by Paul Huebner on 05.03.16.
//  Copyright © 2016 Paul Huebner. All rights reserved.
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
            if quoteNumber >= 0 || quoteNumber <= 365 {
                self.numOfQuote = quoteNumber
            }
        }
    }
    
    init(numOfQuote: Int){
        self.numOfQuote = numOfQuote
    }
    
    //This class would need a function to read the quotes from the xml document
}





