//
//  RSSParser.swift
//  RSSReaderDemo
//
//  Created by Vernsu on 2017/2/16.
//  Copyright © 2017年 swift.diagon.me. All rights reserved.
//

import Foundation
class RSSParser:NSObject, XMLParserDelegate{
    
    fileprivate var rssItems = [Item]()
    
    fileprivate var currentElement = ""
    
    fileprivate var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    fileprivate var currentLink = "" {
        didSet {
            currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var parserCompletionHandler: (([Item]) -> Void)?
    
    func parseFeed(feedURL: String, completionHandler: (([Item]) -> Void)?) -> Void {
        
        parserCompletionHandler = completionHandler
        
        guard let feedURL = URL(string:feedURL) else {
            print("URL 无效")
            return
        }
        
        URLSession.shared.dataTask(with: feedURL, completionHandler: { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("无数据")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }).resume()
    }
    
    // MARK: - XMLParser Delegate
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentLink = ""
        }
    }
    //// 遇到字符串时触发
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        /// Note: current string may only contain part of info.
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        case "pubDate":
            currentPubDate += string
        case "link":
            currentLink += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let item = Item(title: currentTitle, description: currentDescription, pubDate: currentPubDate, link:currentLink)
            rssItems.append(item)
        }
    }
    
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }

}
