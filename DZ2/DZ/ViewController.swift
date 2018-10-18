//
//  ViewController.swift
//  gallery_test
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    private let estimatedRowHeight: CGFloat = 136
    private let cellId = "GoodCell"
    private let segueName = "toGoodCard"
    private let cellId2 = "CustomCell"
    var model = FeedModel()
    
   
    @IBAction func nextViewClicked( sender: AnyObject) {
     
        print("Button press")
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.tintColor = UIColor.orange
        refreshControl.backgroundColor = UIColor.darkGray
        if #available(iOS 10.0, *){
            tableView.refreshControl = refreshControl
        } else {
        tableView.addSubview(refreshControl)
        }
        
    
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configureTableView() {
        tableView.backgroundColor = UIColor.red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.register(UINib(nibName: cellId2, bundle: nil), forCellReuseIdentifier: cellId2)
    }
    
    // количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.goods.count
    }
    
    // создание ячейки в строке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if((indexPath.row)%3 != 0){
             let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GoodCell
            cell.configureView(good: model.goods[indexPath.row])
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId2, for: indexPath)
            //  cell.textLabel?.text = " Это Ваша Реклама"
            
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if((indexPath.row)%3 != 0){
        let good = model.goods[indexPath.row]
        performSegue(withIdentifier: segueName, sender: good)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueName {
            guard
                let vc = segue.destination as? GoodViewController,
                let good = sender as? Good
                else { return }
            vc.good = good
        }
    }
    
}

