//
//  DiscoverViewController.swift
//  RSS Reader
//
//  Created by Константин Головнев on 11/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit
import CoreData

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let sourceCellId = "sourceCell"
    let searchBar = UISearchBar()
    let sourcesTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        if sourcesArr.isEmpty {
            DispatchQueue.global(qos: .utility).async {
                self.decodeSource()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourcesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sourcesTableView.dequeueReusableCell(withIdentifier: sourceCellId) as? SourceTableViewCell
        let source = sourcesArr[indexPath.row]
        cell?.sourceTitle.text = source.name
        cell?.id = source.id!
        cell?.index = indexPath.row
        cell?.added = source.addedToSubs
        
        if cell?.added != false {
            cell?.followButton.setImage(checkmarkImage, for: .normal)
            cell?.followButton.isUserInteractionEnabled = false
        } else {
            cell?.followButton.setImage(addImage, for: .normal)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(filter: searchBar.text)
    }
    
    func addSource(id: String, name: String, sourceDescription: String, url: String, category: String, language: String, country: String) {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Sources", in: context)
            let sourceObject = NSManagedObject(entity: entity!, insertInto: context) as! Sources
            sourceObject.id = id
            sourceObject.name = name
            sourceObject.sourceDescription = sourceDescription
            sourceObject.url = url
            sourceObject.category = category
            sourceObject.language = language
            sourceObject.country = country
            sourceObject.addedToSubs = false
            
            do {
                try context.save()
                sourcesArr.append(sourceObject)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func decodeSource() {
        let urlString = "https://newsapi.org/v2/sources?&apiKey=c3cbdce5c9c3479a92de13828bb33da3"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else {
                print(error!)
                return
            }
            do {
                let sources = try JSONDecoder().decode(SourcesStruct.self, from: data)
                guard sources.sources != nil else {
                    return
                }
                for i in 0...(sources.sources?.count)! - 1 {
                    self.addSource(id: sources.sources![i].id!, name: sources.sources![i].name!, sourceDescription: sources.sources![i].description!, url: sources.sources![i].url!, category: sources.sources![i].category!, language: sources.sources![i].language!, country: sources.sources![i].country!)
                }
            } catch let err {
                print(err)
            }
            }.resume()
    }
    
    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Sources> = Sources.fetchRequest()
        
        do {
            sourcesArr = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func reloadData(filter: String? = nil) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Sources> = Sources.fetchRequest()
        
        if let searchFilter = filter {
            let filterPredicate = NSPredicate(format: "name contains[c] '\(searchFilter)'")
            fetchRequest.predicate = filterPredicate
        }
        
        do {
            sourcesArr = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        DispatchQueue.main.async {
            self.setupTableView()
            self.sourcesTableView.reloadData()
        }
    }
    
    func deleteAllSources() {
        guard sourcesArr.count != 0 else {
            return
        }
        for i in 0...sourcesArr.count - 1 {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let sourceToDelete = sourcesArr[i]
            context.delete(sourceToDelete)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAllSubs() {
        guard subs.count != 0 else {
            return
        }
        for i in 0...subs.count - 1 {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let subsToDelete = subs[i]
            context.delete(subsToDelete)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
