//
//  ArticleTableViewController.swift
//  RSSReaderDemo
//
//  Created by Vernsu on 2017/2/16.
//  Copyright © 2017年 swift.diagon.me. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    fileprivate let feedParser = RSSParser()
    fileprivate let feedURL = "http://swift.diagon.me/rss.xml"
    fileprivate var rssItems: [Item]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
            self?.rssItems = rssItems
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        
        if let item = rssItems?[indexPath.row] {
            (cell.titleLabel.text,  cell.dateLabel.text) = (item.title,  item.pubDate)
        }
        return cell
    }
    

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArticleDetialViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.link = rssItems?[indexPath.row].link
        }
    }


}
