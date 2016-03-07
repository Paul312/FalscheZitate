//
//  XMLParser.swift
//  Falsche Zitate
//
//  Created by Lukas Schramm on 06.03.16.
//  Copyright © 2016 Paul Huebner. All rights reserved.
//

import Foundation

protocol XMLParserDelegate {
    func XMLParserError(parser: XMLParser, error: String)
}

class XMLParser: NSObject, NSXMLParserDelegate {
    let url: NSURL
    var delegate: XMLParserDelegate?
    
    var quotetext : String = ""
    var author : String = ""
    var quotes = [Quote]()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var handler: (() -> Void)?
    
    init(url: NSURL) {
        self.url = url
    }
    
    func parse(handler: () -> Void) {
        self.handler = handler
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //other Thread
            
            let xmlCode = NSData(contentsOfURL: self.url)
            let parser = NSXMLParser(data: xmlCode!)
            parser.delegate = self
            if !parser.parse() {
                self.delegate?.XMLParserError(self, error: "Parsen fehlgeschlagen")
            }
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        delegate?.XMLParserError(self, error: parseError.localizedDescription)
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        if elementName == "quote" {
            elements = [:]
            author = ""
            quotetext = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if element == "author" {
            let trimmed = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            author += trimmed
        } else if element == "text" {
            let trimmed = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            quotetext += trimmed
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqualToString("quote") {
            if !author.isEqual(nil) {
                elements.setObject(author, forKey: "author")
            }
            if !quotetext.isEqual(nil) {
                elements.setObject(quotetext, forKey: "text")
            }
            quotes.append(Quote(numOfQuote: quotes.count, quote: elements["text"]! as! String, author: elements["author"]! as! String))
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue()) {
            if (self.handler != nil) {
                self.handler!()
            }
        }
    }
    
    func getQuote(num:Int) -> Quote {
        return quotes[num]
    }
}