//
//  DiscoverExtension.swift
//  RSS Reader
//
//  Created by Константин Головнев on 11/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit
import CoreData

extension DiscoverViewController {
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
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    func setupTableView() {
        view.addSubview(sourcesTableView)
        
        sourcesTableView.delegate = self
        sourcesTableView.dataSource = self
        
        sourcesTableView.translatesAutoresizingMaskIntoConstraints = false
        sourcesTableView.tableFooterView = UIView()
        sourcesTableView.allowsSelection = false
        sourcesTableView.register(SourceTableViewCell.self, forCellReuseIdentifier: sourceCellId)
        
        NSLayoutConstraint.activate([
            sourcesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            sourcesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            sourcesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            sourcesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            ])
    }
}

extension SourceTableViewCell {
    
    func setupFollowButton() {
        self.addSubview(followButton)
        followButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            followButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            followButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            followButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            followButton.widthAnchor.constraint(equalToConstant: 70)
            ])
        followButton.addTarget(self, action: #selector(addSource(sender:)), for: .touchUpInside)
    }
    
    func setupTitle() {
        self.addSubview(sourceTitle)
        sourceTitle.translatesAutoresizingMaskIntoConstraints = false
        sourceTitle.textColor = .darkGray
        sourceTitle.font = UIFont.boldSystemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            sourceTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            sourceTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            sourceTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            sourceTitle.rightAnchor.constraint(equalTo: followButton.leftAnchor, constant: 10)
            ])
    }
    
    @objc func addSource(sender: UIButton) {
        sender.setImage(checkmarkImage, for: .normal)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        sourcesArr[index].setValue(true, forKey: "addedToSubs")

        do {
            try context.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }

        let entitySubs = NSEntityDescription.entity(forEntityName: "Subscriptions", in: context)
        let sourceObjectSubs = NSManagedObject(entity: entitySubs!, insertInto: context) as! Subscriptions
        sourceObjectSubs.id = id

        do {
            try context.save()
            subs.append(sourceObjectSubs)
        } catch {
            print(error.localizedDescription)
        }
    }
}
