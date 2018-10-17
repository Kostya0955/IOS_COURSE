//
//  FeedModel.swift
//   gallery_test
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import Foundation

final class FeedModel {
    var goods: [Good]
    
    init() {
        let good1 = Good(id: 1, image: #imageLiteral(resourceName: "img3"), name: "France Authentic\nJersey 2018", company: "NIKE", price: 138)
        let good2 = Good(id: 2, image: #imageLiteral(resourceName: "img2"), name: "Brasil Authentic\nJersey 2018", company: "NIKE", price: 149)
        let good3 = Good(id: 3, image: #imageLiteral(resourceName: "img3"), name: "Mexico Authentic\nJersey 2018", company: "ADIDAS", price: 99)
        let good4 = Good(id: 3, image: #imageLiteral(resourceName: "img3"), name: "Mexico Authentic\nJersey 2018", company: "ADIDAS", price: 99)
        let good5 = Good(id: 3, image: #imageLiteral(resourceName: "img3"), name: "Mexico Authentic\nJersey 2018", company: "ADIDAS", price: 99)
        let good6 = Good(id: 3, image: #imageLiteral(resourceName: "img3"), name: "Mexico Authentic\nJersey 2018", company: "ADIDAS", price: 99)
        let good7 = Good(id: 3, image: #imageLiteral(resourceName: "img3"), name: "Mexico Authentic\nJersey 2018", company: "ADIDAS", price: 99)
        let good8 = Good(id: 3, image: #imageLiteral(resourceName: "img3"), name: "Mexico Authentic\nJersey 2018", company: "ADIDAS", price: 99)
        goods = [good1, good2, good3, good4, good5, good6, good7, good8]
    }
}
