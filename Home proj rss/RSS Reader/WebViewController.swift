//
//  WebViewController.swift
//  RSS Reader
//
//  Created by Ануфриев Артем on 01/12/2018.
//  Copyright © 2018 Ануфриев Артем. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    var urlString = String()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
}
