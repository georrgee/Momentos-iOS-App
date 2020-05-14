//
//  HomeController.swift
//  Momentos
//
//  Created by George Garcia on 5/14/20.
//  Copyright © 2020 GeeTeam. All rights reserved.
//

import UIKit
import WebKit

class HomeController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = .init(title: "Fetch Posts", style: .plain, target: self, action: #selector(fetchPosts))

    }
    
    @objc fileprivate func fetchPosts() {
        
        guard let url = URL(string: "http://localhost:1337/post") else { return } // brand new url
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in // calling this and fetch
            
            DispatchQueue.main.async {
                if let err = error {
                    print("Failed to hit server: \(err)")
                    return
                } else if let resp = response as? HTTPURLResponse, resp.statusCode != 200 {
                    print("Failed to fetch posts, status code: \(resp)")
                    return
                } else {
                    // ignoring for now
                    print("Successfully fetched posts, response data:")
                    let html = String(data: data ?? Data(), encoding: .utf8) ?? ""
                    print(html)
                    let vc = ViewController()
                    let webView = WKWebView()
                    webView.loadHTMLString(html, baseURL: nil)
                    vc.view.addSubview(webView)
                    webView.fillSuperview()
                    self.present(vc, animated: true)
                }
            }
        }.resume()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
