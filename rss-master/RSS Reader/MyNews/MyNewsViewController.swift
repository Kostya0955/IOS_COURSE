//
//  MyNewsViewController.swift
//  RSS Reader
//
//  Created by Константин Головнев on 10/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit
import CoreData

class MyNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newsModel = FeedModel()
    
    let newsCellId = "newsCell"
    let newsTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        decodeNews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.massNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: newsCellId, for: indexPath) as? NewsTableViewCell
        let article = newsModel.massNews[indexPath.row]
        cell?.newsTitle.text = article.title
        cell?.sourceName.text = article.source?.name
        guard article.urlToImage != nil else {
            return cell!
        }
        let url = URL(string: article.urlToImage!)
        let data = try? Data(contentsOf: url!)
        cell?.newsImage.image = UIImage(data: data!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webViewController = WebViewController()
        guard newsModel.massNews[indexPath.row].url != nil else {
            return
        }
        webViewController.urlString = newsModel.massNews[indexPath.row].url!
        navigationController?.pushViewController(webViewController, animated: true)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        newsTableView.deselectRow(at: indexPath, animated: false)
    }
    
    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Subscriptions> = Subscriptions.fetchRequest()
        
        do {
            subs = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func makeSources() -> String {
        guard subs.count != 0 else {
            return ""
        }
        var sources = String()
        for i in 0...subs.count - 1 {
            if i != subs.count - 1 {
                sources += subs[i].id! + ","
            } else {
                sources += subs[i].id!
            }
        }
        return sources
    }
    
    func decodeNews() {
        let urlString = "https://newsapi.org/v2/top-headlines?sources=" + makeSources() + "&apiKey=c3cbdce5c9c3479a92de13828bb33da3"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
            guard let data = data else { return }
            guard error == nil else {
                print(error!)
                return
            }
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                guard news.articles != nil else { return }
                self.newsModel.massNews = news.articles!
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                    self.setupTableView()
                }
            } catch let err {
                print(err)
            }
            }.resume()
    }
}
