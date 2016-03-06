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
    
    var objects = [Dictionary<String,String>]()
    var object = Dictionary<String, String>()
    var inItem = false
    var current = String()
    
    var handler: (() -> Void)?
    
    init(url: NSURL) {
        self.url = url
    }
    
    func parse(handler: () -> Void) {
        self.handler = handler
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // Anderer Thread
            
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
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributesDict: [NSObject : AnyObject]!) {
        if elementName == "quote" {
            object.removeAll(keepCapacity: false)
            inItem = true
        } else {
            //print("Klinger")
        }
        current = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        print(string)
        if !inItem {
            return
        }
        if let temp = object[current] {
            var tempString = temp
            tempString += string
            object[current] = tempString
            //print("Sven: \(string)")
        } else {
            object[current] = string
            //print("Unfug")
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "quote" {
            inItem = false
            objects.append(object)
            //print("Klinger")
            //print(object)
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue()) {
            if (self.handler != nil) {
                self.handler!()
            }
        }
    }
}