//
//  SearchViewController.swift
//  RSS Reader
//
//  Created by Константин Головнев on 01/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit
import Firebase



class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate {
    
    var feedModel = FeedModel()

    let feedCellId = "feedCell"
    
    let searchBar = UISearchBar()
    let feedTableView = UITableView()
    let timeButton = UIButton()
    let sortButton = UIButton()
    let languageButton = UIButton()
    let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLogout()
        setupSearchBar()
        setupButton(button: timeButton, leftAnchor: view.leftAnchor, title: "date")
        setupButton(button: sortButton, leftAnchor: timeButton.rightAnchor, title: "sorted by")
        setupButton(button: languageButton, leftAnchor: sortButton.rightAnchor, title: "language")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: tableView setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedModel.massNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = feedTableView.dequeueReusableCell(withIdentifier: feedCellId, for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
        
        if feedModel.massNews[indexPath.row].title != nil {
            cell.titleLabel.text = feedModel.massNews[indexPath.row].title!
        } else {
            cell.titleLabel.text = ""
        }
        
        if feedModel.massNews[indexPath.row].publishedAt != nil {
            cell.publishedAtLabel.text = feedModel.massNews[indexPath.row].publishedAt!
        } else {
            cell.publishedAtLabel.text! = ""
        }
        
        if feedModel.massNews[indexPath.row].author != nil {
            cell.authorLabel.text = feedModel.massNews[indexPath.row].author!
        } else {
            cell.authorLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webViewController = WebViewController()
        guard feedModel.massNews[indexPath.row].url != nil else {
            return
        }
        webViewController.urlString = feedModel.massNews[indexPath.row].url!
        navigationController?.pushViewController(webViewController, animated: true)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        feedTableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: Search Settings
    
    func dateForSearch() -> String{
        let date = Date()
        let calendar = Calendar.current
        var year = calendar.component(.year, from: date)
        var month = calendar.component(.month, from: date)
        var day = calendar.component(.day, from: date)
        if time == timeIntervalArr[2] {
            if month != 1 {
                month -= 1
            } else {
                year -= 1
                month = 12
            }
        }
        
        if time == timeIntervalArr[1] {
            if day >= 7 {
                day -= 7
            } else if month != 1 {
                month -= 1
            } else {
                year -= 1
                month = 12
            }
        }
        return "&from=" + String(year) + "-" + String(month) + "-" + String(day)
    }
    
    func languageForSearch() -> String {
        guard language != nil else {
            return ""
        }
        let langStr = "&language=" + languageDictionary[language!]!
        return langStr
    }
    
    func sortBySearch() -> String {
        guard sorted != nil else {
            return ""
        }
        let sortStr = "&sortBy=" + sortedByDictionary[sorted!]!
        return sortStr
    }
    
    func decodeJSON() {
        guard let text = searchBar.text else { return }
        guard let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let urlString = "https://newsapi.org/v2/everything?q=" + searchText + dateForSearch() + languageForSearch() + sortBySearch() + "&apiKey=c3cbdce5c9c3479a92de13828bb33da3"
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
                self.feedModel.massNews = news.articles!
                DispatchQueue.main.async {
                    self.feedTableView.reloadData()
                    self.setupTableView()
                }
            } catch let err {
                print(err)
            }
            }.resume()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        decodeJSON()
    }
    
    // MARK: Settings alert
    
    @objc func showSettings(sender: UIButton) {
        let dictionary = createDictionary()
        createSettingsAlert(sender: sender, array: dictionary[sender]!)
    }
    
    func createDictionary() -> [UIButton:[String]] {
        let dictionary = [timeButton:timeIntervalArr, sortButton:sortedByArr, languageButton:languageArr]
        return dictionary
    }
    
    func createSettingsAlert(sender: UIButton, array: [String]) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for i in 0...array.count - 1 {
            alert.addAction(UIAlertAction(title: array[i], style: .default, handler: { (action) in
                self.tabBarController?.tabBar.isHidden = false
                self.setSetting(sender: sender, value: array[i])
            }))
        }
        checkmark(alert: alert, sender: sender, array: array)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            self.tabBarController?.tabBar.isHidden = false
        }))
        self.tabBarController?.tabBar.isHidden = true
        present(alert, animated: true, completion: nil)
    }
    
    func setSetting(sender: UIButton, value: String) {
        if sender == timeButton {
            time = value
            defaults.set(value, forKey: timeKey)
        }
        
        if sender == sortButton {
            sorted = value
            defaults.set(value, forKey: sortKey)
        }
        
        if sender == languageButton {
            language = value
            defaults.set(value, forKey: langKey)
        }
        decodeJSON()
    }
    
    func checkmark(alert: UIAlertController, sender: UIButton, array: [String]) {
        var setting = ""
        if sender == timeButton {
            setting = time!
        }
        
        if sender == sortButton {
            setting = sorted!
        }
        
        if sender == languageButton {
            setting = language!
        }
        alert.actions[array.firstIndex(of: setting)!].setValue(checkmarkImage, forKey: "image")
    }
}
