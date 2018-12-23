//
//  SearchVCExtension.swift
//  RSS Reader
//
//  Created by Константин Головнев on 11/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit
import Firebase

extension UISearchBar {
    
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func getSearchBarTextField() -> UITextField? {
        
        return getViewElement(type: UITextField.self)
    }
    
    func setTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.textColor = color
        }
    }
    
    func setTextFieldColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
                
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
    
    func setPlaceholderTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }
}

extension SearchViewController {
    
    func setupLogout() {
        let logoutImage = UIImage(named: "logout")
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setImage(logoutImage, for: .normal)
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            logoutButton.widthAnchor.constraint(equalToConstant: 50),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    @objc func logOut() {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginViewController()
            defaults.set(false, forKey: authKey)
            present(loginVC, animated: true, completion: nil)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.barStyle = .default
        searchBar.barTintColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .white
        searchBar.setTextFieldColor(color: customBlueColor)
        searchBar.setTextColor(color: .white)
        searchBar.setPlaceholderTextColor(color: .white)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            searchBar.rightAnchor.constraint(equalTo: logoutButton.leftAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    func setupButton(button: UIButton, leftAnchor: NSLayoutXAxisAnchor, title: String) {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
            ])
        
        button.setTitle(title, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(customBlueColor, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(showSettings(sender:)), for: .touchUpInside)
    }
    
    func setupTableView() {
        view.addSubview(feedTableView)
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.tableFooterView = UIView()
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: feedCellId)
        
        NSLayoutConstraint.activate([
            feedTableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 0),
            feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            feedTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            feedTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            ])
    }
    
}
