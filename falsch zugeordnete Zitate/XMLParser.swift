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

class XMLParser: NSObject {
    let url: NSURL
    var delegate: XMLParserDelegate?
    
    var objects = [Dictionary<String,String>]()
    
    var handler: (() -> Void)?
    
    init(url: NSURL) {
        self.url = url
    }
    
    func parse(handler: () -> Void) {
        self.handler = handler
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // Anderer Thread
            
            let xmlCode = NSData(contentsOfURL: self.url)
            let string = NSString(data: xmlCode!, encoding: NSUTF8StringEncoding)
            print(string)
        }
    }
}