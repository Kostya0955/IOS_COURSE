//
//  FeedTVCellExtension.swift
//  RSS Reader
//
//  Created by Константин Головнев on 10/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit

extension FeedTableViewCell {
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
            ])
    }
    
    func setupPublishedAtLabel() {
        self.addSubview(publishedAtLabel)
        
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedAtLabel.font = UIFont.boldSystemFont(ofSize: 12)
        publishedAtLabel.textAlignment = .left
        publishedAtLabel.numberOfLines = 1
        publishedAtLabel.textColor = .gray
        
        NSLayoutConstraint.activate([
            publishedAtLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            publishedAtLabel.heightAnchor.constraint(equalToConstant: 20),
            publishedAtLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            publishedAtLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: 5)
            ])
    }
    
    func setupAuthorLabel() {
        self.addSubview(authorLabel)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        authorLabel.textAlignment = .right
        authorLabel.numberOfLines = 1
        authorLabel.textColor = .gray
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            authorLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0),
            authorLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5)
            ])
    }
}
