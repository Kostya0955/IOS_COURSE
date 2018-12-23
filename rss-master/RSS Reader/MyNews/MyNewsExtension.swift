//
//  MyNewsExtension.swift
//  RSS Reader
//
//  Created by Константин Головнев on 10/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit

extension MyNewsViewController {
    func setupTableView() {
        view.addSubview(newsTableView)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.tableFooterView = UIView()
        
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: newsCellId)
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            newsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            newsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
    }
}

extension NewsTableViewCell {
    func setupImage() {
        self.addSubview(newsImage)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
//            newsImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
//            newsImage.widthAnchor.constraint(equalToConstant: 200),
            newsImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            newsImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            newsImage.heightAnchor.constraint(equalToConstant: 170)
            ])
    }
    
    func setupSourceName() {
        self.addSubview(sourceName)
        sourceName.translatesAutoresizingMaskIntoConstraints = false
        sourceName.textColor = .gray
        sourceName.font = UIFont.boldSystemFont(ofSize: 14)
        sourceName.numberOfLines = 1
        sourceName.textAlignment = .left

        NSLayoutConstraint.activate([
            sourceName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            sourceName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            sourceName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            sourceName.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    func setupNewsTitle() {
        self.addSubview(newsTitle)
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.textColor = .black
        newsTitle.font = UIFont.boldSystemFont(ofSize: 18)
        newsTitle.numberOfLines = 3
        newsTitle.textAlignment = .left
        
        NSLayoutConstraint.activate([
            newsTitle.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 3),
            newsTitle.bottomAnchor.constraint(equalTo: sourceName.topAnchor, constant: -3),
            newsTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            newsTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
            ])
    }
}
