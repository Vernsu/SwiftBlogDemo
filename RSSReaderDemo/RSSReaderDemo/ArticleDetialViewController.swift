//
//  ArticleDetialViewController.swift
//  RSSReaderDemo
//
//  Created by Vernsu on 2017/2/16.
//  Copyright © 2017年 swift.diagon.me. All rights reserved.
//

import UIKit

class ArticleDetialViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var link:String? = "http://swift.diagon.me"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.loadRequest(URLRequest.init(url: URL.init(string: link!)!))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
